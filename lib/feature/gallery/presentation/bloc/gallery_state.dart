part of 'gallery_cubit.dart';

enum GalleryStatus {
  initial,
  loading,
  success,
  error;
}

class GalleryState {
  final GalleryStatus status;
  final List<Gallery> gallery;
  final int nextPage;
  final int lastPage;
  final ErrorEntity? error;

  const GalleryState(
      {this.status = GalleryStatus.initial,
      this.gallery = const <Gallery>[],
      this.nextPage = 1,
      this.lastPage = 1,
      this.error});

  GalleryState copyWith(
      {GalleryStatus? status,
      List<Gallery>? gallery,
      int? nextPage,
      int? lastPage,
      ErrorEntity? error}) {
    return GalleryState(
        status: status ?? this.status,
        nextPage: nextPage ?? this.nextPage,
        lastPage: lastPage ?? this.lastPage,
        error: error ?? this.error,
        gallery: gallery ?? this.gallery);
  }
}
