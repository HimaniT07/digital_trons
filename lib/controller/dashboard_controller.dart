import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../model/movie_response.dart';
import '../network/service_locator.dart';
import '../repository/movies_repo.dart';
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
  final repo = getIt.get<MoviesRepository>();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future apiCallTrendingMovies(context) async {
    if (await Utility.isConnected()) {
      await repo.getTrendingMovies(currentPage.value).then((value) async {

        if (value != null) {
          isLoading.value = false;
          var data = value;
          if (data.totalPages != 0) {
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
            onScroll(context);
            trendingMoviesArr.refresh();
          }
        }
      }, onError: (e) {
        isLoading.value = false;
        trendingMoviesArr.refresh();
        Utility.showSnackBar(e.toString(), context, () {
          apiCallTrendingMovies(context);
        });
      });
    } else {
      Get.snackbar("Failed to load Data", "Please connect to network");
    }
  }

  Future apiCallSearchedMovies(context,movieStr) async {
    if (await Utility.isConnected()) {
      await repo.getSearchedMovies(movieStr).then((value) async {
        if (value != null) {
          var data = value;
          trendingMoviesArr.clear();
          isScroll = true;
          totalPages.value = data.totalPages ?? 0;
          currentPage.value = currentPage.value + 1;
          trendingMoviesArr.addAll(data.movieList ?? []);
          currentPage.value = 0;
          trendingMoviesArr.refresh();
        }
      }, onError: (e) {
        isLoading.value = false;
        trendingMoviesArr.refresh();
        Utility.showSnackBar(e.toString(), context, () {
          apiCallSearchedMovies(context,movieStr);
        });
      });
    } else {
      Get.snackbar("Failed to load Data", "Please connect to network");
    }

  }

  void onScroll(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        // check the position
        if (Utility.hasMorePages(currentPage.value, totalPages.value)) {
          if (isScroll && prevPage.value != currentPage.value) {
            apiCallTrendingMovies(context);
            prevPage.value = currentPage.value; // to prevent redundant call
          }
        }
      }
    });
  }

  void searchClosed(context) {
    searchTextController.text = ""; // to clear
    trendingMoviesArr.clear();
    currentPage.value = 1;
    apiCallTrendingMovies(context);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
