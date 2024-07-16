import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ResponseModel {
  final bool success;
  final String? message;
  final dynamic data;

  ResponseModel({
    required this.success,
    this.message,
    required this.data,
  });

  factory ResponseModel.fromResponse(Response? response, String? dataKey) {
    try {
      return ResponseModel(
          success: response?.statusCode == 200,
          data: dataKey == null ? response?.data : response?.data[dataKey]);
    } catch (error) {
      debugPrint('Error in getting result from the response: $error');
      return ResponseModel(
          success: false, data: null, message: error.toString());
    }
  }
}
