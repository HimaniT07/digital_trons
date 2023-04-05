import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/movie_response.dart';
import '../network/dio_exception.dart';
import '../network/movies_api.dart';
import '../utils/app_constants.dart';

class MoviesRepository {

  final MoviesApi moviesApi;

  MoviesRepository(this.moviesApi);

  Future<MovieResponse> getTrendingMovies(int page) async {
    try {
      final response = await moviesApi.loadGetData(AppConstants.trendingUrl,  {'page': page});
      return MovieResponse.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<MovieResponse> getSearchedMovies(String movie) async {
    try {
      final response = await moviesApi.loadGetData(AppConstants.searchMovieUrl, {'query': movie});
      return MovieResponse.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}