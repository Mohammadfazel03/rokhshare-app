import 'package:bloc/bloc.dart';
import 'package:rokhshare/feature/category/data/repositories/category_repository.dart';
import 'package:rokhshare/feature/home/data/remote/model/genre.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/error_entity.dart';
import 'package:rokhshare/utils/page_response.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository repository;

  CategoryCubit({required this.repository}) : super(const CategoryState()) {
    getCategories();
  }

  Future<void> getCategories({int page = 1, bool retry = false}) async {
    if ((state.nextPage > state.lastPage) ||
        (state.status == CategoryStatus.loading) ||
        (state.status == CategoryStatus.error && !retry)) {
      return;
    }
    emit(state.copyWith(status: CategoryStatus.loading));

    DataResponse<PageResponse<Genre>> genres =
        await repository.getCategories(page: page);

    if (genres is DataSuccess) {
      emit(state.copyWith(
        status: CategoryStatus.success,
        genres: List.of(state.genres)..addAll(genres.data?.results ?? []),
        lastPage: genres.data?.totalPages,
        nextPage: page + 1,
        error: null,
      ));
    } else {
      emit(state.copyWith(
          status: CategoryStatus.error,
          error: ErrorEntity(
              title: "خطا در دریافت دسته بندی ها",
              error: genres.error ?? "خطا در دسترسی به اینترنت",
              code: genres.code)));
    }
  }
}
