import 'package:bloc/bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

part 'date_filter_section_state.dart';

class DateFilterSectionCubit extends Cubit<DateFilterSectionState> {
  DateFilterSectionCubit() : super(const DateFilterSectionState());

  void setDateRange(PickerDateRange? range) {
    if (range?.endDate != null && range?.startDate != null) {
      emit(DateFilterSectionState(tempRange: range, range: state.range));
    }
  }

  void finalize() {
    emit(DateFilterSectionState(
        range: state.tempRange, tempRange: state.tempRange));
  }

  void clear() {
    emit(DateFilterSectionState(tempRange: null, range: state.range));
  }

  void init() {
    emit(DateFilterSectionState(tempRange: state.range, range: state.range));
  }
}
