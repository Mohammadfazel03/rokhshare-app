part of 'season_cubit.dart';

enum SeasonStatus {
  initial,
  loading,
  success,
  error;
}

class SeasonState {
  final SeasonStatus status;
  final List<Season> seasons;
  final int? seriesId;
  final ErrorEntity? error;

  const SeasonState(
      {required this.seriesId,
      this.status = SeasonStatus.initial,
      this.seasons = const [],
      this.error});

  SeasonState copyWith({
    SeasonStatus? status,
    List<Season>? seasons,
    int? seriesId,
    ErrorEntity? error,
  }) {
    return SeasonState(
      status: status ?? this.status,
      seasons: seasons ?? this.seasons,
      seriesId: seriesId ?? this.seriesId,
      error: error ?? this.error,
    );
  }
}
