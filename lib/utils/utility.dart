import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'color_constants.dart';
import 'dimensions.dart';

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

  static Widget? hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    return null;
  }

  static void snackBar(String msg, BuildContext context) {
    var snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  static Widget buildProgressIndicator() {
    return Container(
      height: Dimensions.screenHeight,
      color: ColorConstants.black.withOpacity(0.4),
      child: const Center(
        child: CircularProgressIndicator(
          backgroundColor: ColorConstants.blue,
          valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.white),
        ),
      ),
    );
  }
}
