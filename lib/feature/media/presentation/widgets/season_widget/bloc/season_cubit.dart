import 'package:bloc/bloc.dart';
import 'package:rokhshare/feature/home/data/remote/model/series.dart';
import 'package:rokhshare/feature/media/data/repositories/media_repository.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/error_entity.dart';

part 'season_state.dart';

class SeasonCubit extends Cubit<SeasonState> {
  final MediaRepository repository;

  SeasonCubit({required this.repository, required int? seriesId})
      : super(SeasonState(seriesId: seriesId)) {
    getSeasons();
  }

  Future<void> getSeasons() async {
    if (state.seriesId != null) {
      emit(state.copyWith(status: SeasonStatus.loading));
      DataResponse<List<Season>> seasons =
          await repository.getSeasons(id: state.seriesId!);

      if (seasons is DataSuccess) {
        emit(state.copyWith(
          status: SeasonStatus.success,
          seasons: seasons.data,
          error: null,
        ));
      } else {
        emit(state.copyWith(
            status: SeasonStatus.error,
            error: ErrorEntity(
                title: "خطا در دریافت فصل ها",
                error: seasons.error ?? "خطا در دسترسی به اینترنت",
                code: seasons.code)));
      }
    }
  }
}
