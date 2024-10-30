import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rokhshare/feature/home/data/remote/model/collection.dart';
import 'package:rokhshare/feature/home/data/remote/model/media.dart';
import 'package:rokhshare/gen/assets.gen.dart';

class CollectionSliderWidget extends StatelessWidget {
  final Collection collection;

  const CollectionSliderWidget({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(collection.name ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Assets.icons.arrowLeftLinear
                            .svg(color: Theme.of(context).iconTheme.color)
                      ])),
              SizedBox(
                  height: 265,
                  child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
                      scrollDirection: Axis.horizontal,
                      itemCount: collection.media?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return MovieItem(media: collection.media![index]);
                      }))
            ]));
  }
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
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: GestureDetector(
          onTapDown: (_) {
            _changeScaleDown();
          },
          onTapUp: (_) {
            _changeScaleUp();
          },
          onTapCancel: () {
            _changeScaleUp();
          },
          child: AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 200),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                        imageUrl: widget.media.poster ?? "",
                        height: 200,
                        width: 150,
                        fit: BoxFit.fill),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                      width: 150,
                      child: Text(
                        widget.media.name ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))
                ]),
          ),
        ));
  }
}
