import 'package:dio/dio.dart';

class LoginApiService {
  final Dio _dio;

  LoginApiService({required Dio dio}) : _dio = dio;

  Future<dynamic> login(
      {required String username, required String password}) async {
    return await _dio.post("auth/login/",
        data: {"username": username, "password": password});
  }
}
