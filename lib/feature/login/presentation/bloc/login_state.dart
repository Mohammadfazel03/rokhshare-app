part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginFailed extends LoginState {
  final String error;

  LoginFailed({required this.error});
}

final class LoginSuccessfully extends LoginState {
  final LoginResponse loginResponse;

  LoginSuccessfully({required this.loginResponse});
}
