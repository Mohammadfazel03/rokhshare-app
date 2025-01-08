part of 'media_rate_cubit.dart';

enum MediaRateStatus {
  initial,
  submitLoading,
  loading,
  success,
  submitError,
  error
}

class MediaRateState {
  final MediaRateStatus status;
  final List<Rating> rates;
  final ErrorEntity? error;
  final int? myRate;
  final int mediaId;
  final int count;
  final double allRate;

  MediaRateState(
      {required this.status,
      required this.rates,
      required this.error,
      required this.myRate,
      required this.mediaId,
      required this.allRate,
      required this.count
      });

  MediaRateState copyWith(
      {MediaRateStatus? status,
      List<Rating>? rates,
      ErrorEntity? error,
      int? myRate,
      int? count,
      double? allRate,
      int? mediaId,
      bool resetRate = false
      }) {
    return MediaRateState(
      mediaId: mediaId ?? this.mediaId,
      status: status ?? this.status,
      rates: rates ?? this.rates,
      error: error ?? this.error,
      allRate: allRate ?? this.allRate,
      myRate: resetRate ? null : myRate ?? this.myRate,
      count: count ?? this.count,
    );
  }
}
