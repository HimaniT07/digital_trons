import 'package:dio/dio.dart';
import 'package:himani_dtron/utils/app_constants.dart';

class DioClient {
  // dio instance
  final Dio _dio;

  // injecting dio instance
  DioClient(this._dio) {
    _dio
      ..options.baseUrl = AppConstants.baseUrl
      ..options.connectTimeout = AppConstants.connectionTimeout
      ..options.receiveTimeout = AppConstants.receiveTimeout
      ..options.responseType = ResponseType.json
      ..options.queryParameters = {'api_key': AppConstants.tmdbAPIKey}
      ..options.responseType = ResponseType.json
      ..options.contentType = Headers.jsonContentType
      ..interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ));
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}