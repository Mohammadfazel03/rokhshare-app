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

  String toServerName() {
    if (this == SortBy.titleASC) {
      return "name";
    } else if (this == SortBy.titleDESC) {
      return "-name";
    } else if (this == SortBy.releaseDateASC) {
      return "release_date";
    } else if (this == SortBy.releaseDateDESC) {
      return "-release_date";
    } else if (this == SortBy.ratingASC) {
      return "rate";
    } else if (this == SortBy.ratingDESC) {
      return "-rate";
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


  bool isNewFilter() {
    bool value = tempSortBy == sortBy;
    return value;
  }
}
