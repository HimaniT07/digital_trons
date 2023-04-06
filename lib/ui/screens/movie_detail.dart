
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/movie_response.dart';
import '../../utils/color_constants.dart';
import '../../utils/dimensions.dart';
import '../../utils/utility.dart';


class MovieDetailScreen extends StatelessWidget {

  MovieDetailScreen({Key? key}) : super(key: key);
  MovieDetailList movieDetails = MovieDetailList();

  @override
  Widget build(BuildContext context) {
    Dimensions.screenWidth = MediaQuery.of(context).size.width;
    Dimensions.screenHeight = MediaQuery.of(context).size.height;
    movieDetails = Get.arguments as MovieDetailList;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: ColorConstants.appColor,
        child: const Icon(Icons.movie),
      ),
      appBar: AppBar(
        title: Text(movieDetails.title ?? "Game"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: Utility.getImageFullPath(movieDetails.backdropPath ?? ""),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            ColorConstants.appColor,
                            Colors.transparent
                          ],
                        ))),
                Padding(
                  padding: const EdgeInsets.only(top: 80.0,left: 10.0),
                  child: CachedNetworkImage(
                    imageUrl: Utility.getImageFullPath(movieDetails.posterPath ?? ""),
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    height: 160,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Text(
                    'Release date: ${Utility.dateConverter(movieDetails.releaseDate!)}',
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    'Language: ${movieDetails.originalLanguage}',
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    'Popularity: ${movieDetails.popularity}',
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
              Text(movieDetails.overview ?? "",
                style: TextStyle(
                    fontSize: 16.0,
                    color: ColorConstants.appColor),
              )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
