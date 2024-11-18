import 'package:bloc/bloc.dart';

part 'type_section_state.dart';

class TypeSectionCubit extends Cubit<TypeSectionState> {
  TypeSectionCubit()
      : super(TypeSectionState(
            selectedItem: List.of(MediaType.values),
            tempSelectedItem: List.of(MediaType.values)));

  void selectItem(MediaType selectedItem) {
    emit(state.copyWith(
        tempSelectedItem: List.of(state.tempSelectedItem)..add(selectedItem)));
  }

  void removeItem(MediaType item) {
    if (state.tempSelectedItem.length > 1) {
      emit(state.copyWith(
          tempSelectedItem: List.of(state.tempSelectedItem)..remove(item)));
    } else {
      emit(state.copyWith(tempSelectedItem: List.of(MediaType.values)));
    }
  }

  void finalize() {
    emit(state.copyWith(selectedItem: state.tempSelectedItem));
  }

  void clear() {
    emit(state.copyWith(tempSelectedItem: null));
  }

  void init() {
    emit(state.copyWith(tempSelectedItem: List.of(state.selectedItem)));
  }
}
