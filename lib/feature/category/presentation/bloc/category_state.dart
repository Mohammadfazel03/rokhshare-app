part of 'category_cubit.dart';

enum CategoryStatus {
  initial,
  loading,
  success,
  error;
}

class CategoryState {
  final CategoryStatus status;
  final List<Genre> genres;
  final int nextPage;
  final int lastPage;
  final ErrorEntity? error;

  const CategoryState(
      {this.status = CategoryStatus.initial,
      this.genres = const <Genre>[],
      this.nextPage = 1,
      this.lastPage = 1,
      this.error});

  CategoryState copyWith(
      {CategoryStatus? status,
      List<Genre>? genres,
      int? nextPage,
      int? lastPage,
      ErrorEntity? error}) {
    return CategoryState(
        status: status ?? this.status,
        nextPage: nextPage ?? this.nextPage,
        lastPage: lastPage ?? this.lastPage,
        error: error ?? this.error,
        genres: genres ?? this.genres);
  }
}
