import 'package:dio/dio.dart';

class AuthApiService {
  final Dio _dio;

  AuthApiService({required Dio dio}) : _dio = dio;

  Future<dynamic> refresh({required String refresh}) async {
    return await _dio.post("auth/refresh/", data: {
      "refresh": refresh
    });
  }
}
