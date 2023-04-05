import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_constants.dart';

class Utility {
  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (kDebugMode) {
        print('Internet mode : mobile');
      }
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (kDebugMode) {
        print('Internet mode : wifi');
      }
      return true;
    }
    return false;
  }

  static String getImageFullPath(String path){
    return AppConstants.imageBasePath + path;
  }

  static bool hasMorePages(currentPage, totalPage) {
    return currentPage < totalPage;
  }


  static launchTmdbURL(url) async {
    try{
      await launchUrl(Uri.parse(url),);
    } catch(e){
      if(kDebugMode){
        print(e);
      }
    }
  }

  static void showSnackBar(error, context, onRetry) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black,
      content: Text(error),
      duration: const Duration(milliseconds: 3000),
      action: SnackBarAction(
        label: 'Retry',
        onPressed: () {
          onRetry();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
