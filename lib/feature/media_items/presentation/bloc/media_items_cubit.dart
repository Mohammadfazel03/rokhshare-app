import 'package:bloc/bloc.dart';
import 'package:rokhshare/feature/home/data/remote/model/media.dart';
import 'package:rokhshare/feature/media_items/data/repositories/media_items_repository.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/error_entity.dart';
import 'package:rokhshare/utils/page_response.dart';

part 'media_items_state.dart';

class MediaItemsCubit extends Cubit<MediaItemsState> {
  final MediaItemsRepository repository;

  MediaItemsCubit({required this.repository}) : super(const MediaItemsState());

  Future<void> getCollectionItems(
      {required int collectionId, int page = 1, bool retry = false}) async {
    if ((state.nextPage > state.lastPage) ||
        (state.status == MediaItemsStatus.loading) ||
        (state.status == MediaItemsStatus.error && !retry)) {
      return;
    }
    emit(state.copyWith(status: MediaItemsStatus.loading));

    DataResponse<PageResponse<Media>> media = await repository
        .getCollectionItems(collectionId: collectionId, page: page);

    if (media is DataSuccess) {
      emit(state.copyWith(
        status: MediaItemsStatus.success,
        media: List.of(state.media)..addAll(media.data?.results ?? []),
        lastPage: media.data?.totalPages,
        nextPage: page + 1,
        error: null,
      ));
    } else {
      emit(state.copyWith(
          status: MediaItemsStatus.error,
          error: ErrorEntity(
              title: "خطا در دریافت مچموعه",
              error: media.error ?? "خطا در دسترسی به اینترنت",
              code: media.code)));
    }
  }

  Future<void> getCategoryItems(
      {required int categoryId, int page = 1, bool retry = false}) async {
    if ((state.nextPage > state.lastPage) ||
        (state.status == MediaItemsStatus.loading) ||
        (state.status == MediaItemsStatus.error && !retry)) {
      return;
    }
    emit(state.copyWith(status: MediaItemsStatus.loading));

    DataResponse<PageResponse<Media>> media = await repository
        .getCategoryItems(categoryId: categoryId, page: page);

    if (media is DataSuccess) {
      emit(state.copyWith(
        status: MediaItemsStatus.success,
        media: List.of(state.media)..addAll(media.data?.results ?? []),
        lastPage: media.data?.totalPages,
        nextPage: page + 1,
        error: null,
      ));
    } else {
      emit(state.copyWith(
          status: MediaItemsStatus.error,
          error: ErrorEntity(
              title: "خطا در دریافت مچموعه",
              error: media.error ?? "خطا در دسترسی به اینترنت",
              code: media.code)));
    }
  }
}
