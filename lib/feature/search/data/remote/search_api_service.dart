import 'package:dio/dio.dart';

class SearchApiService {
  final Dio _dio;

  SearchApiService({required Dio dio}) : _dio = dio;

  Future<dynamic> getGenres() async {
    return await _dio.get("genre/all/");
  }

  Future<dynamic> getCountries() async {
    return await _dio.get("country/all/");
  }
}
