part of 'type_section_cubit.dart';

enum MediaType {
  series,
  movie;

  String toName() {
    if (this == MediaType.movie) {
      return "فیلم";
    } else if (this == MediaType.series) {
      return "سریال ";
    }
    return "";
  }
}

class TypeSectionState {
  final List<MediaType> tempSelectedItem;
  final List<MediaType> selectedItem;

  const TypeSectionState(
      {required this.tempSelectedItem, required this.selectedItem});

  TypeSectionState copyWith(
      {List<MediaType>? tempSelectedItem, List<MediaType>? selectedItem}) {
    return TypeSectionState(
        tempSelectedItem: tempSelectedItem ?? this.tempSelectedItem,
        selectedItem: selectedItem ?? this.selectedItem);
  }

  bool isNewFilter() {
    bool value = const UnorderedIterableEquality().equals(tempSelectedItem, selectedItem);
    return value;
  }
}
