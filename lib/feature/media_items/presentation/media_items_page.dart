import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/feature/media_items/presentation/bloc/media_items_cubit.dart';
import 'package:rokhshare/feature/search/presentation/search_page.dart';
import 'package:rokhshare/gen/assets.gen.dart';
import 'package:rokhshare/utils/error_entity.dart';
import 'package:rokhshare/utils/error_widget.dart';

class MediaItemsPage extends StatefulWidget {
  final int? categoryId;
  final int? collectionId;
  final String title;

  const MediaItemsPage(
      {super.key, this.categoryId, this.collectionId, required this.title});

  @override
  State<MediaItemsPage> createState() => _MediaItemsPageState();
}

class _MediaItemsPageState extends State<MediaItemsPage> {
  int? get categoryId => widget.categoryId;

  int? get collectionId => widget.collectionId;

  @override
  void initState() {
    if (!((categoryId != null && collectionId != null) ||
        (categoryId == null && collectionId == null))) {
      if (categoryId != null) {
        BlocProvider.of<MediaItemsCubit>(context)
            .getCategoryItems(categoryId: categoryId!);
      } else {
        BlocProvider.of<MediaItemsCubit>(context)
            .getCollectionItems(collectionId: collectionId!);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
          surfaceTintColor: Theme.of(context).colorScheme.surfaceTint),
      body: (categoryId == null && collectionId == null) ||
              (categoryId != null && collectionId != null)
          ? error()
          : (categoryId == null)
              ? collectionSection()
              : categorySection(),
    );
  }

  Widget error() {
    return CustomErrorWidget(
      error: const ErrorEntity(
          title: "خطا در پردازش اطلاعات",
          error: "در پردازش اظلاعات خطایی به وجود آمده است.",
          code: null),
      onRetry: () {},
      showIcon: true,
      icon: Assets.images.errorEmote.svg(width: 256, height: 256),
      showTitle: true,
      retryButton: TextButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
          },
          label: const Text("بازگشت به صفحه قبلی"),
          icon: const Icon(Icons.arrow_back)),
    );
  }

  Widget categorySection() {
    var width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<MediaItemsCubit, MediaItemsState>(
        builder: (context, state) {
      if (state.status == MediaItemsStatus.initial) {
        return const SizedBox.shrink();
      } else if (state.status == MediaItemsStatus.loading &&
          state.media.isEmpty) {
        return const Center(child: CircularProgressIndicator.adaptive());
      } else if (state.status == MediaItemsStatus.error &&
          state.media.isEmpty) {
        return CustomErrorWidget(
            error: state.error!,
            showIcon: true,
            showTitle: true,
            onRetry: () {
              BlocProvider.of<MediaItemsCubit>(context)
                  .getCategoryItems(categoryId: categoryId!, retry: true);
            });
      } else if (state.status == MediaItemsStatus.success &&
          state.media.isEmpty) {
        return const Center(child: Text("موردی یافت نشد!"));
      }

      var titleTextHeight =
          _textSize("text", Theme.of(context).textTheme.labelLarge).height;
      var subtitleTextHeight =
          _textSize("text", Theme.of(context).textTheme.labelSmall).height;

      var mainWidth =
          (width - 16 - ((width / 200).floor() * 8)) / (width / 200).floor();
      var mainHeight =
          (mainWidth * 3 / 2) + 16 + titleTextHeight + subtitleTextHeight;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: mainWidth / mainHeight,
            ),
            itemCount: state.status == MediaItemsStatus.success
                ? state.media.length
                : state.media.length + 1,
            itemBuilder: (context, index) {
              if (index == state.media.length) {
                if (state.status == MediaItemsStatus.loading) {
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
                        int page = BlocProvider.of<MediaItemsCubit>(context)
                            .state
                            .nextPage;
                        BlocProvider.of<MediaItemsCubit>(context)
                            .getCategoryItems(
                                categoryId: categoryId!,
                                page: page,
                                retry: true);
                      });
                }
              }
              return MovieItem(media: state.media[index]);
            }),
      );
    });
  }

  Widget collectionSection() {
    var width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<MediaItemsCubit, MediaItemsState>(
        builder: (context, state) {
      if (state.status == MediaItemsStatus.initial) {
        return const SizedBox.shrink();
      } else if (state.status == MediaItemsStatus.loading &&
          state.media.isEmpty) {
        return const Center(child: CircularProgressIndicator.adaptive());
      } else if (state.status == MediaItemsStatus.error &&
          state.media.isEmpty) {
        return CustomErrorWidget(
            error: state.error!,
            showIcon: true,
            showTitle: true,
            onRetry: () {
              BlocProvider.of<MediaItemsCubit>(context)
                  .getCollectionItems(collectionId: collectionId!, retry: true);
            });
      } else if (state.status == MediaItemsStatus.success &&
          state.media.isEmpty) {
        return const Center(child: Text("موردی یافت نشد!"));
      }

      var titleTextHeight =
          _textSize("text", Theme.of(context).textTheme.labelLarge).height;
      var subtitleTextHeight =
          _textSize("text", Theme.of(context).textTheme.labelSmall).height;

      var mainWidth =
          (width - 16 - ((width / 200).floor() * 8)) / (width / 200).floor();
      var mainHeight =
          (mainWidth * 3 / 2) + 16 + titleTextHeight + subtitleTextHeight;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: mainWidth / mainHeight,
            ),
            itemCount: state.status == MediaItemsStatus.success
                ? state.media.length
                : state.media.length + 1,
            itemBuilder: (context, index) {
              if (index == state.media.length) {
                if (state.status == MediaItemsStatus.loading) {
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
                        int page = BlocProvider.of<MediaItemsCubit>(context)
                            .state
                            .nextPage;
                        BlocProvider.of<MediaItemsCubit>(context)
                            .getCollectionItems(
                                collectionId: collectionId!,
                                page: page,
                                retry: true);
                      });
                }
              }
              return MovieItem(media: state.media[index]);
            }),
      );
    });
  }

  Size _textSize(String text, TextStyle? style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.rtl)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
