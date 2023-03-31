import 'dart:async';
import 'package:get/get.dart';
import '../utils/utility.dart';
import 'base_controller.dart';

class DashboardController extends BaseController {

  @override
  Future<void> onInit() async {
    if(await Utility.isConnected()){

    }else{
      Get.snackbar("Failed to load Data", "Please connect to network");
    }
    super.onInit();
  }
}
