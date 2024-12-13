import 'package:dio/dio.dart';
import 'package:rokhshare/feature/signup/data/remote/signup_api_service.dart';
import 'package:rokhshare/utils/data_response.dart';

import 'signup_repository.dart';

class SignupRepositoryImpl extends SignupRepository {
  final SignupApiService _api;

  SignupRepositoryImpl({required SignupApiService apiService})
      : _api = apiService;

  @override
  Future<DataResponse<void>> register(
      {required String username,
        required String email,
        required String password,
        required String confirmPassword}) async {
    try {
      Response response =
          await _api.register(username: username, email: email, password: password, confirmPassword: confirmPassword);
      if (response.statusCode == 201) {
        return const DataSuccess(null);
      }
      return const DataFailed('در برقراری ارتباط مشکلی پیش آمده است.');
    } catch (e) {
      if (e is DioException) {
        DioException exception = e;
        if (exception.response?.statusCode == 400) {
          if (exception.response?.data != null && exception.response?.data is Map) {
            Map<String, dynamic> data = exception.response!.data;
            var username = data['username'];
            var email = data['email'];
            var password = data['password'];
            if (username is List<dynamic> && username.isNotEmpty) {
              String? message = username.first.toString();
              switch(message) {
                case "A user with that username already exists.":
                  return const DataFailed('این نام کاربری موجود است.');
                case "This field is required.":
                  return const DataFailed('لطفا نام کاربری را وارد کنید.');
                default:
                  return DataFailed(message);
              }
            }
            if (email is List<dynamic> && email.isNotEmpty) {
              String? message = email.first.toString();
              switch(message) {
                case "This field must be unique.":
                  return const DataFailed('این ایمیل موجود است.');
                case "This field is required.":
                  return const DataFailed('لطفا نام کاربری را وارد کنید.');
                case "Enter a valid email address.":
                  return const DataFailed('لطفا یک ایمیل معتبر وارد کنید.');
                default:
                  return DataFailed(message);
              }
            }
            if (password is List<dynamic> && password.isNotEmpty) {
              String? message = password.first.toString();
              switch(message) {
                case "This password is too short. It must contain at least 8 characters.":
                  return const DataFailed('رمز عبور حداقل باید شامل 8 کارکتر باشد.');
                case "This password is too common.":
                  return const DataFailed('رمز عبور قوی تری انتخاب کنید.');
                case "This password is entirely numeric.":
                  return const DataFailed('رمز عبور قوی تری انتخاب کنید.');
                default:
                  return DataFailed(message);
              }
            }
          }
          return  DataFailed(exception.response?.data.toString() ?? "");
        }
      }
      return const DataFailed('در برقراری ارتباط مشکلی پیش آمده است.');
    }
  }
}
