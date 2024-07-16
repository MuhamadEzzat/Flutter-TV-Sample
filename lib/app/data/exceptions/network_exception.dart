import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';

import 'app_exception.dart';

class NetworkException extends AppException {
  final Response _networkResponse;

  NetworkException(this._networkResponse) : super(_networkResponse.statusText);

  @override
  String toString() {
    Map<String, dynamic> responseJson =
        jsonDecode(_networkResponse.bodyString!);
    String errorMessage = '';
    if (responseJson.containsKey('message')) {
      if (responseJson['message'] is Map) {
        Map<String, dynamic> errorsMap = responseJson['message'];
        errorsMap.forEach((key, value) {
          errorMessage += '$value ';
        });
      } else if (responseJson['message'] is String) {
        errorMessage = responseJson['message'];
      }
    } else {
      errorMessage = "LocalKeys.kGenericErrorMessage.tr";
    }
    return errorMessage;
  }
}
