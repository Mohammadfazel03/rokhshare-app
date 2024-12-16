import 'package:dio/dio.dart';

class PlanApiService {
  final Dio _dio;

  PlanApiService({required Dio dio}) : _dio = dio;

  Future<dynamic> getPlans() async {
    return await _dio.get("plan/all/");
  }

  Future<dynamic> buy({required int price, required int plan}) async {
    return await _dio.post("payment/buy/", data: {
        "price": price,
        "tracking_code": 4861,
        "receipt_number": 45141,
        "plan": plan
    });
  }
}
