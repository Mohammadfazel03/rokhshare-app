import 'package:dio/dio.dart';

class SignupApiService {
  final Dio _dio;

  SignupApiService({required Dio dio}) : _dio = dio;

  Future<dynamic> register(
      {required String username,
      required String email,
      required String password,
      required String confirmPassword}) async {
    return await _dio.post("auth/register/", data: {
      "username": username,
      "password": password,
      "email": email,
      "password2": confirmPassword
    });
  }
}
