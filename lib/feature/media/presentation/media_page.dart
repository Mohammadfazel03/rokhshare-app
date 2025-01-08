import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/config/dependency_injection.dart';
import 'package:rokhshare/feature/home/data/remote/model/media.dart';
import 'package:rokhshare/feature/media/presentation/widgets/comments_items_widget/bloc/comments_items_cubit.dart';
import 'package:rokhshare/feature/media/presentation/widgets/comments_items_widget/comments_items_widget.dart';
import 'package:rokhshare/feature/media/presentation/widgets/episodes_items_widget/bloc/episodes_items_cubit.dart';
import 'package:rokhshare/feature/media/presentation/widgets/episodes_items_widget/episodes_items_widget.dart';
import 'package:rokhshare/feature/media/presentation/widgets/media_action_button_widget.dart';
import 'package:rokhshare/feature/media/presentation/widgets/media_appbar_widget.dart';
import 'package:rokhshare/feature/media/presentation/widgets/media_rate_widget/bloc/media_rate_cubit.dart';
import 'package:rokhshare/feature/media/presentation/widgets/media_rate_widget/media_rate_widget.dart';
import 'package:rokhshare/feature/media/presentation/widgets/season_widget/bloc/season_cubit.dart';
import 'package:rokhshare/gen/assets.gen.dart';

import '../../../utils/error_widget.dart';
import 'bloc/media_cubit.dart';

class MediaPage extends StatefulWidget {
  final int mediaId;

  const MediaPage({super.key, required this.mediaId});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> with TickerProviderStateMixin {
  late final ScrollController scrollController;

  @override
  void initState() {
    BlocProvider.of<MediaCubit>(context).getMedia(widget.mediaId);
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: BlocBuilder<MediaCubit, MediaState>(
        builder: (context, state) {
          if (state is MediaSuccess) {
            return CustomScrollView(
              controller: scrollController,
              slivers: [
                MediaAppbarWidget(
                  mediaId: widget.mediaId,
                  name: state.data.name ?? "",
                  thumbnailUrl: state.data.thumbnail ?? "",
                  posterUrl: state.data.poster ?? "",
                  isPremium: state.data.isPremium ?? false,
                  mediaValue: state.data.value ?? MediaValue.subscription,
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Divider(),
                  ),
                ),
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            children: [
                              Text("تاربخ انتشار",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant)),
                              const SizedBox(height: 4),
                              Text(state.data.yearReleaseDate ?? "-",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface)),
                            ],
                          ),
                        )),
                        const VerticalDivider(width: 1),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            children: [
                              Text("امتیاز",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant)),
                              const SizedBox(height: 4),
                              Text(state.data.rate?.toString() ?? "-",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface)),
                            ],
                          ),
                        )),
                        const VerticalDivider(width: 1),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            children: [
                              if (state.data.isMovie == false) ...[
                                Text("تعداد فصل",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurfaceVariant)),
                                const SizedBox(height: 4),
                                Text(
                                    state.data.series?.seasonNumber
                                            ?.toString() ??
                                        "-",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface))
                              ] else if (state.data.isMovie == true) ...[
                                Text("زمان",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurfaceVariant)),
                                const SizedBox(height: 4),
                                Text("${state.data.movie?.time ?? "-"} دقیقه",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface))
                              ] else ...[
                                Text("زمان",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurfaceVariant)),
                                const SizedBox(height: 4),
                                Text("-",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface))
                              ]
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                )),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Divider(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text(
                      "خلاصه داستان: ",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text(
                      state.data.synopsis ?? "",
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 0,
                    runSpacing: 0,
                    children: [
                      Text("ژانرها: ",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant)),
                      Text(state.data.genresName,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface))
                    ],
                  ),
                )),
                SliverToBoxAdapter(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 0,
                    runSpacing: 0,
                    children: [
                      Text("کشورهای سازنده: ",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant)),
                      Text(state.data.countriesName,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface))
                    ],
                  ),
                )),
                SliverToBoxAdapter(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 24,
                    runSpacing: 8,
                    children: [
                      MediaActionButtonWidget(
                        text: "لیست من",
                        iconAssets: Assets.icons.bookmarkOutline.path,
                        selectedIconAssets: Assets.icons.bookmarkBold.path,
                      ),
                      BlocProvider(
                        create: (context) => MediaRateCubit(
                            repository: getIt.get(),
                            myRate: state.data.myRate,
                            mediaId: widget.mediaId),
                        child: const MediaRateWidget(),
                      ),
                      MediaActionButtonWidget(
                        text: "گالری تصاویر",
                        iconAssets: Assets.icons.galleryBold.path,
                        onTap: () {},
                      ),
                      MediaActionButtonWidget(
                        text: "اشتراک گذاری",
                        iconAssets: Assets.icons.shareLinear.path,
                      ),
                    ],
                  ),
                )),
                const SliverToBoxAdapter(
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: Divider())),
                if (state.data.isMovie == false) ...[
                  MultiBlocProvider(providers: [
                    BlocProvider(
                        create: (context) => EpisodesItemsCubit(
                            repository: getIt.get(),
                            total: (state.data.series?.seasons != null &&
                                    state.data.series!.seasons!.isNotEmpty)
                                ? (state.data.series?.seasons?[0]
                                        .episodeNumber ??
                                    0)
                                : 0,
                            episodes: (state.data.series?.seasons != null &&
                                    state.data.series!.seasons!.isNotEmpty)
                                ? (state.data.series?.seasons?[0].episodes ??
                                    [])
                                : [],
                            season: (state.data.series?.seasons != null &&
                                    state.data.series!.seasons!.isNotEmpty)
                                ? (state.data.series?.seasons?[0])
                                : null)),
                    BlocProvider(
                        create: (context) => SeasonCubit(
                            repository: getIt.get(),
                            seriesId: state.data.series?.id))
                  ], child: const EpisodesItemsWidget())
                ],
                if (state.data.casts?.isNotEmpty == true) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Text(
                        "عوامل سازنده",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: SizedBox(
                            height: (width * 0.22 + 16) *
                                    (((state.data.casts?.length ?? 0) >= 5)
                                        ? 2
                                        : 1) +
                                (((state.data.casts?.length ?? 0) >= 5)
                                    ? 10
                                    : 0),
                            child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            ((state.data.casts?.length ?? 0) >=
                                                    5)
                                                ? 2
                                                : 1,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 0.38),
                                itemCount: (state.data.casts?.length ?? 0),
                                itemBuilder: (c, i) {
                                  return InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(8),
                                    child: Ink(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surfaceContainer,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: const Offset(-0.5, 0.5),
                                                color: Theme.of(context)
                                                    .shadowColor,
                                                blurRadius: 0.5,
                                                spreadRadius: 0.01)
                                          ]),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: CachedNetworkImage(
                                                imageUrl: state.data.casts?[i]
                                                        .artist?.image ??
                                                    "",
                                                fit: BoxFit.cover,
                                                height: 0.22 * width,
                                                width: 0.22 * width),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 12),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                spacing: 4,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                        state.data.casts?[i]
                                                                .artist?.name ??
                                                            "",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelLarge
                                                            ?.copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSurface)),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                        state.data.casts?[i]
                                                                .position ??
                                                            "",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium
                                                            ?.copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSurfaceVariant)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )))
                ],
                BlocProvider(
                  create: (context) => CommentsItemsCubit(
                      repository: getIt.get(),
                      mediaId: widget.mediaId,
                      total: state.data.totalComments ?? 0,
                      comments: state.data.comments ?? []),
                  child: const CommentsItemsWidget(),
                )
              ],
            );
          } else if (state is MediaError) {
            return CustomErrorWidget(
                error: state.error,
                showIcon: true,
                showTitle: true,
                onRetry: () {
                  BlocProvider.of<MediaCubit>(context).getMedia(widget.mediaId);
                });
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        },
      ),
    );
  }
}
