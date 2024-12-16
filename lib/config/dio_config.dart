import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rokhshare/config/local_storage_service.dart';

const baseUrl = "http://192.168.27.1:8000/";

class DioInterceptor extends Interceptor {
  final Dio _dio;
  final LocalStorageService _localStorageService;

  DioInterceptor(
      {required Dio dio, required LocalStorageService localStorageService})
      : _dio = dio,
        _localStorageService = localStorageService;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await _localStorageService.getAccessToken();
    if (accessToken != null) {
      options.headers.addAll({"Authorization": "Bearer $accessToken"});
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != HttpStatus.forbidden ||
        err.requestOptions.isRetriedAttempt ||
        await _localStorageService.isLogin() != true) {
      handler.next(err);
      return;
    }
    if (await refreshToken()) {
      try {
        final options = err.requestOptions;
        final data = options.data;
        final newOptions = options.retryWith(
          data: data is FormData ? data.clone() : data,
        );
        final response = await _dio.fetch(newOptions);
        handler.resolve(response);
      } on DioException catch (e) {
        handler.next(e);
      }
    } else {
      handler.next(err);
    }
  }

  Future<bool> refreshToken() async {
    try {
      var response = await _dio.post("auth/refresh/",
          data: {"refresh": await _localStorageService.getRefreshToken()});
      if (response.statusCode == 200) {
        await _localStorageService.updateAccessToken(response.data['access']);
        return true;
      }
    } catch (e) {
      await _localStorageService.logout();
    }
    return false;
  }
}

const _retryExtraTag = 'isRetry';

extension on RequestOptions {
  RequestOptions retryWith({
    Object? data,
  }) {
    return copyWith(
      extra: {
        _retryExtraTag: true,
        ...extra,
      },
      data: data ?? this.data,
    );
  }

  bool get isRetriedAttempt => extra[_retryExtraTag] == true;
}

Dio getDioConfiguration(LocalStorageService localStorageService) {
  var options = BaseOptions(baseUrl: '${baseUrl}api/v1/');
  final dio = Dio(options);
  dio.interceptors
      .add(DioInterceptor(dio: dio, localStorageService: localStorageService));
  return dio;
}
