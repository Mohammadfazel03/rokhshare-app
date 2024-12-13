import 'dart:async';
import 'package:rokhshare/feature/login/data/remote/model/login_response.dart';
import 'package:rokhshare/utils/data_response.dart';

abstract class LoginRepository {
  Future<DataResponse<LoginResponse>> login({required String username, required String password});

}
