import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rokhshare/feature/gallery/data/remote/model/gallery.dart';
import 'package:rokhshare/feature/trailer_player/presentation/trailer_player_page.dart';
import 'package:rokhshare/gen/assets.gen.dart';

class GalleryItemWidget extends StatefulWidget {
  final Gallery gallery;

  const GalleryItemWidget({super.key, required this.gallery});

  @override
  State<GalleryItemWidget> createState() => _GalleryItemWidgetState();
}

class _GalleryItemWidgetState extends State<GalleryItemWidget> {
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
      onTap: () {
        if (widget.gallery.isVideo) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) =>
                  TrailerPlayerPage(trailer: widget.gallery.file?.file ?? "")));
        }
      },
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
        child: Stack(
          children: [
            Positioned.fill(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                imageUrl: widget.gallery.isVideo
                    ? (widget.gallery.file?.thumbnail ?? "")
                    : (widget.gallery.file?.file ?? ""),
                fit: BoxFit.cover,
              ),
            )),
            if (widget.gallery.isVideo) ...[
              Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryContainer
                          .withAlpha((255 * 0.5).round())),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Assets.icons.playBold.svg(
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.onSecondaryContainer,
                            BlendMode.srcIn)),
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
