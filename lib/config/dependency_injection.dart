import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rokhshare/config/local_storage_service.dart';
import 'package:rokhshare/feature/category/data/remote/category_api_service.dart';
import 'package:rokhshare/feature/category/data/repositories/category_repository.dart';
import 'package:rokhshare/feature/category/data/repositories/home_repository_impl.dart';
import 'package:rokhshare/feature/home/data/remote/home_api_service.dart';
import 'package:rokhshare/feature/home/data/repositories/home_repository.dart';
import 'package:rokhshare/feature/home/data/repositories/home_repository_impl.dart';
import 'package:rokhshare/feature/login/data/remote/login_api_service.dart';
import 'package:rokhshare/feature/login/data/repositories/login_repository.dart';
import 'package:rokhshare/feature/login/data/repositories/login_repository_impl.dart';
import 'package:rokhshare/feature/media_items/data/remote/media_items_api_service.dart';
import 'package:rokhshare/feature/media_items/data/repositories/media_items_repository.dart';
import 'package:rokhshare/feature/media_items/data/repositories/media_items_repository_impl.dart';
import 'package:rokhshare/feature/search/data/remote/search_api_service.dart';
import 'package:rokhshare/feature/search/data/repositories/search_repository.dart';
import 'package:rokhshare/feature/search/data/repositories/search_repository_impl.dart';
import 'package:rokhshare/feature/search/presentation/widgets/country_filter_section_widget/bloc/country_filter_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/date_filter_section_widget/bloc/date_filter_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/genre_filter_section_widget/bloc/genre_filter_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/sort_by_section_widget/bloc/sort_by_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/type_section_widget/bloc/type_section_cubit.dart';
import 'package:rokhshare/feature/signup/data/remote/signup_api_service.dart';
import 'package:rokhshare/feature/signup/data/repositories/signup_repository.dart';
import 'package:rokhshare/feature/user/data/remote/auth_api_service.dart';
import 'package:rokhshare/feature/user/data/repositories/auth_repository.dart';
import 'package:rokhshare/feature/user/data/repositories/auth_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../feature/signup/data/repositories/signup_repository_impl.dart';
import 'dio_config.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  // register local storage services
  getIt.registerSingletonAsync<SharedPreferencesAsync>(() async => SharedPreferencesAsync());
  getIt.registerSingletonWithDependencies<LocalStorageService>(() =>
      LocalStorageService(preferences: getIt.get<SharedPreferencesAsync>()), dependsOn: [SharedPreferencesAsync]);

  // register remote services
  getIt.registerSingleton<Dio>(getDioConfiguration());

  getIt.registerSingleton<HomeApiService>(HomeApiService(dio: getIt.get()));
  getIt.registerSingleton<HomeRepository>(
      HomeRepositoryImpl(apiService: getIt.get()));

  getIt.registerSingleton<CategoryApiService>(
      CategoryApiService(dio: getIt.get()));
  getIt.registerSingleton<CategoryRepository>(
      CategoryRepositoryImpl(apiService: getIt.get()));

  getIt.registerSingleton<SearchApiService>(SearchApiService(dio: getIt.get()));
  getIt.registerSingleton<SearchRepository>(
      SearchRepositoryImpl(apiService: getIt.get()));

  getIt.registerSingleton<MediaItemsApiService>(
      MediaItemsApiService(dio: getIt.get()));
  getIt.registerSingleton<MediaItemsRepository>(
      MediaItemsRepositoryImpl(api: getIt.get()));

  getIt.registerLazySingleton<LoginApiService>(
      () => LoginApiService(dio: getIt.get()));
  getIt.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(apiService: getIt.get()));

  getIt.registerLazySingleton<SignupApiService>(
      () => SignupApiService(dio: getIt.get()));
  getIt.registerLazySingleton<SignupRepository>(
      () => SignupRepositoryImpl(apiService: getIt.get()));


  getIt.registerLazySingleton<AuthApiService>(
      () => AuthApiService(dio: getIt.get()));
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(apiService: getIt.get()));

  // register bloc
  getIt.registerLazySingleton<GenreFilterSectionCubit>(
      () => GenreFilterSectionCubit(repository: getIt.get()));

  getIt.registerLazySingleton<CountryFilterSectionCubit>(
      () => CountryFilterSectionCubit(repository: getIt.get()));

  getIt.registerLazySingleton<DateFilterSectionCubit>(
      () => DateFilterSectionCubit());

  getIt.registerLazySingleton<SortBySectionCubit>(() => SortBySectionCubit());

  getIt.registerLazySingleton<TypeSectionCubit>(() => TypeSectionCubit());

  await getIt.allReady();
}
