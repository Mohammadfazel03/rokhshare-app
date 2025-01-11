import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rokhshare/feature/home/data/remote/model/media_file.dart';
import 'package:rokhshare/feature/play/data/remote/model/advertise.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/error_entity.dart';

import '../../data/repositories/play_repository.dart';

part 'play_state.dart';

class PlayCubit extends Cubit<PlayState> {
  final PlayRepository repository;

  PlayCubit({required PlayRepository playRepository})
      : repository = playRepository,
        super(PlayInitial());

  Future<void> episodePlay(int id) async {
    emit(PlayLoading());
    DataResponse<MediaFile> media = await repository.playEpisode(id: id);

    if (media is DataSuccess) {
      emit(MediaPlayInitialSuccessfully(media: media.data!));
    } else {
      emit(PlayFailed(
          error: ErrorEntity(
              title: "خطا در دریافت اظلاعات",
              error: media.error ?? "خطا در دسترسی به اینترنت",
              code: media.code)));
    }
  }

  Future<void> moviePlay(int id) async {
    emit(PlayLoading());
    DataResponse<MediaFile> media = await repository.playMovie(id: id);

    if (media is DataSuccess) {
      emit(MediaPlayInitialSuccessfully(media: media.data!));
    } else {
      emit(PlayFailed(
          error: ErrorEntity(
              title: "خطا در دریافت اظلاعات",
              error: media.error ?? "خطا در دسترسی به اینترنت",
              code: media.code)));
    }
  }

  Future<void> adsPlay(int mediaId, int? episodeId) async {
    if (state is PlayLoading){
      return;
    }
    emit(PlayLoading());
    DataResponse<Advertise> ads =
        await repository.playAds(mediaId: mediaId, episodeId: episodeId);

    if (ads is DataSuccess) {
      emit(AdsPlayInitialSuccessfully(ads: ads.data!));
    } else {
      emit(PlayFailed(
          error: ErrorEntity(
              title: "خطا در دریافت اظلاعات",
              error: ads.error ?? "خطا در دسترسی به اینترنت",
              code: ads.code)));
    }
  }

  void adsComplete() {
    if (state is! AdsPlayComplete) {
      emit(AdsPlayComplete());
    }
  }

  void adsReadyPlay() {
    emit(AdsPlaySuccessfully());
  }

  void mediaReadyPlay() {
    emit(MediaPlaySuccessfully());
  }

  void setError() {
    emit(PlayFailed(
        error: const ErrorEntity(
            title: "خطا در پخش",
            error: "در پخش فایل مشکلی پیش آمده است",
            code: null)));
  }
}
