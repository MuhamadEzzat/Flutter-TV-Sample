import 'package:flutter/cupertino.dart';
import 'package:get/get_connect.dart';

import '../../core/values/endpoint_constants.dart';
import '../enums/content_type.dart';
import '../exceptions/network_exception.dart';
import '../models/directory_search_results_model.dart';
import '../models/episode_model.dart';
import '../models/radio_model.dart';
import '../models/values_model.dart';
import 'app_provider.dart';

class JosoorProvider extends AppProvider {
  Future<DirectorySearchResult> makeSearchDirectoryRequest(
      String searchQuery) async {
    Response<dynamic> result;
    FormData formData = FormData({
      "Name": searchQuery,
    });
    do {
      result = await handleNetworkError(post(
        EndPoints.searchDirectory,
        formData,
        decoder: (json) => DirectorySearchResult.fromJson(json),
      ));
    } while (await shouldRetry());
    if (!result.isOk) {
      return DirectorySearchResult.withError(
        NetworkException(result).toString(),
      );
    }
    return result.body;
  }

  Future<Radios> getRadios() async {
    Response<dynamic> result;

    do {
      result = await handleNetworkError(get(
        EndPoints.getRadio,
        decoder: (json) => Radios.fromJson(json),
      ));
    } while (await shouldRetry());
    if (!result.isOk) {
      return Radios.withError(
        NetworkException(result).toString(),
      );
    }
    return result.body;
  }
}
