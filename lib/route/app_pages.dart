import 'package:get/get.dart';

import '../ui/screens/dashboard.dart';
import '../ui/screens/movie_detail.dart';
import '../ui/screens/splash_screen.dart';


part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
        name: Routes.splash,
        page: () => SplashScreen(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.dashboard,
        page: () => DashboardScreen(),
        transition: Transition.downToUp
        ),
    GetPage(
        name: Routes.movieDetail,
        page: () => MovieDetailScreen(),
        transition: Transition.downToUp
        ),
  ];
}
