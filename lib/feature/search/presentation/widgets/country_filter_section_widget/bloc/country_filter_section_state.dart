part of 'country_filter_section_cubit.dart';

enum CountryFilterSectionStatus {
  loading,
  success,
  fail;
}

final class CountryFilterSectionState {
  final CountryFilterSectionStatus status;
  final List<Country>? data;
  final List<Country>? filteredData;
  final ErrorEntity? error;
  final List<Country> selectedItem;
  final List<Country> tempSelected;

  const CountryFilterSectionState(
      {required this.status,
        required this.selectedItem,
        required this.tempSelected,
        this.data,
        this.filteredData,
        this.error});

  CountryFilterSectionState setError(ErrorEntity error) {
    return CountryFilterSectionState(
        status: status,
        selectedItem: selectedItem,
        tempSelected: tempSelected,
        error: error,
        data: data,
        filteredData: filteredData);
  }

  CountryFilterSectionState clearError() {
    return CountryFilterSectionState(
        status: status,
        selectedItem: selectedItem,
        tempSelected: tempSelected,
        error: null,
        data: data,
        filteredData: filteredData);
  }

  CountryFilterSectionState copyWith(
      {CountryFilterSectionStatus? status,
        List<Country>? data,
        List<Country>? filteredData,
        List<Country>? tempSelected,
        ErrorEntity? error,
        List<Country>? selectedItem}) {
    return CountryFilterSectionState(
      filteredData: filteredData ?? this.filteredData,
      tempSelected: tempSelected ?? this.tempSelected,
      status: status ?? this.status,
      selectedItem: selectedItem ?? this.selectedItem,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}
