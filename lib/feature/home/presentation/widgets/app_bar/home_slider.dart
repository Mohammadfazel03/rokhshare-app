import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rokhshare/feature/home/data/remote/model/slider_model.dart';

class HomeSlider extends StatelessWidget {
  final List<SliderModel> sliders;

  const HomeSlider({super.key, required this.sliders});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return CarouselSlider(
      options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 4 / 5,
          enlargeCenterPage: true,
          enlargeFactor: 0.2,
          viewportFraction: 0.8,
          enableInfiniteScroll: false,
          enlargeStrategy: CenterPageEnlargeStrategy.scale),
      items: sliders
          .map((item) => CarouselSliderItem(item: item))
          .toList(growable: false),
    );
  }
}

class CarouselSliderItem extends StatefulWidget {
  final SliderModel item;

  const CarouselSliderItem({super.key, required this.item});

  @override
  State<CarouselSliderItem> createState() => _CarouselSliderItemState();
}

class _CarouselSliderItemState extends State<CarouselSliderItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: widget.item.poster ?? "",
              imageBuilder: (c, provider) {
                return Container(
                  decoration: BoxDecoration(
                      image:
                          DecorationImage(image: provider, fit: BoxFit.fill)),
                  clipBehavior: Clip.hardEdge,
                  child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black,
                                Colors.black.withOpacity(0)
                              ],
                              stops: const [
                                0.7,
                                0.8
                              ]).createShader(rect);
                        },
                        blendMode: BlendMode.dstOut,
                        child: Image(image: provider, fit: BoxFit.fill),
                      )),
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color(0x99000000),
                    Color(0x00000000),
                  ],
                  tileMode: TileMode.mirror,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 9, horizontal: 16),
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white.withOpacity(0.16)
                              : Colors.black.withOpacity(0.05),
                          child: const Text(
                            "پرطرفدار",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 9, horizontal: 16),
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white.withOpacity(0.16)
                              : Colors.black.withOpacity(0.05),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.star_border_rounded,
                                  color: Colors.white, size: 18),
                              Text(
                                " ${widget.item.rating ?? "--"} ",
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color(0x00000000),
                      Color(0xB3000000),
                    ],
                    tileMode: TileMode.mirror,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.title ?? widget.item.media?.name ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (widget.item.description != widget.item.title &&
                          widget.item.description != null &&
                          widget.item.description != "")
                        ...[
                          const SizedBox(height: 4),
                          Text(widget.item.description ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ]
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// class HomeAppBar extends StatelessWidget {
//   const HomeAppBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.sizeOf(context).width;
//     print("build appbar");
//     return SliverAppBar(
//       pinned: true,
//       snap: false,
//       floating: false,
//       expandedHeight: width * 4 / 3,
//       flexibleSpace: CustomFlexibleSpaceBar(
//         title: Text("رخشاره"),
//         collapseMode: CollapseMode.pin,
//         // background: BlocConsumer<SliderCubit, SliderState>(
//         //   listener: (BuildContext context, SliderState state) {
//         //     if (state is SliderInitialState) {
//         //       BlocProvider.of<SliderCubit>(context).getSlider();
//         //     }
//         //   },
//         //   builder: (context, state) {
//         //     if (state is SliderLoadingState) {
//         //       return Center(
//         //         child: LinearProgressIndicator(),
//         //       );
//         //     } else if (state is SliderSuccessState) {
//         //       return CarouselSlider(
//         //         options: CarouselOptions(
//         //             enableInfiniteScroll: false,
//         //             height: width * 4 / 3,
//         //             autoPlay: true,
//         //             aspectRatio: 3 / 4,
//         //             viewportFraction: 1),
//         //         items: [
//         //           for (final slide in state.slides) ...[
//         //             Image.network(
//         //               slide.poster ?? "",
//         //               errorBuilder: (BuildContext context, Object exception,
//         //                   StackTrace? stackTrace) {
//         //                 return Center(child: Assets.icons.imageBroken.svg());
//         //               },
//         //               loadingBuilder: (BuildContext context, Widget child,
//         //                   ImageChunkEvent? loadingProgress) {
//         //                 if (loadingProgress == null) {
//         //                   return child;
//         //                 }
//         //                 return Center(child: Assets.icons.reelLinear.svg());
//         //               },
//         //             )
//         //           ]
//         //         ],
//         //       );
//         //     } else if (state is SliderErrorState) {
//         //       return Column(
//         //         mainAxisSize: MainAxisSize.max,
//         //         mainAxisAlignment: MainAxisAlignment.center,
//         //         children: [
//         //           Text(state.error),
//         //           TextButton.icon(
//         //             onPressed: () {
//         //               BlocProvider.of<SliderCubit>(context).getSlider();
//         //             },
//         //             label: Text("تلاش دوباره"),
//         //             icon: Assets.icons.restartLinear.svg(),
//         //           )
//         //         ],
//         //       );
//         //     }
//         //     return Column(
//         //       mainAxisSize: MainAxisSize.max,
//         //       mainAxisAlignment: MainAxisAlignment.center,
//         //       children: [
//         //         Text("مشکلی در دریافت اطلاعات پیش آمده."),
//         //         TextButton.icon(
//         //             onPressed: () {
//         //               BlocProvider.of<SliderCubit>(context).getSlider();
//         //             },
//         //             label: Text("تلاش دوباره"),
//         //             icon: Assets.icons.restartLinear.svg())
//         //       ],
//         //     );
//         //   },
//         // ),
//         background: CarouselSlider(
//           options: CarouselOptions(
//               enableInfiniteScroll: false,
//               height: width * 4 / 3,
//               autoPlay: true,
//               aspectRatio: 3 / 4,
//               viewportFraction: 1),
//           items: [
//             for (int i = 0; i <= 10; i++) ...[
//               // Image.network(
//               //   slide.poster ?? "",
//               //   errorBuilder: (BuildContext context, Object exception,
//               //       StackTrace? stackTrace) {
//               //     return Center(child: Assets.icons.imageBroken.svg());
//               //   },
//               //   loadingBuilder: (BuildContext context, Widget child,
//               //       ImageChunkEvent? loadingProgress) {
//               //     if (loadingProgress == null) {
//               //       return child;
//               //     }
//               //     return Center(child: Assets.icons.reelLinear.svg());
//               //   },
//               // )
//               DecoratedBox(
//                   decoration: BoxDecoration(color: Colors.red),
//                   child: SizedBox.expand())
//             ]
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CustomFlexibleSpaceBar extends StatefulWidget {
//   const CustomFlexibleSpaceBar({
//     super.key,
//     this.title,
//     this.background,
//     this.titlePadding,
//     this.collapseMode = CollapseMode.parallax,
//   });
//
//   final Widget? title;
//   final Widget? background;
//   final CollapseMode collapseMode;
//   final EdgeInsetsGeometry? titlePadding;
//
//   @override
//   State<CustomFlexibleSpaceBar> createState() => _CustomFlexibleSpaceBarState();
// }
//
// class _CustomFlexibleSpaceBarState extends State<CustomFlexibleSpaceBar> {
//   double _getCollapsePadding(double t, FlexibleSpaceBarSettings settings) {
//     switch (widget.collapseMode) {
//       case CollapseMode.pin:
//         return -(settings.maxExtent - settings.currentExtent);
//       case CollapseMode.none:
//         return 0.0;
//       case CollapseMode.parallax:
//         final double deltaExtent = settings.maxExtent - settings.minExtent;
//         return -Tween<double>(begin: 0.0, end: deltaExtent / 4.0).transform(t);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         final FlexibleSpaceBarSettings settings = context
//             .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;
//
//         final List<Widget> children = <Widget>[];
//
//         final double deltaExtent = settings.maxExtent - settings.minExtent;
//
//         // 0.0 -> Expanded
//         // 1.0 -> Collapsed to toolbar
//         final double t = clampDouble(
//             1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent,
//             0.0,
//             1.0);
//
//         final double fadeStart =
//             math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
//         const double fadeEnd = 1.0;
//         assert(fadeStart <= fadeEnd);
//         // If the min and max extent are the same, the app bar cannot collapse
//         // and the content should be visible, so opacity = 1.
//         final double opacity = settings.maxExtent == settings.minExtent
//             ? 1.0
//             : 1.0 - Interval(fadeStart, fadeEnd).transform(t);
//
//         // background
//         if (widget.background != null) {
//           double height = settings.maxExtent;
//           // height = constraints.maxHeight;
//
//           final double topPadding = _getCollapsePadding(t, settings);
//           children.add(Positioned(
//             top: topPadding,
//             left: 0.0,
//             right: 0.0,
//             height: height,
//             child: _FlexibleSpaceHeaderOpacity(
//                 // IOS is relying on this semantics node to correctly traverse
//                 // through the app bar when it is collapsed.
//                 alwaysIncludeSemantics: true,
//                 opacity: opacity,
//                 child: widget.background),
//           ));
//         }
//
//         // title
//         if (widget.title != null) {
//           final ThemeData theme = Theme.of(context);
//
//           Widget? title;
//           switch (theme.platform) {
//             case TargetPlatform.iOS:
//             case TargetPlatform.macOS:
//               title = widget.title;
//             case TargetPlatform.android:
//             case TargetPlatform.fuchsia:
//             case TargetPlatform.linux:
//             case TargetPlatform.windows:
//               title = Semantics(
//                 namesRoute: true,
//                 child: widget.title,
//               );
//           }
//
//           TextStyle titleStyle = theme.textTheme.titleLarge!;
//
//           final EdgeInsetsGeometry padding = widget.titlePadding ??
//               EdgeInsetsDirectional.only(
//                 start: 0.0,
//                 bottom: 16.0,
//               );
//           children.add(Opacity(
//             opacity: 1 - opacity,
//             child: Container(
//               padding: padding,
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: DefaultTextStyle(
//                   style: titleStyle,
//                   child: LayoutBuilder(
//                     builder:
//                         (BuildContext context, BoxConstraints constraints) {
//                       return Container(
//                         width: constraints.maxWidth,
//                         alignment: Alignment.bottomCenter,
//                         child: title,
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ));
//         }
//
//         return ClipRect(child: Stack(children: children));
//       },
//     );
//   }
// }
//
// class _FlexibleSpaceHeaderOpacity extends SingleChildRenderObjectWidget {
//   const _FlexibleSpaceHeaderOpacity(
//       {required this.opacity,
//       required super.child,
//       required this.alwaysIncludeSemantics});
//
//   final double opacity;
//   final bool alwaysIncludeSemantics;
//
//   @override
//   RenderObject createRenderObject(BuildContext context) {
//     return _RenderFlexibleSpaceHeaderOpacity(
//         opacity: opacity, alwaysIncludeSemantics: alwaysIncludeSemantics);
//   }
//
//   @override
//   void updateRenderObject(BuildContext context,
//       covariant _RenderFlexibleSpaceHeaderOpacity renderObject) {
//     renderObject
//       ..alwaysIncludeSemantics = alwaysIncludeSemantics
//       ..opacity = opacity;
//   }
// }
//
// class _RenderFlexibleSpaceHeaderOpacity extends RenderOpacity {
//   _RenderFlexibleSpaceHeaderOpacity(
//       {super.opacity, super.alwaysIncludeSemantics});
//
//   @override
//   bool get isRepaintBoundary => false;
//
//   @override
//   void paint(PaintingContext context, Offset offset) {
//     if (child == null) {
//       return;
//     }
//     if ((opacity * 255).roundToDouble() <= 0) {
//       layer = null;
//       return;
//     }
//     assert(needsCompositing);
//     layer = context.pushOpacity(offset, (opacity * 255).round(), super.paint,
//         oldLayer: layer as OpacityLayer?);
//     assert(() {
//       layer!.debugCreator = debugCreator;
//       return true;
//     }());
//   }
// }
