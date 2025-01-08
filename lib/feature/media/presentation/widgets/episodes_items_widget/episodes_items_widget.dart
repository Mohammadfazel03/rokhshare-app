import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/feature/media/presentation/widgets/episodes_items_widget/bloc/episodes_items_cubit.dart';
import 'package:rokhshare/feature/media/presentation/widgets/season_widget/bloc/season_cubit.dart';
import 'package:rokhshare/feature/media/presentation/widgets/season_widget/season_widget.dart';
import 'package:rokhshare/utils/error_widget.dart';

class EpisodesItemsWidget extends StatefulWidget {
  const EpisodesItemsWidget({super.key});

  @override
  State<EpisodesItemsWidget> createState() => _EpisodesItemsWidgetState();
}

class _EpisodesItemsWidgetState extends State<EpisodesItemsWidget> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<EpisodesItemsCubit, EpisodesItemsState>(
      builder: (context, state) {
        return SliverMainAxisGroup(slivers: [
          if (state.season != null) ...[
            SliverToBoxAdapter(
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("قسمت ها",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant)),
                          Ink(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).dividerColor),
                                borderRadius: BorderRadius.circular(6)),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    showDragHandle: true,
                                    context: context,
                                    builder: (_) => MultiBlocProvider(
                                            providers: [
                                              BlocProvider.value(
                                                  value: BlocProvider.of<
                                                      SeasonCubit>(context)),
                                              BlocProvider.value(
                                                  value: BlocProvider.of<
                                                          EpisodesItemsCubit>(
                                                      context)),
                                            ],
                                            child: SeasonWidget(
                                                season: state.season!)));
                              },
                              borderRadius: BorderRadius.circular(6),
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 24,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                              "فصل ${state.season!.number} ${state.season!.name ?? ''}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium
                                              ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface))
                                    ])),
                                    Icon(Icons.arrow_drop_down_rounded,
                                        size: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface)
                                  ],
                                ),
                              ),
                            ),
                          )
                        ])))
          ],
          if (state.episodes.isNotEmpty) ...[
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              sliver: SliverList.builder(
                itemCount: state.episodes.length * 2 -
                    ((state.status == EpisodesItemsStatus.loading ||
                            state.status == EpisodesItemsStatus.error ||
                            state.lastPage >= state.nextPage)
                        ? 0
                        : 1),
                itemBuilder: (BuildContext context, int index) {
                  if (index == state.episodes.length * 2 - 1) {
                    if (state.lastPage >= state.nextPage && state.status != EpisodesItemsStatus.loading && state.status != EpisodesItemsStatus.error) {
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(32),
                              onTap: () {
                                BlocProvider.of<EpisodesItemsCubit>(context).getEpisodes(
                                  page: BlocProvider.of<EpisodesItemsCubit>(context).state.nextPage
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  spacing: 8,
                                  children: [
                                    Text("سایر قسمت ها",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface)),
                                    Icon(Icons.arrow_drop_down_rounded,
                                        size: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      );
                    }
                    else if (state.status == EpisodesItemsStatus.loading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
                    }
                    else {
                      return CustomErrorWidget(
                          error: state.error!,
                          showIcon: false,
                          showMessage: true,
                          showTitle: false,
                          onRetry: () {
                            int page =
                                BlocProvider.of<EpisodesItemsCubit>(context)
                                    .state
                                    .nextPage;
                            BlocProvider.of<EpisodesItemsCubit>(context)
                                .getEpisodes(page: page, retry: true);
                          });
                    }
                  }
                  if (index % 2 == 0) {
                    int i = (index / 2).floor();
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: CachedNetworkImage(
                              imageUrl: state.episodes[i].thumbnail ?? "",
                              fit: BoxFit.cover,
                              height: width / 12 * 5 * 11 / 16,
                              width: width / 12 * 5),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: width / 12 * 5 * 11 / 16,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 4,
                                children: [
                                  Flexible(
                                    child: Text(
                                        "قسمت ${state.episodes[i].number ?? ''} ${state.episodes[i].name ?? ''}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface)),
                                  ),
                                  Expanded(
                                    child: Text(
                                        state.episodes[i].synopsis ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        textAlign: TextAlign.justify,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurfaceVariant)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return const Divider();
                  }
                },
              ),
            )
          ] else ...[
            if (state.status == EpisodesItemsStatus.loading) ...[
              const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              )
            ] else if (state.status == EpisodesItemsStatus.error) ...[
              SliverToBoxAdapter(
                child: CustomErrorWidget(
                    error: state.error!,
                    showIcon: false,
                    showMessage: true,
                    showTitle: false,
                    onRetry: () {
                      int page = BlocProvider.of<EpisodesItemsCubit>(context)
                          .state
                          .nextPage;
                      BlocProvider.of<EpisodesItemsCubit>(context)
                          .getEpisodes(page: page, retry: true);
                    }),
              )
            ] else ...[
              const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("قسمتی وجود ندارد"),
                  ),
                ),
              )
            ]
          ]
        ]);
      },
    );
  }
}
