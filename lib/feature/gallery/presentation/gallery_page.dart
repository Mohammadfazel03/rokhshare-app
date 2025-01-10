import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/feature/gallery/presentation/widget/gallery_item_widget.dart';
import 'package:rokhshare/utils/error_widget.dart';

import 'bloc/gallery_cubit.dart';

class GalleryPage extends StatefulWidget {
  final int media;

  const GalleryPage({super.key, required this.media});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage>
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
      int page = BlocProvider.of<GalleryCubit>(context).state.nextPage;
      BlocProvider.of<GalleryCubit>(context)
          .getGalleries(mediaId: widget.media, page: page);
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GalleryCubit>(context)
        .getGalleries(mediaId: widget.media, page: 1);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    super.build(context);
    return Scaffold(
      body: BlocBuilder<GalleryCubit, GalleryState>(
        builder: (context, state) {
          if ((state.status == GalleryStatus.loading ||
                  state.status == GalleryStatus.initial) &&
              state.gallery.isEmpty) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state.status == GalleryStatus.error &&
              state.gallery.isEmpty) {
            return CustomErrorWidget(
                error: state.error!,
                showIcon: true,
                showTitle: true,
                onRetry: () {
                  BlocProvider.of<GalleryCubit>(context)
                      .getGalleries(mediaId: widget.media, retry: true);
                });
          } else if (state.gallery.isEmpty) {
            return const Center(child: Text("تصویری در گالری وجود ندارد"));
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (width / 250).round(),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 16 / 9,
                ),
                controller: _scrollController,
                itemCount: state.status == GalleryStatus.success
                    ? state.gallery.length
                    : state.gallery.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.gallery.length) {
                    if (state.status == GalleryStatus.loading) {
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
                            int page = BlocProvider.of<GalleryCubit>(context)
                                .state
                                .nextPage;
                            BlocProvider.of<GalleryCubit>(context).getGalleries(
                                mediaId: widget.media, page: page, retry: true);
                          });
                    }
                  }
                  return GalleryItemWidget(gallery: state.gallery[index]);
                }),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
