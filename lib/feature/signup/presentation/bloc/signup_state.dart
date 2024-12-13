part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupFailed extends SignupState {
  final String error;

  SignupFailed({required this.error});
}

final class SignupSuccessfully extends SignupState {
  SignupSuccessfully();
}
