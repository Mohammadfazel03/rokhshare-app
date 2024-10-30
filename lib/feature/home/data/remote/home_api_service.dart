import 'package:dio/dio.dart';

class HomeApiService {
  final Dio _dio;

  HomeApiService({required Dio dio}) : _dio = dio;

  Future<dynamic> getSlider() async {
    return await _dio.get("slider/all/");
  }

  Future<dynamic> getCollections({int page = 1}) async {
    return await _dio.get("collection/", queryParameters: {"page": page});
  }
}
