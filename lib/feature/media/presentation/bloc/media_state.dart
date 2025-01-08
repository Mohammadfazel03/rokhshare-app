part of 'media_cubit.dart';

sealed class MediaState {}

final class MediaInitial extends MediaState {}

final class MediaLoading extends MediaState {}

final class MediaError extends MediaState {
  final ErrorEntity error;

  MediaError({required this.error});
}

final class MediaSuccess extends MediaState {
  final Media data;

  MediaSuccess({required this.data});
}
