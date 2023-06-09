class AppConstants {
  //App related
  static const String appName = 'Himani Practical';
  static const int appVersion = 1;

  //API related
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String tmdbAPIKey = 'c5a35901ce2efcbbf8b3a60fa86d59e9';
  static const String trendingUrl = '/trending/movie/day';
  static const String searchMovieUrl = '/search/movie';

  // receiveTimeout
  static const Duration receiveTimeout = Duration(seconds: 15000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(seconds: 15000);
  /*
Shared Pref
  */

  /*
  UI related
  */
  //dashboard
  static const String imageBasePath = 'https://image.tmdb.org/t/p/w185';
  static const String dashboardTitle = 'Treading Movie';
  static const String clearSearch = 'Clear Search';
  static const String tmdbWebSiteUrl = 'https://www.themoviedb.org/';
  static const String searchMovie = 'Search Movie';

  //validation
  static const String noInternet = 'Please check your internet connection';



}
