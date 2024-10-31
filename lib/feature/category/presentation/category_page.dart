import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/feature/category/presentation/bloc/category_cubit.dart';
import 'package:rokhshare/feature/category/presentation/widget/genre_item_widget.dart';
import 'package:rokhshare/gen/assets.gen.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _scrollController = ScrollController();

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  void _onScroll() {
    if (_isBottom) {
      int page = BlocProvider.of<CategoryCubit>(context).state.nextPage;
      BlocProvider.of<CategoryCubit>(context).getCategories(page: page);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if ((state.status == CategoryStatus.loading ||
                    state.status == CategoryStatus.initial) &&
                state.genres.isEmpty) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state.status == CategoryStatus.error &&
                state.genres.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.icons.wifiLowBound.svg(
                        width: 128,
                        height: 128,
                        color: Theme.of(context).colorScheme.primary),
                    const SizedBox(height: 8),
                    Text(state.error?.title ?? "عدم دسترسی به اینترنت"),
                    const SizedBox(height: 4),
                    Text(state.error?.error ??
                        "لطفا از اتصال اینترنت خود اطمینان حاصل کنید."),
                    TextButton.icon(
                        onPressed: () {
                          BlocProvider.of<CategoryCubit>(context)
                              .getCategories(retry: true);
                        },
                        label: const Text("تلاش دوباره"),
                        icon: Assets.icons.restartLinear.svg(
                            color: Theme.of(context).colorScheme.primary,
                            height: 24,
                            width: 24))
                  ],
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 16 / 9,
                  ),
                  cacheExtent: 500,
                  controller: _scrollController,
                  itemCount: state.status == CategoryStatus.success
                      ? state.genres.length
                      : state.genres.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.genres.length) {
                      if (state.status == CategoryStatus.loading) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        );
                      } else {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(state.error?.error ?? ""),
                                TextButton.icon(
                                    onPressed: () {
                                      int page = BlocProvider.of<CategoryCubit>(
                                              context)
                                          .state
                                          .nextPage;
                                      BlocProvider.of<CategoryCubit>(context)
                                          .getCategories(
                                              page: page, retry: true);
                                    },
                                    label: const Text("تلاش دوباره"),
                                    icon: const Icon(Icons.refresh))
                              ],
                            ),
                          ),
                        );
                      }
                    }
                    return GenreItemWidget(genre: state.genres[index]);
                  }),
            );
          },
        ),
      ),
    );
  }
}
