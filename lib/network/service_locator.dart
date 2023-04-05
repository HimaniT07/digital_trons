import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../repository/movies_repo.dart';
import 'dio_client.dart';
import 'movies_api.dart';



final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(MoviesApi(dioClient: getIt<DioClient>()));
  getIt.registerSingleton(MoviesRepository(getIt.get<MoviesApi>()));
}
