import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/dashboard_controller.dart';
import '../../utils/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../utils/color_constants.dart';
import '../../utils/utility.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController dashboardController = Get.put(DashboardController());

  DashboardScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Obx((){
              return   dashboardController.isSearchIconVisible.value ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(AppConstants.dashboardTitle,
                      style: TextStyle(color: ColorConstants.white)),
                  IconButton(icon: const Icon(Icons.search_rounded,color: Colors.white), onPressed: () {
                    dashboardController.isSearchIconVisible.value = !dashboardController.isSearchIconVisible.value;
                  },)
                ],
              ) : TextField(
                autofocus: false,
                controller: dashboardController.searchTextController,
                decoration: InputDecoration(
                    hintText: "Search Movie",
                    hintStyle: const TextStyle(color: Colors.white, fontSize: 14.0),
                    border: InputBorder.none,
                    suffixIcon: IconButton(icon: const Icon(Icons.close,color: Colors.white), onPressed: () {
                      dashboardController.searchTextController.text = ""; // to clear
                      dashboardController.isSearchIconVisible.value = !dashboardController.isSearchIconVisible.value;
                      dashboardController.trendingMoviesArr.clear();
                      dashboardController.currentPage.value = 1;
                      dashboardController.getTrendingMovieList();
                    },)
                ),
                onChanged: (value){
                  if(value.length > 3){
                    dashboardController.getSearchedMovieList(value);
                  }
                },
                style: const TextStyle(color: Colors.black, fontSize: 14.0),
              );
            }),
          ),
          body: Obx(() {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: GridView.builder(
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
                        return GridTile(
                          footer: GridTileBar(
                            title: Text(movie.title ?? ""),
                          ),
                          child: InkWell(
                            onTap: (){
                              dashboardController.launchTmdbURL();
                            },
                            child: CachedNetworkImage(
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
