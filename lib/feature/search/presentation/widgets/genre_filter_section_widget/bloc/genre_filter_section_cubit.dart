import 'package:bloc/bloc.dart';
import 'package:rokhshare/feature/home/data/remote/model/genre.dart';
import 'package:rokhshare/feature/search/data/repositories/search_repository.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/error_entity.dart';

part 'genre_filter_section_state.dart';

class GenreFilterSectionCubit extends Cubit<GenreFilterSectionState> {
  final SearchRepository _repository;

  GenreFilterSectionCubit({required SearchRepository repository})
      : _repository = repository,
        super(const GenreFilterSectionState(
            status: GenreFilterSectionStatus.loading,
            selectedItem: [],
            tempSelected: [])) {
    getData();
  }

  Future<void> getData() async {
    emit(GenreFilterSectionState(
        status: GenreFilterSectionStatus.loading,
        selectedItem: List.empty(growable: true),
        tempSelected: List.empty(growable: true)));
    DataResponse<List<Genre>> response = await _repository.getGenres();
    if (response is DataFailed) {
      emit(state.copyWith(
          status: GenreFilterSectionStatus.fail,
          error: ErrorEntity(
              error: response.error ?? "خطا در دسترسی به اینترنت",
              code: response.code,
              title: "خطا در دریافت ژانر ها")));
    } else {
      emit(state.copyWith(
          status: GenreFilterSectionStatus.success,
          data: response.data,
          filteredData: response.data));
    }
  }

  void clearAllSelectedItem() {
    emit(state.copyWith(tempSelected: [], selectedItem: []));
  }

  void finalizeSelectedItem() {
    if (state.status == GenreFilterSectionStatus.success) {
      state.selectedItem.clear();
      state.selectedItem.addAll(state.tempSelected);
    }
  }

  void initialSelectedItem() {
    if (state.status == GenreFilterSectionStatus.success) {
      state.tempSelected.clear();
      state.tempSelected.addAll(state.selectedItem);
    }
  }

  void setError(ErrorEntity error) {
    emit(state.setError(error));
  }

  void clearError() {
    if (state.status == GenreFilterSectionStatus.success &&
        state.error != null) {
      emit(state.clearError());
    }
  }

  void searchData(String? text) {
    if (text != null && text.isNotEmpty) {
      emit(state.copyWith(
          filteredData: state.data
              ?.where((item) => item.title?.contains(text) ?? false)
              .toList()));
    } else {
      if (state.filteredData?.length != state.data?.length) {
        emit(state.copyWith(filteredData: state.data));
      }
    }
  }
}
