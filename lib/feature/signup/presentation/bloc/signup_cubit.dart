import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rokhshare/feature/signup/data/repositories/signup_repository.dart';
import 'package:rokhshare/utils/data_response.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepository _signupRepository;

  SignupCubit({required SignupRepository signupRepository})
      : _signupRepository = signupRepository,
        super(SignupInitial());

  Future<void> register(String username, String email, String password) async {
    emit(SignupLoading());
    DataResponse<void> response = await _signupRepository.register(
        username: username,
        email: email,
        password: password,
        confirmPassword: password);
    if (response is DataFailed) {
      emit(SignupFailed(error: response.error ?? "مشکلی پیش آمده است"));
    } else {
      emit(SignupSuccessfully());
    }
  }

  void init() {
    emit(SignupInitial());
  }
}
