part of 'play_cubit.dart';

enum PlayStatus { mediaPlay, adsPlay }

@immutable
sealed class PlayState {}

final class PlayInitial extends PlayState {}

final class PlayLoading extends PlayState {}

final class PlayFailed extends PlayState {
  final ErrorEntity error;

  PlayFailed({required this.error});
}

final class MediaPlayInitialSuccessfully extends PlayState {
  final MediaFile media;

  MediaPlayInitialSuccessfully({required this.media});
}

final class MediaPlaySuccessfully extends PlayState {}

final class AdsPlayInitialSuccessfully extends PlayState {
  final Advertise ads;

  AdsPlayInitialSuccessfully({required this.ads});
}

final class AdsPlaySuccessfully extends PlayState {}

final class AdsPlayComplete extends PlayState {}
