import 'package:dio/dio.dart';
import 'package:rokhshare/feature/home/data/remote/model/country.dart';
import 'package:rokhshare/feature/home/data/remote/model/genre.dart';
import 'package:rokhshare/feature/search/data/remote/search_api_service.dart';
import 'package:rokhshare/utils/data_response.dart';

import 'search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchApiService _api;

  SearchRepositoryImpl({required SearchApiService apiService})
      : _api = apiService;

  @override
  Future<DataResponse<List<Genre>>> getGenres() async {
    try {
      Response response = await _api.getGenres();
      if (response.statusCode == 200) {
        List<Genre> genres =
            ((response.data) as List).map((e) => Genre.fromJson(e)).toList();
        return DataSuccess(genres);
      }
      return const DataFailed('در برقرای ارتباط مشکلی پیش آمده است.');
    } catch (e) {
      if (e is DioException) {
        DioException exception = e;
        int cat = ((exception.response?.statusCode ?? 0) / 100).round();
        if (cat == 5) {
          return const DataFailed('سایت در حال تعمیر است بعداً تلاش کنید.');
        }
      }
      return const DataFailed('در برقرای ارتباط مشکلی پیش آمده است.');
    }
  }

  @override
  Future<DataResponse<List<Country>>> getCountries() async {
    try {
      Response response = await _api.getCountries();
      if (response.statusCode == 200) {
        List<Country> countries =
            ((response.data) as List).map((e) => Country.fromJson(e)).toList();
        return DataSuccess(countries);
      }
      return const DataFailed('در برقرای ارتباط مشکلی پیش آمده است.');
    } catch (e) {
      if (e is DioException) {
        DioException exception = e;
        int cat = ((exception.response?.statusCode ?? 0) / 100).round();
        if (cat == 5) {
          return const DataFailed('سایت در حال تعمیر است بعداً تلاش کنید.');
        }
      }
      return const DataFailed('در برقرای ارتباط مشکلی پیش آمده است.');
    }
  }
}
