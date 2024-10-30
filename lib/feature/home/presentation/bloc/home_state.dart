part of 'home_cubit.dart';

enum HomeStatus {
  initial,
  success,
  error,
  errorPage,
  initialLoading,
  loading;
}

class HomeState {
  final HomeStatus status;
  final List<SliderModel> slides;
  final List<Collection> collections;
  final List<int> test;
  final int nextPage;
  final int lastPage;
  final ErrorEntity? error;

  const HomeState(
      {this.status = HomeStatus.initial,
      this.slides = const <SliderModel>[],
      this.collections = const <Collection>[],
      this.test = const <int>[1,2,3,4,5,6,7,8,9,10],
      this.nextPage = 1,
      this.lastPage = 1,
      this.error});

  HomeState copyWith(
      {HomeStatus? status,
      List<SliderModel>? slides,
      List<Collection>? collections,
      List<int>? test,
      int? nextPage,
      int? lastPage,
      ErrorEntity? error}) {
    return HomeState(
        status: status ?? this.status,
        slides: slides ?? this.slides,
        collections: collections ?? this.collections,
        test: test ?? this.test,
        nextPage: nextPage ?? this.nextPage,
        lastPage: lastPage ?? this.lastPage,
        error: error ?? this.error);
  }
}
