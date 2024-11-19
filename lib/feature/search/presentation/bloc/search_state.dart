part of 'search_cubit.dart';

class SearchFilter {
  final String? query;
  final String type;
  final List<int>? genres;
  final List<int>? countries;
  final PickerDateRange? range;
  final String sortBy;

  SearchFilter({required this.query,
    required this.type,
    required this.genres,
    required this.countries,
    required this.range,
    required this.sortBy});

  SearchFilter changeQuery({
    String? query,
  }) {
    return SearchFilter(query: query,
        type: type,
        genres: genres,
        countries: countries,
        range: range,
        sortBy: sortBy);
  }
}

enum SearchStatus {
  initial,
  loading,
  success,
  error;
}

class SearchState {
  final SearchStatus status;
  final List<Media> media;
  final int nextPage;
  final int lastPage;
  final ErrorEntity? error;
  final SearchFilter filter;
  final String? hashRequest;

  // SearchFilter(query: null, type: 'both', genres: null, countries: null, range: null, sortBy: '-name')

  const SearchState({required this.filter,
    this.status = SearchStatus.initial,
    this.media = const <Media>[],
    this.nextPage = 1,
    this.lastPage = 1,
    this.error,
    this.hashRequest});

  SearchState copyWith({String? hashRequest,
    SearchFilter? filter,
    SearchStatus? status,
    List<Media>? media,
    int? nextPage,
    int? lastPage,
    ErrorEntity? error}) {
    return SearchState(
        hashRequest: hashRequest ?? this.hashRequest,
        filter: filter ?? this.filter,
        status: status ?? this.status,
        nextPage: nextPage ?? this.nextPage,
        lastPage: lastPage ?? this.lastPage,
        error: error ?? this.error,
        media: media ?? this.media);
  }
}
