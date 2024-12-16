import 'package:dio/dio.dart';
import 'package:rokhshare/feature/plan/data/remote/model/plan.dart';
import 'package:rokhshare/feature/plan/data/remote/model/subscription_plan.dart';
import 'package:rokhshare/feature/plan/data/remote/plan_api_service.dart';
import 'package:rokhshare/utils/data_response.dart';

import 'plan_repository.dart';

class PlanRepositoryImpl extends PlanRepository {
  final PlanApiService _api;

  PlanRepositoryImpl({required PlanApiService apiService}) : _api = apiService;

  @override
  Future<DataResponse<List<Plan>>> getPlans() async {
    try {
      Response response = await _api.getPlans();
      if (response.statusCode == 200) {
        List<Plan> plans =
            ((response.data) as List).map((e) => Plan.fromJson(e)).toList();
        return DataSuccess(plans);
      }
      return const DataFailed('در برقراری ارتباط مشکلی پیش آمده است.');
    } catch (e) {
      return const DataFailed('در برقراری ارتباط مشکلی پیش آمده است.');
    }
  }

  @override
  Future<DataResponse<SubscriptionPlan>> buy(
      {required int price, required int plan}) async {
    try {
      Response response = await _api.buy(price: price, plan: plan);
      if (response.statusCode == 200) {
        return DataSuccess(SubscriptionPlan.fromJson(response.data));
      }
      return const DataFailed('در برقراری ارتباط مشکلی پیش آمده است.');
    } catch (e) {
      return const DataFailed('در برقراری ارتباط مشکلی پیش آمده است.');
    }
  }
}
