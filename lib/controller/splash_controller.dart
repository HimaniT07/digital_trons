import 'dart:async';
import 'package:get/get.dart';
import '../route/app_pages.dart';
import '../utils/dimensions.dart';
import 'base_controller.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    splashTimer();
    super.onInit();
  }

  void splashTimer() async {
    var _duration = Duration(
      seconds: Dimensions.screenLoadTime,
    );
    Timer(_duration, () async {
        Get.offNamedUntil(Routes.dashboard, (route) => false);
    });


  }
}
