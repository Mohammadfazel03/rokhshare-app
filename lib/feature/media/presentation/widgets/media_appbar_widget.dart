import 'dart:math' as math;
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/config/dependency_injection.dart';
import 'package:rokhshare/config/local_storage_service.dart';
import 'package:rokhshare/feature/home/data/remote/model/media.dart';
import 'package:rokhshare/feature/login/presentation/bloc/login_cubit.dart';
import 'package:rokhshare/feature/login/presentation/login_page.dart';
import 'package:rokhshare/feature/media/presentation/bloc/media_cubit.dart';
import 'package:rokhshare/feature/plan/presentation/bloc/plan_cubit.dart';
import 'package:rokhshare/feature/plan/presentation/plan_page.dart';
import 'package:rokhshare/feature/play/presentation/bloc/play_cubit.dart';
import 'package:rokhshare/feature/play/presentation/player_page.dart';
import 'package:rokhshare/feature/trailer_player/presentation/trailer_player_page.dart';
import 'package:rokhshare/feature/user/presentation/bloc/auth_cubit.dart';
import 'package:rokhshare/gen/assets.gen.dart';

class MediaAppbarWidget extends StatelessWidget {
  final String name;
  final String trailerUrl;
  final int mediaId;
  final int? movieId;
  final int? episodeId;
  final String thumbnailUrl;
  final String posterUrl;
  final bool isPremium;
  final MediaValue mediaValue;

  const MediaAppbarWidget(
      {super.key,
      required this.name,
      required this.thumbnailUrl,
      required this.posterUrl,
      required this.isPremium,
      required this.mediaValue,
      required this.mediaId,
      required this.trailerUrl,
      this.movieId,
      this.episodeId});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return SliverAppBar(
      collapsedHeight: kToolbarHeight,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      pinned: true,
      stretch: true,
      expandedHeight: (width * 11 / 16) + 22,
      clipBehavior: Clip.antiAlias,
      flexibleSpace: CustomFlexibleSpaceBar(
        title: Text(
          name,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        background: DecoratedBox(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.surface),
          child: Stack(
            children: [
              Positioned(
                  child: CachedNetworkImage(
                imageUrl: thumbnailUrl,
                fit: BoxFit.cover,
                height: width * 11 / 16,
                width: width,
                imageBuilder: (c, provider) {
                  return Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: provider, fit: BoxFit.cover)),
                    clipBehavior: Clip.hardEdge,
                    child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Theme.of(context).colorScheme.surface,
                                  Theme.of(context)
                                      .colorScheme
                                      .surface
                                      .withAlpha(0)
                                ]).createShader(rect);
                          },
                          blendMode: BlendMode.dstOut,
                          child: Image(image: provider, fit: BoxFit.cover),
                        )),
                  );
                },
              )),
              Positioned(
                  bottom: 20 + statusBarHeight,
                  right: 0,
                  left: 0,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Theme.of(context).colorScheme.surface.withAlpha(0),
                            Theme.of(context)
                                .colorScheme
                                .surface
                                .withAlpha((0.05 * 255).round()),
                            Theme.of(context)
                                .colorScheme
                                .surface
                                .withAlpha((0.1 * 255).round()),
                            Theme.of(context)
                                .colorScheme
                                .surface
                                .withAlpha((0.5 * 255).round()),
                          ],
                          tileMode: TileMode.clamp,
                        ),
                      ),
                      child: SizedBox(height: width * 11 / 16, width: width))),
              Positioned(
                  bottom: 20 + statusBarHeight + 16,
                  right: width / 3 + 16,
                  left: 8,
                  child: Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  )),
              Positioned(
                  left: 8,
                  right: width / 3 + 16,
                  bottom: 0,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FutureBuilder(
                          future: getIt.get<LocalStorageService>().isLogin(),
                          builder: (context, data) {
                            if (!data.hasError) {
                              if (data.data == true && isPremium) {
                                return Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: FilledButton.icon(
                                        onPressed:
                                            movieId != null || episodeId != null
                                                ? () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                BlocProvider(
                                                                  create: (context) =>
                                                                      PlayCubit(
                                                                          playRepository:
                                                                              getIt.get()),
                                                                  child: PlayerPage(
                                                                      media:
                                                                          mediaId,
                                                                      episode:
                                                                          episodeId,
                                                                      movie:
                                                                          movieId),
                                                                )));
                                                  }
                                                : null,
                                        label: const Text('تماشا'),
                                        icon: Assets.icons.playBold.svg(
                                            height: 16,
                                            width: 16,
                                            colorFilter: ColorFilter.mode(
                                                movieId != null ||
                                                        episodeId != null
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary
                                                    : Theme.of(context)
                                                        .disabledColor,
                                                BlendMode.srcIn)),
                                        style: ButtonStyle(
                                            padding:
                                                const WidgetStatePropertyAll(
                                                    EdgeInsets.all(2)),
                                            textStyle: WidgetStatePropertyAll(
                                                Theme.of(context)
                                                    .textTheme
                                                    .labelSmall),
                                            shape: WidgetStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)))),
                                      )),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                );
                              } else if (data.data == true &&
                                  !isPremium &&
                                  (mediaValue == MediaValue.advertising ||
                                      mediaValue == MediaValue.free)) {
                                return Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: FilledButton.icon(
                                        onPressed:
                                            movieId != null || episodeId != null
                                                ? () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                BlocProvider(
                                                                  create: (context) =>
                                                                      PlayCubit(
                                                                          playRepository:
                                                                              getIt.get()),
                                                                  child: PlayerPage(
                                                                      media:
                                                                          mediaId,
                                                                      episode:
                                                                          episodeId,
                                                                      movie:
                                                                          movieId),
                                                                )));
                                                  }
                                                : null,
                                        label: const Text('تماشا رایگان'),
                                        icon: Assets.icons.playBold.svg(
                                            height: 16,
                                            width: 16,
                                            colorFilter: ColorFilter.mode(
                                                movieId != null ||
                                                        episodeId != null
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary
                                                    : Theme.of(context)
                                                        .disabledColor,
                                                BlendMode.srcIn)),
                                        style: ButtonStyle(
                                            padding:
                                                const WidgetStatePropertyAll(
                                                    EdgeInsets.all(2)),
                                            textStyle: WidgetStatePropertyAll(
                                                Theme.of(context)
                                                    .textTheme
                                                    .labelSmall),
                                            shape: WidgetStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)))),
                                      )),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                );
                              } else if (data.data == true && !isPremium) {
                                return Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: FilledButton.icon(
                                        onPressed: () async {
                                          await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder:
                                                      (_) => MultiBlocProvider(
                                                            providers: [
                                                              BlocProvider(
                                                                  create: (context) =>
                                                                      PlanCubit(
                                                                          repository:
                                                                              getIt.get())),
                                                              BlocProvider.value(
                                                                  value: BlocProvider
                                                                      .of<AuthCubit>(
                                                                          context))
                                                            ],
                                                            child: PlanPage(
                                                                username: BlocProvider.of<
                                                                            AuthCubit>(
                                                                        context)
                                                                    .state
                                                                    .username),
                                                          )));
                                          BlocProvider.of<MediaCubit>(context)
                                              .getMedia(mediaId);
                                        },
                                        label: const Text('خرید اشتراک'),
                                        icon: Assets.icons.ticketBoldDuotone
                                            .svg(
                                                height: 16,
                                                width: 16,
                                                colorFilter: ColorFilter.mode(
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                    BlendMode.srcIn)),
                                        style: ButtonStyle(
                                            padding:
                                                const WidgetStatePropertyAll(
                                                    EdgeInsets.all(2)),
                                            textStyle: WidgetStatePropertyAll(
                                                Theme.of(context)
                                                    .textTheme
                                                    .labelSmall),
                                            shape: WidgetStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)))),
                                      )),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                );
                              } else if (data.data == false ||
                                  data.data == null) {
                                return Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: FilledButton.icon(
                                        onPressed: () async {
                                          await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder:
                                                      (_) => MultiBlocProvider(
                                                            providers: [
                                                              BlocProvider(
                                                                  create: (context) =>
                                                                      LoginCubit(
                                                                          loginRepository:
                                                                              getIt.get())),
                                                              BlocProvider.value(
                                                                  value: BlocProvider
                                                                      .of<AuthCubit>(
                                                                          context))
                                                            ],
                                                            child:
                                                                const LoginPage(),
                                                          )));
                                          BlocProvider.of<MediaCubit>(context)
                                              .getMedia(mediaId);
                                        },
                                        label: const Text('ورود و تماشا'),
                                        style: ButtonStyle(
                                            padding:
                                                const WidgetStatePropertyAll(
                                                    EdgeInsets.all(2)),
                                            textStyle: WidgetStatePropertyAll(
                                                Theme.of(context)
                                                    .textTheme
                                                    .labelSmall),
                                            shape: WidgetStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)))),
                                      )),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                );
                              }
                            }
                            return const SizedBox.shrink();
                          }),
                      Expanded(
                          child: FilledButton.tonal(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => TrailerPlayerPage(
                                        trailer: trailerUrl)));
                              },
                              style: ButtonStyle(
                                  padding: const WidgetStatePropertyAll(
                                      EdgeInsets.all(2)),
                                  textStyle: WidgetStatePropertyAll(
                                      Theme.of(context).textTheme.labelSmall),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)))),
                              child: const Text('پیش نمایش'))),
                    ],
                  )),
              Positioned(
                right: 4,
                bottom: 0,
                child: Card(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                          imageUrl: posterUrl,
                          fit: BoxFit.fill,
                          height: width / 3 * 4 / 3,
                          width: width / 3)),
                ),
              )
            ],
          ),
        ),
        collapseMode: CollapseMode.pin,
      ),
    );
  }
}

class CustomFlexibleSpaceBar extends StatefulWidget {
  const CustomFlexibleSpaceBar({
    super.key,
    this.title,
    this.background,
    this.titlePadding,
    this.collapseMode = CollapseMode.parallax,
  });

  final Widget? title;
  final Widget? background;
  final CollapseMode collapseMode;
  final EdgeInsetsGeometry? titlePadding;

  @override
  State<CustomFlexibleSpaceBar> createState() => _CustomFlexibleSpaceBarState();
}

class _CustomFlexibleSpaceBarState extends State<CustomFlexibleSpaceBar> {
  double _getCollapsePadding(double t, FlexibleSpaceBarSettings settings) {
    switch (widget.collapseMode) {
      case CollapseMode.pin:
        return -(settings.maxExtent - settings.currentExtent);
      case CollapseMode.none:
        return 0.0;
      case CollapseMode.parallax:
        final double deltaExtent = settings.maxExtent - settings.minExtent;
        return -Tween<double>(begin: 0.0, end: deltaExtent / 4.0).transform(t);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final FlexibleSpaceBarSettings settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;

        final List<Widget> children = <Widget>[];

        final double deltaExtent = settings.maxExtent - settings.minExtent;

        // 0.0 -> Expanded
        // 1.0 -> Collapsed to toolbar
        final double t = clampDouble(
            1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent,
            0.0,
            1.0);

        final double fadeStart =
            math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
        const double fadeEnd = 1.0;
        assert(fadeStart <= fadeEnd);
        // If the min and max extent are the same, the app bar cannot collapse
        // and the content should be visible, so opacity = 1.
        final double opacity = settings.maxExtent == settings.minExtent
            ? 1.0
            : 1.0 - Interval(fadeStart, fadeEnd).transform(t);

        // background
        if (widget.background != null) {
          double height = settings.maxExtent;
          // height = constraints.maxHeight;

          final double topPadding = _getCollapsePadding(t, settings);
          children.add(Positioned(
            top: topPadding,
            left: 0.0,
            right: 0.0,
            height: height,
            child: _FlexibleSpaceHeaderOpacity(
                // IOS is relying on this semantics node to correctly traverse
                // through the app bar when it is collapsed.
                alwaysIncludeSemantics: true,
                opacity: opacity,
                child: widget.background),
          ));
        }

        // title
        if (widget.title != null) {
          final ThemeData theme = Theme.of(context);

          Widget? title;
          switch (theme.platform) {
            case TargetPlatform.iOS:
            case TargetPlatform.macOS:
              title = widget.title;
            case TargetPlatform.android:
            case TargetPlatform.fuchsia:
            case TargetPlatform.linux:
            case TargetPlatform.windows:
              title = Semantics(
                namesRoute: true,
                child: widget.title,
              );
          }

          TextStyle titleStyle = theme.textTheme.titleLarge!;

          final EdgeInsetsGeometry padding = widget.titlePadding ??
              const EdgeInsetsDirectional.only(
                start: 0.0,
                bottom: 16.0,
              );
          children.add(Opacity(
            opacity: 1 - opacity,
            child: Container(
              padding: padding,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: DefaultTextStyle(
                  style: titleStyle,
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Container(
                        width: constraints.maxWidth,
                        alignment: Alignment.bottomCenter,
                        child: title,
                      );
                    },
                  ),
                ),
              ),
            ),
          ));
        }

        return ClipRect(child: Stack(children: children));
      },
    );
  }
}

class _FlexibleSpaceHeaderOpacity extends SingleChildRenderObjectWidget {
  const _FlexibleSpaceHeaderOpacity(
      {required this.opacity,
      required super.child,
      required this.alwaysIncludeSemantics});

  final double opacity;
  final bool alwaysIncludeSemantics;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderFlexibleSpaceHeaderOpacity(
        opacity: opacity, alwaysIncludeSemantics: alwaysIncludeSemantics);
  }

  @override
  void updateRenderObject(BuildContext context,
      covariant _RenderFlexibleSpaceHeaderOpacity renderObject) {
    renderObject
      ..alwaysIncludeSemantics = alwaysIncludeSemantics
      ..opacity = opacity;
  }
}

class _RenderFlexibleSpaceHeaderOpacity extends RenderOpacity {
  _RenderFlexibleSpaceHeaderOpacity(
      {super.opacity, super.alwaysIncludeSemantics});

  @override
  bool get isRepaintBoundary => false;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) {
      return;
    }
    if ((opacity * 255).roundToDouble() <= 0) {
      layer = null;
      return;
    }
    assert(needsCompositing);
    layer = context.pushOpacity(offset, (opacity * 255).round(), super.paint,
        oldLayer: layer as OpacityLayer?);
    assert(() {
      layer!.debugCreator = debugCreator;
      return true;
    }());
  }
}
