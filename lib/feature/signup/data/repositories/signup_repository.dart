import 'dart:async';
import 'package:rokhshare/utils/data_response.dart';

abstract class SignupRepository {
  Future<DataResponse<void>> register({required String username,
    required String email,
    required String password,
    required String confirmPassword});

}
