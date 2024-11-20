part of 'media_items_cubit.dart';

enum MediaItemsStatus {
  initial,
  loading,
  success,
  error;
}

class MediaItemsState {
  final MediaItemsStatus status;
  final List<Media> media;
  final int nextPage;
  final int lastPage;
  final ErrorEntity? error;

  const MediaItemsState(
      {this.status = MediaItemsStatus.initial,
      this.media = const <Media>[],
      this.nextPage = 1,
      this.lastPage = 1,
      this.error});

  MediaItemsState copyWith(
      {String? hashRequest,
      MediaItemsStatus? status,
      List<Media>? media,
      int? nextPage,
      int? lastPage,
      ErrorEntity? error}) {
    return MediaItemsState(
        status: status ?? this.status,
        nextPage: nextPage ?? this.nextPage,
        lastPage: lastPage ?? this.lastPage,
        error: error ?? this.error,
        media: media ?? this.media);
  }
}
