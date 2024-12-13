import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rokhshare/feature/login/data/remote/model/login_response.dart';
import 'package:rokhshare/feature/login/data/repositories/login_repository.dart';
import 'package:rokhshare/utils/data_response.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _loginRepository;

  LoginCubit({required LoginRepository loginRepository})
      : _loginRepository = loginRepository,
        super(LoginInitial());

  Future<void> login(String username, String password) async {
    emit(LoginLoading());
    DataResponse<LoginResponse> response =
        await _loginRepository.login(username: username, password: password);
    if (response is DataFailed) {
      emit(LoginFailed(error: response.error ?? "مشکلی پیش آمده است"));
    } else {
      emit(LoginSuccessfully(loginResponse: response.data!));
    }
  }
}
