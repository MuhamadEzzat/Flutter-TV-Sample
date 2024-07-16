import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class AppProvider extends GetConnect {
  final RxBool _networkUnAvailable = false.obs;

  @override
  void onInit() {
    httpClient.baseUrl = baseUrl;
    httpClient.maxAuthRetries = 1;
    httpClient.defaultContentType = 'application/form-data';
    httpClient.followRedirects = true;
    // httpClient.addRequestModifier<dynamic>((request) => updateHeaders(request));
    httpClient.timeout = const Duration(seconds: 10);
    // Initialize Network state listener
    ever(_networkUnAvailable, networkStatusChanged);
  }

  // Header:-----------------------------------------------------------------------

  void networkStatusChanged(bool networkUnAvailable) {
    if (networkUnAvailable == true) {
      // Open the Network error dialog in case no network available
      // Get.dialog(
      //     ChildErrorDialog(
      //       exitEnabled: false,
      //       onRefresh: () {
      //         shouldRetry();
      //       },
      //     ),
      //     barrierDismissible: false,
      //     useSafeArea: true,
      //     barrierColor: Colors.transparent);
    } else {
      if (Get.isDialogOpen != null && Get.isDialogOpen == true) {
        // Get.back(closeOverlays: true); // Closes the Network Dialog
      }
    }
  }

  // FutureOr<Request<dynamic>> updateHeaders(Request<dynamic> request) async {
  //   request.headers['Accept'] = 'application/json';
  //   request.headers['X-Requested-With'] = 'XMLHttpRequest';
  //
  //   User? user = FirebaseAuth.instance.currentUser;
  //   String? token = await user?.getIdToken();
  //   if (token != null) {
  //     request.headers['Authorization-Firebase'] = token;
  //     request.headers['X-Authorization-Firebase'] = token;
  //     request.headers['Connection'] = 'keep-alive';
  //   }
  //
  //   return request;
  // }

  Future<Response<dynamic>> handleNetworkError(
      Future<Response<dynamic>> response) {
    response.then((value) =>
        // Update the Network Availability status according to error returned in response
        _networkUnAvailable.value = (value.hasError &&
            (value.statusCode == null ||
                value.statusCode == HttpStatus.requestTimeout)));

    return response;
  }

  Future<bool> shouldRetry() async {
    if (_networkUnAvailable.value == false) {
      return false; // return instantly if network is already available => should not retry
    }
    await Future.delayed(
        const Duration(seconds: 5)); // Wait for appropriate time
    return _networkUnAvailable.value;
  }
}
