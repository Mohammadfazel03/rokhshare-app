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

  // AuthState copyWith({
  //   String? refresh,
  //   String? access,
  //   String? email,
  //   int? days,
  //   bool? isPremium
  // }) {
  //   return AuthState(
  //     refresh: refresh ?? this.refresh,
  //   );
  // }
}