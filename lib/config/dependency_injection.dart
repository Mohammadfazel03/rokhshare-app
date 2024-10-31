import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rokhshare/feature/category/data/remote/category_api_service.dart';
import 'package:rokhshare/feature/category/data/repositories/category_repository.dart';
import 'package:rokhshare/feature/category/data/repositories/home_repository_impl.dart';
import 'package:rokhshare/feature/home/data/remote/home_api_service.dart';
import 'package:rokhshare/feature/home/data/repositories/home_repository.dart';
import 'package:rokhshare/feature/home/data/repositories/home_repository_impl.dart';

import 'dio_config.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  // register remote services
  getIt.registerSingleton<Dio>(getDioConfiguration());

  getIt.registerSingleton<HomeApiService>(HomeApiService(dio: getIt.get()));
  getIt.registerSingleton<HomeRepository>(
      HomeRepositoryImpl(apiService: getIt.get()));

  getIt.registerSingleton<CategoryApiService>(
      CategoryApiService(dio: getIt.get()));
  getIt.registerSingleton<CategoryRepository>(
      CategoryRepositoryImpl(apiService: getIt.get()));
}
