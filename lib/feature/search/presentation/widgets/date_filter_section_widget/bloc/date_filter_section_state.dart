part of 'date_filter_section_cubit.dart';

class DateFilterSectionState {
  const DateFilterSectionState({this.range, this.tempRange});

  final PickerDateRange? range;
  final PickerDateRange? tempRange;

  bool isNewFilter() {
    bool value = range?.endDate?.year == tempRange?.endDate?.year &&
        range?.startDate?.year == tempRange?.startDate?.year;
    return value;
  }
}
