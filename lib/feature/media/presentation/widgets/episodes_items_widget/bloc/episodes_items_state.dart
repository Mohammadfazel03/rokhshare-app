part of 'episodes_items_cubit.dart';

enum EpisodesItemsStatus {
  initial,
  loading,
  success,
  error;
}

class EpisodesItemsState {
  final EpisodesItemsStatus status;
  final List<Episode> episodes;
  final Season? season;
  final int mediaId;
  final int nextPage;
  final int lastPage;
  final int total;
  final ErrorEntity? error;

  EpisodesItemsState(
      {required this.status,
      required this.episodes,
      required this.season,
      required this.nextPage,
      required this.lastPage,
      required this.total,
      required this.mediaId,
      required this.error});

  EpisodesItemsState.init(this.episodes, this.season, this.total, this.mediaId)
      : status = EpisodesItemsStatus.initial,
        nextPage = 2,
        lastPage = (episodes.length == total) ? 1 : 2,
        error = null;

  EpisodesItemsState copyWith({
    EpisodesItemsStatus? status,
    List<Episode>? episodes,
    Season? season,
    int? nextPage,
    int? lastPage,
    int? total,
    ErrorEntity? error,
  }) {
    return EpisodesItemsState(
      mediaId: mediaId,
      status: status ?? this.status,
      episodes: episodes ?? this.episodes,
      season: season ?? this.season,
      nextPage: nextPage ?? this.nextPage,
      lastPage: lastPage ?? this.lastPage,
      total: total ?? this.total,
      error: error ?? this.error,
    );
  }
}
