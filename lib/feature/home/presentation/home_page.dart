import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/feature/home/presentation/bloc/home_cubit.dart';
import 'package:rokhshare/feature/home/presentation/widgets/app_bar/home_slider.dart';
import 'package:rokhshare/feature/home/presentation/widgets/collection_slider_widget/collection_slider_widget.dart';
import 'package:rokhshare/gen/assets.gen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  void _onScroll() {
    if (_isBottom) {
      int page = BlocProvider.of<HomeCubit>(context).state.nextPage;
      BlocProvider.of<HomeCubit>(context).getHome(page: page);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<HomeCubit>(context).getHome();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (p, c) {
            return (p.status != c.status &&
                    c.status != HomeStatus.errorPage &&
                    c.status != HomeStatus.loading) ||
                (p.status == c.status &&
                    c.status == HomeStatus.error &&
                    c.error != p.error);
          },
          builder: (context, state) {
            if (state.status == HomeStatus.success) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                slivers: [
                  SliverPadding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                      sliver: SliverToBoxAdapter(
                          child: HomeSlider(sliders: state.slides))),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            if (index == state.collections.length) {
                              if (state.status == HomeStatus.loading) {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(state.error?.error ?? ""),
                                        TextButton.icon(
                                            onPressed: () {
                                              int page =
                                                  BlocProvider.of<HomeCubit>(
                                                          context)
                                                      .state
                                                      .nextPage;
                                              BlocProvider.of<HomeCubit>(
                                                      context)
                                                  .getHome(
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
                            return CollectionSliderWidget(
                                collection: state.collections[index]);
                          },
                          childCount: state.status == HomeStatus.loading ||
                                  state.status == HomeStatus.errorPage
                              ? state.collections.length + 1
                              : state.collections.length,
                        ),
                      );
                    },
                  ),
                ],
              );
            } else if (state.status == HomeStatus.error) {
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
                          BlocProvider.of<HomeCubit>(context)
                              .getHome(retry: true);
                        },
                        label: const Text("تلاش دوباره"),
                        icon: Assets.icons.restartLinear.svg(
                            color: Theme.of(context).colorScheme.primary,
                            height: 24,
                            width: 24))
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
