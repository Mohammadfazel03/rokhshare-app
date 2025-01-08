import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/config/dependency_injection.dart';
import 'package:rokhshare/feature/home/data/remote/model/media.dart';
import 'package:rokhshare/feature/media/presentation/bloc/media_cubit.dart';
import 'package:rokhshare/feature/media/presentation/media_page.dart';
import 'package:rokhshare/feature/search/presentation/bloc/search_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/country_filter_section_widget/bloc/country_filter_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/date_filter_section_widget/bloc/date_filter_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/filter_section_widget/filter_section_widget.dart';
import 'package:rokhshare/feature/search/presentation/widgets/genre_filter_section_widget/bloc/genre_filter_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/search_field_widget.dart';
import 'package:rokhshare/feature/search/presentation/widgets/sort_by_section_widget/bloc/sort_by_section_cubit.dart';
import 'package:rokhshare/feature/search/presentation/widgets/type_section_widget/bloc/type_section_cubit.dart';
import 'package:rokhshare/feature/user/presentation/bloc/auth_cubit.dart';
import 'package:rokhshare/gen/assets.gen.dart';
import 'package:rokhshare/utils/error_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  void _onScroll() {
    if (_isBottom) {
      int page = BlocProvider.of<SearchCubit>(context).state.nextPage;
      BlocProvider.of<SearchCubit>(context).search(page: page);
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _searchController = TextEditingController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        body: CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      slivers: [
        SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: SearchHeader(controller: _searchController)),
        BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
          if (state.status == SearchStatus.initial) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          } else if (state.status == SearchStatus.loading &&
              state.media.isEmpty) {
            return const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator.adaptive()));
          } else if (state.status == SearchStatus.error &&
              state.media.isEmpty) {
            return SliverFillRemaining(
              hasScrollBody: false,
              child: CustomErrorWidget(
                  error: state.error!,
                  showIcon: true,
                  showTitle: true,
                  onRetry: () {
                    BlocProvider.of<SearchCubit>(context).search(retry: true);
                  }),
            );
          } else if (state.status == SearchStatus.success &&
              state.media.isEmpty) {
            return const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: Text("موردی یافت نشد!")));
          }

          var titleTextHeight =
              _textSize("text", Theme.of(context).textTheme.labelLarge).height;
          var subtitleTextHeight =
              _textSize("text", Theme.of(context).textTheme.labelSmall).height;

          var mainWidth = (width - 16 - ((width / 200).floor() * 8)) /
              (width / 200).floor();
          var mainHeight =
              (mainWidth * 3 / 2) + 16 + titleTextHeight + subtitleTextHeight;

          return SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: mainWidth / mainHeight,
                ),
                itemCount: state.status == SearchStatus.success
                    ? state.media.length
                    : state.media.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.media.length) {
                    if (state.status == SearchStatus.loading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
                    } else {
                      return CustomErrorWidget(
                          error: state.error!,
                          showIcon: false,
                          showMessage: true,
                          showTitle: false,
                          onRetry: () {
                            int page = BlocProvider.of<SearchCubit>(context)
                                .state
                                .nextPage;
                            BlocProvider.of<SearchCubit>(context)
                                .search(page: page, retry: true);
                          });
                    }
                  }
                  return MovieItem(media: state.media[index]);
                }),
          );
        })
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;

  Size _textSize(String text, TextStyle? style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.rtl)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}

class SearchHeader extends SliverPersistentHeaderDelegate {
  final TextEditingController controller;

  SearchHeader({required this.controller});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return DecoratedBox(
      decoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: SizedBox(
              height: 48,
              child: SearchFieldWidget(
                controller: controller,
                onSubmitted: (text) {
                  var filters =
                      BlocProvider.of<SearchCubit>(context).state.filter;
                  BlocProvider.of<SearchCubit>(context)
                      .search(searchFiler: filters.changeQuery(query: text));
                },
              ),
            )),
            const SizedBox(width: 8),
            IconButton.filledTonal(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.surfaceContainerHighest),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
                onPressed: () async {
                  var res = await showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return MultiBlocProvider(providers: [
                          BlocProvider.value(
                              value: getIt.get<GenreFilterSectionCubit>()),
                          BlocProvider.value(
                              value: getIt.get<CountryFilterSectionCubit>()),
                          BlocProvider.value(
                              value: getIt.get<DateFilterSectionCubit>()),
                          BlocProvider.value(
                              value: getIt.get<SortBySectionCubit>()),
                          BlocProvider.value(
                              value: getIt.get<TypeSectionCubit>()),
                        ], child: const FilterSectionWidget());
                      },
                      isScrollControlled: true,
                      useSafeArea: true);
                  if (res != null && res is SearchFilter) {
                    SearchFilter param = res;
                    BlocProvider.of<SearchCubit>(context).search(
                        page: 1,
                        searchFiler: param.changeQuery(query: controller.text));
                  }
                },
                padding: const EdgeInsets.all(12),
                icon: Assets.icons.filterBold.svg(
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onSurfaceVariant,
                        BlendMode.srcIn))),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 64;

  @override
  double get minExtent => 64;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class MovieItem extends StatefulWidget {
  final Media media;

  const MovieItem({super.key, required this.media});

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  double scale = 1.0;

  void _changeScaleDown() {
    setState(() => scale = 0.9);
  }

  void _changeScaleUp() {
    setState(() => scale = 1);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _changeScaleDown();
      },
      onTapUp: (_) {
        _changeScaleUp();
      },
      onTapCancel: () {
        _changeScaleUp();
      },
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => MediaCubit(repository: getIt.get())
              ),
              BlocProvider.value(value: BlocProvider.of<AuthCubit>(context))
            ], child: MediaPage(mediaId: widget.media.id!))));
      },
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 200),
        child: Card(
          // clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(4)),
                    child: CachedNetworkImage(
                        imageUrl: widget.media.poster ?? "", fit: BoxFit.fill),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: RichText(
                      text: TextSpan(
                          text: widget.media.name ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                          children: [
                            TextSpan(
                                text: " (${widget.media.yearReleaseDate})",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant))
                          ]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                  child: Text(
                    widget.media.genresName,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
