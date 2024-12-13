import 'package:bloc/bloc.dart';
import 'package:rokhshare/config/local_storage_service.dart';
import 'package:rokhshare/feature/login/data/remote/model/login_response.dart';
import 'package:rokhshare/feature/user/data/repositories/auth_repository.dart';
import 'package:rokhshare/feature/user/presentation/bloc/auth_state.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/error_entity.dart';

class AuthCubit extends Cubit<AuthState> {
  final LocalStorageService localStorageService;
  final AuthRepository authRepository;

  AuthCubit({required this.localStorageService, required this.authRepository})
      : super(AuthState()) {
    init();
  }

  void init() async {
    var res = await localStorageService.isLogin();
    var refresh = await localStorageService.getRefreshToken();
    if (res == true && refresh != null) {
      emit(AuthState(
        isLogin: true,
        status: AuthStatus.loading,
      ));
      DataResponse<LoginResponse> response =
          await authRepository.refresh(refresh: refresh);
      if (response is DataFailed) {
        if (response.code == -1) {
          logout();
        }
        emit(AuthState(
          isLogin: true,
          status: AuthStatus.error,
          error: ErrorEntity(
              title: "", error: response.error ?? "", code: response.code),
          email: await localStorageService.getEmail(),
          username: await localStorageService.getUsername(),
          days: await localStorageService.getDays(),
          isPremium: await localStorageService.isPremium(),
        ));
      } else {
        login(response.data!.access!, refresh, response.data!.isPremium!,
            response.data!.days, response.data!.email!, response.data!.username!);
      }
    } else {
      emit(AuthState(status: AuthStatus.success));
    }
  }

  Future<void> login(String accessToken, String refreshToken, bool isPremium,
      int? days, String email, String username) async {
    await localStorageService.login(
        accessToken, refreshToken, isPremium, days, email, username);
    emit(AuthState(
        status: AuthStatus.success,
        isPremium: isPremium,
        days: days,
        email: email,
        username: username,
        isLogin: true));
  }

  void logout() {
    localStorageService.logout();
    emit(AuthState(isLogin: false, status: AuthStatus.success));
  }
}
