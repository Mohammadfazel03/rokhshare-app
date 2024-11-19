import 'package:bloc/bloc.dart';
import 'package:rokhshare/feature/home/data/remote/model/country.dart';
import 'package:rokhshare/feature/search/data/repositories/search_repository.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/error_entity.dart';
import 'package:collection/collection.dart';

part 'country_filter_section_state.dart';

class CountryFilterSectionCubit extends Cubit<CountryFilterSectionState> {
  final SearchRepository _repository;

  CountryFilterSectionCubit({required SearchRepository repository})
      : _repository = repository,
        super(const CountryFilterSectionState(
          status: CountryFilterSectionStatus.loading,
          selectedItem: [],
          tempSelected: [])) {
    getData();
  }

  Future<void> getData() async {
    emit(CountryFilterSectionState(
        status: CountryFilterSectionStatus.loading,
        selectedItem: List.empty(growable: true),
        tempSelected: List.empty(growable: true)));
    DataResponse<List<Country>> response = await _repository.getCountries();
    if (response is DataFailed) {
      emit(state.copyWith(
          status: CountryFilterSectionStatus.fail,
          error: ErrorEntity(
              error: response.error ?? "خطا در دسترسی به اینترنت",
              code: response.code,
              title: "خطا در دریافت کشور ها")));
    } else {
      emit(state.copyWith(
          status: CountryFilterSectionStatus.success,
          data: response.data,
          filteredData: response.data));
    }
  }

  void clearAllSelectedItem() {
    emit(state.copyWith(tempSelected: []));
  }


  void finalizeSelectedItem() {
    if (state.status == CountryFilterSectionStatus.success) {
      emit(state.copyWith(
          selectedItem: List.of(state.tempSelected)
      ));
    }
  }

  void initialSelectedItem() {
    if (state.status == CountryFilterSectionStatus.success) {
      emit(state.copyWith(
          tempSelected: List.of(state.selectedItem)
      ));
    }
  }

  void setError(ErrorEntity error) {
    emit(state.setError(error));
  }

  void clearError() {
    if (state.status == CountryFilterSectionStatus.success &&
        state.error != null) {
      emit(state.clearError());
    }
  }

  void searchData(String? text) {
    if (text != null && text.isNotEmpty) {
      emit(state.copyWith(
          filteredData: state.data
              ?.where((item) => item.name?.contains(text) ?? false)
              .toList()));
    } else {
      if (state.filteredData?.length != state.data?.length) {
        emit(state.copyWith(filteredData: state.data));
      }
    }
  }

  void selectItem(Country item) {
    emit(state.copyWith(
        tempSelected: List.of(state.tempSelected)..add(item)
    ));
  }

  void removeItem(Country item) {
    emit(state.copyWith(
        tempSelected: List.of(state.tempSelected)..remove(item)
    ));
  }
}
