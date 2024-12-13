import 'dart:async';
import 'package:rokhshare/feature/login/data/remote/model/login_response.dart';
import 'package:rokhshare/utils/data_response.dart';

abstract class AuthRepository {
  Future<DataResponse<LoginResponse>> refresh({required String refresh});

}
