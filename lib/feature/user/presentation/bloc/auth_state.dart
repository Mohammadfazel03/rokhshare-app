import 'package:rokhshare/utils/error_entity.dart';

enum AuthStatus {
  init,
  loading,
  error,
  success
}


class AuthState {
  String? email;
  String? username;
  int? days;
  bool? isPremium;
  bool isLogin;
  AuthStatus status;
  ErrorEntity? error;

  AuthState(
      {
      this.error,
      this.email,
      this.username,
      this.days,
      this.isPremium,
      this.isLogin = false,
      this.status = AuthStatus.init});

  AuthState copyWith({
    String? email,
    String? username,
    int? days,
    bool? isPremium,
    bool? isLogin,
    AuthStatus? status,
    ErrorEntity? error,
  }) {
    return AuthState(
      email: email ?? this.email,
      username: username ?? this.username,
      days: days ?? this.days,
      isPremium: isPremium ?? this.isPremium,
      isLogin: isLogin ?? this.isLogin,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}