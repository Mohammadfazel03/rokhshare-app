import 'package:async/async.dart';

import 'package:bloc/bloc.dart';
import 'package:rokhshare/feature/home/data/remote/model/collection.dart';
import 'package:rokhshare/feature/home/data/remote/model/slider_model.dart';
import 'package:rokhshare/feature/home/data/repositories/home_repository.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/error_entity.dart';
import 'package:rokhshare/utils/page_response.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _repository;

  HomeCubit({required HomeRepository repository})
      : _repository = repository,
        super(const HomeState());

  Future<void> getHome({int page = 1, bool retry = false}) async {
    if ((state.nextPage > state.lastPage) ||
        (state.status == HomeStatus.loading) ||
        (state.status == HomeStatus.initialLoading) ||
        ((state.status == HomeStatus.error ||
                state.status == HomeStatus.errorPage) &&
            !retry)) {
      return;
    }
    emit(state.copyWith(
        status: page > 1 ? HomeStatus.loading : HomeStatus.initialLoading));
    FutureGroup fg = FutureGroup();
    fg.add(_repository.getCollections(page: page));
    if (page == 1) {
      fg.add(_repository.getSlider());
    }
    fg.close();
    fg.future.then((value) {
      if (value.length == 2) {
        DataResponse<List<SliderModel>> sliders = value[1];
        DataResponse<PageResponse<Collection>> collections = value[0];
        if (collections is DataSuccess && sliders is DataSuccess) {
          emit(state.copyWith(
            status: HomeStatus.success,
            slides: sliders.data,
            collections: collections.data?.results,
            lastPage: collections.data?.totalPages,
            nextPage: page + 1,
            error: null,
          ));
        } else if (collections is DataFailed) {
          emit(state.copyWith(
              status: HomeStatus.error,
              error: ErrorEntity(
                  title: "خطا در دریافت مجموعه ها",
                  error: collections.error ?? "خطا در دسترسی به اینترنت",
                  code: collections.code)));
        } else if (sliders is DataFailed) {
          emit(state.copyWith(
              status: HomeStatus.error,
              error: ErrorEntity(
                  title: "خطا در دریافت پرطرفدار ها",
                  error: sliders.error ?? "خطا در دسترسی به اینترنت",
                  code: sliders.code)));
        }
      } else if (value.length == 1) {
        DataResponse<PageResponse<Collection>> collections = value[0];
        if (collections is DataSuccess) {
          emit(state.copyWith(
            status: HomeStatus.success,
            collections: List.of(state.collections)
              ..addAll(collections.data?.results ?? []),
            lastPage: collections.data?.totalPages,
            nextPage: page + 1,
            error: null,
          ));
        } else {
          emit(state.copyWith(
              status: HomeStatus.errorPage,
              error: ErrorEntity(
                  title: null,
                  error: collections.error ?? "خطا در دسترسی به اینترنت",
                  code: collections.code)));
        }
      }
    }, onError: (e) {
      emit(state.copyWith(
          status: HomeStatus.error,
          error: const ErrorEntity(
              title: null, error: "خطا در دریافت اظلاهات", code: null)));
    });
  }
}
