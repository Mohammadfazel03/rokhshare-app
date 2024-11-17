part of 'sort_by_section_cubit.dart';

enum SortBy {
  titleASC,
  titleDESC,
  releaseDateASC,
  releaseDateDESC,
  ratingASC,
  ratingDESC;

  String toName() {
    if (this == SortBy.titleASC) {
      return "نام (صعودی)";
    } else if (this == SortBy.titleDESC) {
      return "نام (نزولی)";
    } else if (this == SortBy.releaseDateASC) {
      return "تاریخ انتشار (جدید ترین)";
    } else if (this == SortBy.releaseDateDESC) {
      return "تاریخ انتشار (قدیمی ترین)";
    } else if (this == SortBy.ratingASC) {
      return "امتیاز (صعودی)";
    } else if (this == SortBy.ratingDESC) {
      return "امتیاز (نزولی)";
    }
    return "";
  }
}

class SortBySectionState {
  final SortBy? tempSortBy;
  final SortBy? sortBy;

  const SortBySectionState({this.tempSortBy, this.sortBy});

  SortBySectionState copyWith({SortBy? tempSortBy, SortBy? sortBy}) {
    return SortBySectionState(
        tempSortBy: tempSortBy ?? this.tempSortBy,
        sortBy: sortBy ?? this.sortBy);
  }
}
