import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rokhshare/feature/category/data/remote/category_api_service.dart';
import 'package:rokhshare/feature/category/data/repositories/category_repository.dart';
import 'package:rokhshare/feature/category/data/repositories/home_repository_impl.dart';
import 'package:rokhshare/feature/home/data/remote/home_api_service.dart';
import 'package:rokhshare/feature/home/data/repositories/home_repository.dart';
import 'package:rokhshare/feature/home/data/repositories/home_repository_impl.dart';
import 'package:rokhshare/feature/search/data/remote/search_api_service.dart';
import 'package:rokhshare/feature/search/data/repositories/search_repository.dart';
import 'package:rokhshare/feature/search/data/repositories/search_repository_impl.dart';
import 'package:rokhshare/feature/search/presentation/widgets/country_filter_section_widget/bloc/country_filter_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/genre_filter_section_widget/bloc/genre_filter_section_cubit.dart';

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

  getIt.registerSingleton<SearchApiService>(
      SearchApiService(dio: getIt.get()));
  getIt.registerSingleton<SearchRepository>(
      SearchRepositoryImpl(apiService: getIt.get()));

  // register bloc
  getIt.registerLazySingleton<GenreFilterSectionCubit>(
      () => GenreFilterSectionCubit(repository: getIt.get()));


  getIt.registerLazySingleton<CountryFilterSectionCubit>(
      () => CountryFilterSectionCubit(repository: getIt.get()));
}
