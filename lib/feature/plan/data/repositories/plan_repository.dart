import 'dart:async';

import 'package:rokhshare/feature/plan/data/remote/model/plan.dart';
import 'package:rokhshare/feature/plan/data/remote/model/subscription_plan.dart';
import 'package:rokhshare/utils/data_response.dart';

abstract class PlanRepository {
  Future<DataResponse<List<Plan>>> getPlans();

  Future<DataResponse<SubscriptionPlan>> buy({required int price, required int plan});

}
