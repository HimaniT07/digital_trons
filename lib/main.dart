import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:himani_dtron/route/app_pages.dart';
import 'package:himani_dtron/utils/app_constants.dart';
import 'package:himani_dtron/utils/color_constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Helvetica Neue",
        primarySwatch: ColorConstants.appColor,
      ),
      initialRoute: Routes.splash,
      getPages: AppPages.routes,
      title: AppConstants.appName,

    );
  }
}