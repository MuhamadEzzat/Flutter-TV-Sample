import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  DioClient._();

  static final DioClient instance = DioClient._();
  static const int receiveTimeout = 30000;
  static const int connectionTimeout = 30000;

  final Dio _dio = Dio(BaseOptions(
    connectTimeout: Duration(milliseconds: connectionTimeout),
    receiveTimeout: Duration(milliseconds: receiveTimeout),
  ));

  // Header:-----------------------------------------------------------------------
  // Future<Map<String, dynamic>?> getHeaders() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   String? token = await user?.getIdToken();
  //   //debugPrint('Token: $token');
  //   return token != null
  //       ? {
  //           "Authorization-Firebase": token,
  //           "X-Authorization-Firebase": token,
  //           'Connection': 'keep-alive'
  //         }
  //       : null;
  // }

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      debugPrint("GET url: $uri");
      // Options opts = Options(headers: await getHeaders());
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        // options: options ?? opts,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      debugPrint("$uri ResponseCode: ${response.statusCode}");
      return response;
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String uri, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      debugPrint("POST url: $uri, with parameters: $queryParameters");
      // Options opts = Options(headers: await getHeaders());
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        // options: options ?? opts,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      debugPrint("$uri ResponseCode: ${response.statusCode}");
      return response;
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }

  // Delete:----------------------------------------------------------------------
  Future<Response> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      debugPrint("DELETE url: $uri");
      // Options opts = Options(headers: await getHeaders());
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        // options: options ?? opts,
        cancelToken: cancelToken,
      );
      debugPrint("$uri ResponseCode: ${response.statusCode}");
      return response;
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }

  // Put:----------------------------------------------------------------------
  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      debugPrint("PUT url: $uri");
      // Options opts = Options(headers: await getHeaders());
      final Response response = await _dio.put(uri,
          data: data,
          queryParameters: queryParameters,
          // options: options ?? opts,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      debugPrint("$uri ResponseCode: ${response.statusCode}");
      return response;
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }
}
