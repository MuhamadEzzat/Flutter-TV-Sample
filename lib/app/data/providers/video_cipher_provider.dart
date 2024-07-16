import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/values/endpoint_constants.dart';
import '../exceptions/network_exception.dart';
import '../models/vdo_cipher_data_model.dart';
import 'app_provider.dart';

class CipherProvider extends AppProvider {
  Future<VdoCipherData> getvdoCipherData(String vdoId) async {
    FormData formData = FormData({'video_key': vdoId});
    Response<dynamic> result;
    do {
      result = await handleNetworkError(post(
        EndPoints.VDOCIPHERURL,
        formData,
        decoder: (json) {
          debugPrint("vdo cipher json ${json}");
          return VdoCipherData.fromJson(json);
        },
      ));
    } while (await shouldRetry());
    if (!result.isOk) {
      throw NetworkException(result);
    }
    return result.body;
  }
}
