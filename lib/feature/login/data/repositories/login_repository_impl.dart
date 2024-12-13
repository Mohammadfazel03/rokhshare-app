import 'package:dio/dio.dart';
import 'package:rokhshare/feature/login/data/remote/login_api_service.dart';
import 'package:rokhshare/feature/login/data/remote/model/login_response.dart';
import 'package:rokhshare/utils/data_response.dart';

import 'login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginApiService _api;

  LoginRepositoryImpl({required LoginApiService apiService})
      : _api = apiService;

  @override
  Future<DataResponse<LoginResponse>> login(
      {required String username, required String password}) async {
    try {
      Response response =
          await _api.login(username: username, password: password);
      if (response.statusCode == 200) {
        return DataSuccess(LoginResponse.fromJson(response.data));
      }
      return const DataFailed('در برقراری ارتباط مشکلی پیش آمده است.');
    } catch (e) {
      if (e is DioException) {
        DioException exception = e;
        if (exception.response?.statusCode == 403) {
          return const DataFailed('حساب کاربری فعالی با این نام کاربری و رمزعبور وجود ندارد');
        }
      }
      return const DataFailed('در برقراری ارتباط مشکلی پیش آمده است.');
    }
  }
}
