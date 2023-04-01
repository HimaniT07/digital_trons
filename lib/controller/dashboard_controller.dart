import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/movie_response.dart';
import '../utils/app_constants.dart';
import '../utils/utility.dart';
import 'base_controller.dart';

class DashboardController extends BaseController {
  final trendingMoviesArr = <MovieDetailList>[].obs;
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final ScrollController scrollController = ScrollController();
  var isScroll = true;
  var isSearchIconVisible = true.obs;
  var isGridView = true.obs;
  var prevPage = 1.obs;
  TextEditingController searchTextController = TextEditingController();

  @override
  Future<void> onInit() async {
    if (await Utility.isConnected()) {
      getTrendingMovieList();
    } else {
      Get.snackbar("Failed to load Data", "Please connect to network");
    }
    super.onInit();
  }

  Future<void> getTrendingMovieList() async {
    try {
      isLoading.value = true;
      final data = await getTrendingMovies(currentPage.value);
      print('called');
      print(data);
      print(currentPage.value);
      print('called');
      if (currentPage.value == 1) {
        trendingMoviesArr.addAll(data.movieList ?? []);
      } else {
        if ((data.movieList?.length ?? 0) == 20) {
          // static 20 because, API returns 20 result as default.
          isScroll = true;
        } else {
          isScroll = false;
        }
        trendingMoviesArr.addAll(data.movieList ?? []);
      }
      totalPages.value = data.totalPages ?? 0;
      currentPage.value = currentPage.value + 1;
      onScroll();
      update();
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getSearchedMovieList(String movieStr) async {
    try {
      isLoading.value = true;
      final data = await getSearchedMovie(movieStr);
      trendingMoviesArr.clear();
      isScroll = true;
      totalPages.value = data.totalPages ?? 0;
      currentPage.value = currentPage.value + 1;
      trendingMoviesArr.addAll(data.movieList ?? []);
      currentPage.value = 0;
      update();
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  bool hasMorePages() {
    return currentPage.value < totalPages.value;
  }

  Dio dio = Dio(BaseOptions(
    baseUrl: AppConstants.baseUrl,
    queryParameters: {'api_key': AppConstants.tmdbAPIKey},
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  ));

  Future<MovieResponse> getTrendingMovies(int page) async {
    final response = await dio
        .get(AppConstants.trendingUrl, queryParameters: {'page': page});
    return MovieResponse.fromJson(response.data);
  }

  Future<MovieResponse> getSearchedMovie(String movie) async {
    final response = await dio
        .get(AppConstants.searchMovieUrl, queryParameters: {'query': movie});
    return MovieResponse.fromJson(response.data);
  }

  void onScroll() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        // check the position
        if (hasMorePages()) {
          if (isScroll && prevPage.value != currentPage.value) {
            getTrendingMovieList();
            prevPage.value = currentPage.value; // to prevent redundant call
          }
        }
      }
    });
  }

  launchTmdbURL() async {
    const url = 'https://www.themoviedb.org/';
    if (!await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url),);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
