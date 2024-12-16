part of 'plan_cubit.dart';

enum PlanStatus {
  initial,
  loading,
  success,
  error;
}

enum BuyStatus {
  init,
  success,
  fail;
}

class PlanState {
  final PlanStatus status;
  final BuyStatus buyStatus;
  final List<Plan> plans;
  final SubscriptionPlan? buyResponse;
  final ErrorEntity? error;
  final ErrorEntity? buyError;

  const PlanState(
      {required this.status,
      required this.plans,
      this.buyResponse,
      this.buyStatus = BuyStatus.init,
      this.error,
      this.buyError});

  PlanState copyWith({
    PlanStatus? status,
    BuyStatus? buyStatus,
    SubscriptionPlan? buyResponse,
    List<Plan>? plans,
    ErrorEntity? error,
    ErrorEntity? buyError,
  }) {
    return PlanState(
      status: status ?? this.status,
      plans: plans ?? this.plans,
      error: error ?? this.error,
      buyStatus: buyStatus ?? this.buyStatus,
      buyError: buyError ?? this.buyError,
      buyResponse: buyResponse ?? this.buyResponse
    );
  }
}
