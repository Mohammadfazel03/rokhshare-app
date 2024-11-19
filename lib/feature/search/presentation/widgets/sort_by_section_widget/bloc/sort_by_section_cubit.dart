import 'package:bloc/bloc.dart';

part 'sort_by_section_state.dart';

class SortBySectionCubit extends Cubit<SortBySectionState> {
  SortBySectionCubit() : super(const SortBySectionState(sortBy: SortBy.titleASC));

  void set(SortBy? sortBy) {
    if (sortBy != null && state.tempSortBy != sortBy) {
      emit(state.copyWith(tempSortBy: sortBy));
    }
  }

  void finalize() {
    emit(state.copyWith(sortBy: state.tempSortBy));
  }

  void clear() {
    emit(state.copyWith(tempSortBy: SortBy.titleASC));
  }

  void init() {
    emit(state.copyWith(tempSortBy: state.sortBy));
  }
}
