import 'package:bloc/bloc.dart';
import 'package:rokhshare/feature/plan/data/remote/model/plan.dart';
import 'package:rokhshare/feature/plan/data/remote/model/subscription_plan.dart';
import 'package:rokhshare/feature/plan/data/repositories/plan_repository.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/error_entity.dart';

part 'plan_state.dart';

class PlanCubit extends Cubit<PlanState> {
  final PlanRepository repository;

  PlanCubit({required this.repository})
      : super(const PlanState(status: PlanStatus.loading, plans: [])) {
    getPlans();
  }

  Future<void> getPlans() async {
    emit(state.copyWith(status: PlanStatus.loading));
    DataResponse<List<Plan>> plans = await repository.getPlans();

    if (plans is DataSuccess) {
      emit(state.copyWith(
        status: PlanStatus.success,
        plans: plans.data,
        error: null,
      ));
    } else {
      emit(state.copyWith(
          status: PlanStatus.error,
          error: ErrorEntity(
              title: "خطا در دریافت طرح ها",
              error: plans.error ?? "خطا در دسترسی به اینترنت",
              code: plans.code)));
    }
  }

  Future<void> buy({required int price, required int plan}) async {
    emit(state.copyWith(status: PlanStatus.loading));
    DataResponse<SubscriptionPlan> buy = await repository.buy(price: price, plan: plan);

    if (buy is DataSuccess) {
      emit(state.copyWith(
        buyStatus: BuyStatus.success,
        buyResponse: buy.data,
        buyError: null,
      ));
    } else {
      emit(state.copyWith(
          buyStatus: BuyStatus.fail,
          buyError: ErrorEntity(
              title: "خطا در خرید",
              error: buy.error ?? "خطا در دسترسی به اینترنت",
              code: buy.code)));
    }
  }
}
