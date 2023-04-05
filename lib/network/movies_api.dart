import 'package:dio/dio.dart';
import 'package:himani_dtron/network/dio_client.dart';

class MoviesApi {
  final DioClient? dioClient;

  MoviesApi({this.dioClient});

  Future<Response> loadGetData(endpoint, query) async {
    try {
      final Response response = await dioClient!.get(
        endpoint,
        queryParameters: query
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
