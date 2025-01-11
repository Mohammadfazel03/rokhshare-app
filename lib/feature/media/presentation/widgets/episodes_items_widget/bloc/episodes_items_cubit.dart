import 'package:bloc/bloc.dart';
import 'package:rokhshare/feature/home/data/remote/model/series.dart';
import 'package:rokhshare/feature/media/data/repositories/media_repository.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/error_entity.dart';
import 'package:rokhshare/utils/page_response.dart';

part 'episodes_items_state.dart';

class EpisodesItemsCubit extends Cubit<EpisodesItemsState> {
  final MediaRepository repository;

  EpisodesItemsCubit(
      {required this.repository,
      required int total,
      required int mediaId,
      required List<Episode> episodes,
      required Season? season})
      : super(EpisodesItemsState.init(episodes, season, total, mediaId));

  Future<void> getEpisodes({int page = 1, bool retry = false}) async {
    if ((state.nextPage > state.lastPage) ||
        (state.status == EpisodesItemsStatus.loading) ||
        (state.status == EpisodesItemsStatus.error && !retry)) {
      return;
    }
    emit(state.copyWith(status: EpisodesItemsStatus.loading));

    DataResponse<PageResponse<Episode>> episodes = await repository.getEpisodes(
        seasonId: state.season?.id ?? -1, page: page);

    if (episodes is DataSuccess) {
      emit(state.copyWith(
        status: EpisodesItemsStatus.success,
        episodes: List.of(state.episodes)..addAll(episodes.data?.results ?? []),
        lastPage: episodes.data?.totalPages,
        nextPage: page + 1,
        error: null,
      ));
    } else {
      emit(state.copyWith(
          status: EpisodesItemsStatus.error,
          error: ErrorEntity(
              title: "خطا در دریافت قسمت ها",
              error: episodes.error ?? "خطا در دسترسی به اینترنت",
              code: episodes.code)));
    }
  }

  Future<void> changeSeason(Season season) async {
    emit(state.copyWith(
        season: season,
        episodes: [],
        nextPage: 1,
        lastPage: 1,
        status: EpisodesItemsStatus.loading));

    DataResponse<PageResponse<Episode>> episodes =
        await repository.getEpisodes(seasonId: season.id ?? -1, page: 1);

    if (episodes is DataSuccess) {
      emit(state.copyWith(
        status: EpisodesItemsStatus.success,
        episodes: List.of(state.episodes)..addAll(episodes.data?.results ?? []),
        lastPage: episodes.data?.totalPages,
        nextPage: 2,
        error: null,
      ));
    } else {
      emit(state.copyWith(
          status: EpisodesItemsStatus.error,
          error: ErrorEntity(
              title: "خطا در دریافت قسمت ها",
              error: episodes.error ?? "خطا در دسترسی به اینترنت",
              code: episodes.code)));
    }
  }
}
