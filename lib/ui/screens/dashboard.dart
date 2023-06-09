import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/dashboard_controller.dart';
import '../../route/app_pages.dart';
import '../../utils/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../utils/color_constants.dart';
import '../../utils/utility.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController dashboardController = Get.put(DashboardController());

  DashboardScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    dashboardController.apiCallTrendingMovies(context);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: abbBarSearchWidget(context),
          ),
            floatingActionButton:FloatingActionButton(
              onPressed: () {
                Utility.launchTmdbURL(AppConstants.tmdbWebSiteUrl);
              },
              backgroundColor: ColorConstants.appColor,
              child: const Icon(
                Icons.movie_creation_outlined,
                color: ColorConstants.white,
              ),
            ),
          body: Obx(() {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: dashboardController.trendingMoviesArr.value.length != 0 ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: dashboardController.isGridView.value ? moviesInGrid() : moviesInList(),
                  ),
                ],
              ) : const Center(child: CircularProgressIndicator()),
            );
          }),
        ),
      ),
    );
  }

  abbBarSearchWidget(BuildContext context) {
    return Obx((){
      return   dashboardController.isSearchIconVisible.value ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(AppConstants.dashboardTitle,
              style: TextStyle(color: ColorConstants.white)),
          Row(
            children: [
              IconButton(
                icon: Icon(
                    dashboardController.isGridView.value
                        ? Icons.grid_view_sharp
                        : Icons.list,
                    color: Colors.white),
                onPressed: () {
                  dashboardController.isGridView.value =
                  !dashboardController.isGridView.value;
                },
              ),
              IconButton(icon: const Icon(Icons.search_rounded,color: Colors.white), onPressed: () {
                dashboardController.isSearchIconVisible.value = !dashboardController.isSearchIconVisible.value;
              },),
            ],
          )
        ],
      ) : TextField(
        autofocus: false,
        controller: dashboardController.searchTextController,
        decoration: InputDecoration(
            hintText: AppConstants.searchMovie,
            hintStyle: const TextStyle(color: Colors.white, fontSize: 14.0),
            border: InputBorder.none,
            suffixIcon: IconButton(icon: const Icon(Icons.close,color: Colors.white), onPressed: () {
              if(dashboardController.searchTextController.text.isNotEmpty){
                dashboardController.searchClosed(context);
              }
              dashboardController.isSearchIconVisible.value = !dashboardController.isSearchIconVisible.value;
            },)
        ),
        onChanged: (value){
          if(value.length > 3){
            dashboardController.apiCallSearchedMovies(context,value);
          }
        },
        style: const TextStyle(color: Colors.white, fontSize: 14.0),
      );
    });
  }

  moviesInGrid() {
    return GridView.builder(
      itemCount:
      dashboardController.trendingMoviesArr.value.length,
      controller: dashboardController.scrollController,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final movie =
        dashboardController.trendingMoviesArr[index];
        return InkWell(
          onTap: (){
            Get.toNamed(Routes.movieDetail,arguments: movie);
          },
          child: GridTile(
            footer: GridTileBar(
              title: Text(movie.title ?? ""),
            ),
            child: CachedNetworkImage(
              imageUrl: Utility.getImageFullPath(
                  movie.posterPath ?? ""),
              fit: BoxFit.fill,
              placeholder: (context, url) => const Padding(
                padding: EdgeInsets.all(50.0),
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        );
      },
    );
  }

  moviesInList() {
    return ListView.builder(
        itemCount: dashboardController.trendingMoviesArr.value.length,
        controller: dashboardController.scrollController,
        itemBuilder: (context, index) {
          final movie = dashboardController.trendingMoviesArr[index];
          return InkWell(
            onTap: (){
              Get.toNamed(Routes.movieDetail,arguments: movie);
            },
            child: Card(
              color: ColorConstants.grayE6,
              child: ListTile(
                title: Text(movie.title ?? ""),
                contentPadding:  const EdgeInsets.all(8.0),
                leading: CachedNetworkImage(
                  imageUrl: Utility.getImageFullPath(
                      movie.posterPath ?? ""),
                  fit: BoxFit.fill,
                  placeholder: (context, url) => const Padding(
                    padding: EdgeInsets.all(50.0),
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                ),
              ),
            ),
          );
        }
    );
  }
}
