import 'package:dio/dio.dart';

const baseUrl = "http://192.168.27.1:8000/";


Dio getDioConfiguration() {
  var options = BaseOptions(baseUrl: '${baseUrl}api/v1/');
  final dio = Dio(options);
  return dio;
}
