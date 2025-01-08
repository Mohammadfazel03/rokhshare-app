import 'package:bloc/bloc.dart';
import 'package:rokhshare/feature/media/data/remote/model/rating.dart';
import 'package:rokhshare/feature/media/data/repositories/media_repository.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/error_entity.dart';

part 'media_rate_state.dart';

class MediaRateCubit extends Cubit<MediaRateState> {
  final MediaRepository repository;

  MediaRateCubit(
      {required this.repository, required int? myRate, required int mediaId})
      : super(MediaRateState(
            mediaId: mediaId,
            status: MediaRateStatus.initial,
            rates: [],
            allRate: 0,
            count: 0,
            myRate: myRate,
            error: null)) {
    getRates();
  }

  Future<void> getRates() async {
    emit(state.copyWith(status: MediaRateStatus.loading));
    DataResponse<List<Rating>> rates =
        await repository.getRates(id: state.mediaId);

    if (rates is DataSuccess) {
      double t = 0;
      int count = 0;
      rates.data?.forEach((rate) {
        t += ((rate.count ?? 0) * (rate.rating ?? 0));
        count += (rate.count ?? 0);
      });
      if (count > 0) {
        t = t / count;
      }
      emit(state.copyWith(
        status: MediaRateStatus.success,
        rates: rates.data,
        allRate: t,
        count: count,
        error: null,
      ));
    } else {
      emit(state.copyWith(
          status: MediaRateStatus.error,
          error: ErrorEntity(
              title: "خطا در دریافت امتیازات ها",
              error: rates.error ?? "خطا در دسترسی به اینترنت",
              code: rates.code)));
    }
  }

  Future<void> submitRate({required int rate}) async {
    emit(state.copyWith(status: MediaRateStatus.submitLoading));
    DataResponse<void> rates =
        await repository.submitRates(id: state.mediaId, rate: rate);

    if (rates is DataSuccess) {
      emit(state.copyWith(
          status: MediaRateStatus.success, error: null, myRate: rate));
      getRates();
    } else {
      emit(state.copyWith(
          status: MediaRateStatus.submitError,
          error: ErrorEntity(
              title: "خطا در ثبت امتیاز",
              error: rates.error ?? "خطا در دسترسی به اینترنت",
              code: rates.code)));
    }
  }

  Future<void> deleteRate() async {
    emit(state.copyWith(status: MediaRateStatus.submitLoading));
    DataResponse<void> rates = await repository.deleteRates(id: state.mediaId);
    if (rates is DataSuccess) {
      emit(state.copyWith(
          status: MediaRateStatus.success, error: null, myRate: null, resetRate: true));
      getRates();
    } else {
      emit(state.copyWith(
          status: MediaRateStatus.submitError,
          error: ErrorEntity(
              title: "خطا در ثبت امتیاز",
              error: rates.error ?? "خطا در دسترسی به اینترنت",
              code: rates.code)));
    }
  }
}
