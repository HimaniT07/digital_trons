
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/splash_controller.dart';
import '../../utils/color_constants.dart';
import '../../utils/dimensions.dart';
import '../../utils/image_paths.dart';


class SplashScreen extends StatelessWidget {
  final SplashController _splashControllerController = Get.put(SplashController());

  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Dimensions.screenWidth = MediaQuery.of(context).size.width;
    Dimensions.screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: ColorConstants.white,
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.logo,
                height: Dimensions.screenHeight / 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
