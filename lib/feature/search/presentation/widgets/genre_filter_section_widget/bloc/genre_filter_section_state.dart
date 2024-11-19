part of 'genre_filter_section_cubit.dart';

enum GenreFilterSectionStatus {
  loading,
  success,
  fail;
}

final class GenreFilterSectionState {
  final GenreFilterSectionStatus status;
  final List<Genre>? data;
  final List<Genre>? filteredData;
  final ErrorEntity? error;
  final List<Genre> selectedItem;
  final List<Genre> tempSelected;

  const GenreFilterSectionState(
      {required this.status,
      required this.selectedItem,
      required this.tempSelected,
      this.data,
      this.filteredData,
      this.error});

  GenreFilterSectionState setError(ErrorEntity error) {
    return GenreFilterSectionState(
        status: status,
        selectedItem: selectedItem,
        tempSelected: tempSelected,
        error: error,
        data: data,
        filteredData: filteredData);
  }

  GenreFilterSectionState clearError() {
    return GenreFilterSectionState(
        status: status,
        selectedItem: selectedItem,
        tempSelected: tempSelected,
        error: null,
        data: data,
        filteredData: filteredData);
  }

  GenreFilterSectionState copyWith(
      {GenreFilterSectionStatus? status,
      List<Genre>? data,
      List<Genre>? filteredData,
      List<Genre>? tempSelected,
      ErrorEntity? error,
      List<Genre>? selectedItem}) {
    return GenreFilterSectionState(
      filteredData: filteredData ?? this.filteredData,
      tempSelected: tempSelected ?? this.tempSelected,
      status: status ?? this.status,
      selectedItem: selectedItem ?? this.selectedItem,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  bool isNewFilter() {
    bool value = const UnorderedIterableEquality().equals(tempSelected, selectedItem);
    return value;
  }
}
