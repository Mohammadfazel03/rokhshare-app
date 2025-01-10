import 'package:bloc/bloc.dart';
import 'package:rokhshare/feature/gallery/data/repositories/gallery_repository.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/error_entity.dart';
import 'package:rokhshare/utils/page_response.dart';

import '../../data/remote/model/gallery.dart';

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  final GalleryRepository repository;

  GalleryCubit({required this.repository}) : super(const GalleryState());

  Future<void> getGalleries(
      {required int mediaId, int page = 1, bool retry = false}) async {
    if ((state.nextPage > state.lastPage) ||
        (state.status == GalleryStatus.loading) ||
        (state.status == GalleryStatus.error && !retry)) {
      return;
    }
    emit(state.copyWith(status: GalleryStatus.loading));

    DataResponse<PageResponse<Gallery>> genres =
        await repository.getGalleries(id: mediaId, page: page);

    if (genres is DataSuccess) {
      emit(state.copyWith(
        status: GalleryStatus.success,
        gallery: List.of(state.gallery)..addAll(genres.data?.results ?? []),
        lastPage: genres.data?.totalPages,
        nextPage: page + 1,
        error: null,
      ));
    } else {
      emit(state.copyWith(
          status: GalleryStatus.error,
          error: ErrorEntity(
              title: "خطا در دریافت تصاویر",
              error: genres.error ?? "خطا در دسترسی به اینترنت",
              code: genres.code)));
    }
  }
}
