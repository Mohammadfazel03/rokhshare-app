import 'package:dio/dio.dart';
import 'package:rokhshare/feature/login/data/remote/model/login_response.dart';
import 'package:rokhshare/feature/user/data/remote/auth_api_service.dart';
import 'package:rokhshare/utils/data_response.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthApiService _api;

  AuthRepositoryImpl({required AuthApiService apiService}) : _api = apiService;

  @override
  Future<DataResponse<LoginResponse>> refresh({required String refresh}) async {
    try {
      Response response = await _api.refresh(refresh: refresh);
      if (response.statusCode == 200) {
        return DataSuccess(LoginResponse.fromJson(response.data));
      }
      return const DataFailed('در برقراری ارتباط مشکلی پیش آمده است.');
    } catch (e) {
      if (e is DioException) {
        DioException exception = e;
        if (exception.response?.statusCode == 403) {
          return const DataFailed(
              'حساب کاربری فعالی با این نام کاربری و رمزعبور وجود ندارد',
              code: -1);
        }
      }
      return const DataFailed('در برقراری ارتباط مشکلی پیش آمده است.');
    }
  }
}
