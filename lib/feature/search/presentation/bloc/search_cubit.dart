import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:rokhshare/feature/home/data/remote/model/media.dart';
import 'package:rokhshare/feature/search/data/repositories/search_repository.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/error_entity.dart';
import 'package:rokhshare/utils/page_response.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository repository;

  SearchCubit({required this.repository})
      : super(SearchState(
            filter: SearchFilter(
                query: null,
                type: 'both',
                genres: null,
                countries: null,
                range: null,
                sortBy: '-name')));

  Future<void> search(
      {int page = 1, SearchFilter? searchFiler, bool retry = false}) async {
    if ((state.nextPage > state.lastPage && page != 1 && searchFiler == null) ||
        (state.status == SearchStatus.loading && searchFiler == null) ||
        (state.status == SearchStatus.error && !retry && searchFiler == null)) {
      return;
    }
    var hash = generateRandomHash(10);
    emit(state.copyWith(
        status: SearchStatus.loading,
        hashRequest: hash,
        filter: searchFiler,
        media: searchFiler != null ? [] : null));
    late DataResponse<PageResponse<Media>> media;
    if (searchFiler != null) {
      media = await repository.search(
          query: searchFiler.query,
          type: searchFiler.type,
          genres: searchFiler.genres,
          countries: searchFiler.countries,
          range: searchFiler.range,
          sortBy: searchFiler.sortBy,
          page: page);
    } else {
      media = await repository.search(
          query: state.filter.query,
          type: state.filter.type,
          genres: state.filter.genres,
          countries: state.filter.countries,
          range: state.filter.range,
          sortBy: state.filter.sortBy,
          page: page);
    }
    if (media is DataSuccess && hash == state.hashRequest) {
      emit(state.copyWith(
        status: SearchStatus.success,
        media: List.of(state.media)..addAll(media.data?.results ?? []),
        lastPage: media.data?.totalPages,
        nextPage: page + 1,
        error: null,
      ));
    } else {
      emit(state.copyWith(
          status: SearchStatus.error,
          error: ErrorEntity(
              title: "خطا در جستجو",
              error: media.error ?? "خطا در دسترسی به اینترنت",
              code: media.code)));
    }
  }

  String generateRandomHash(int length) {
    const String charset =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_+';

    Random random = Random();
    String password = '';

    for (int i = 0; i < length; i++) {
      int randomIndex = random.nextInt(charset.length);
      password += charset[randomIndex];
    }

    return password;
  }
}
