import 'package:dio/dio.dart';

class CategoryApiService {
  final Dio _dio;

  CategoryApiService({required Dio dio}) : _dio = dio;

  Future<dynamic> getCategories({int page = 1}) async {
    return await _dio.get("genre/", queryParameters: {"page": page});
  }
}
