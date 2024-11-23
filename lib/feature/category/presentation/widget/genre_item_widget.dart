import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/config/dependency_injection.dart';
import 'package:rokhshare/feature/home/data/remote/model/genre.dart';
import 'package:rokhshare/feature/media_items/presentation/bloc/media_items_cubit.dart';
import 'package:rokhshare/feature/media_items/presentation/media_items_page.dart';

class GenreItemWidget extends StatefulWidget {
  final Genre genre;

  const GenreItemWidget({super.key, required this.genre});

  @override
  State<GenreItemWidget> createState() => _GenreItemWidgetState();
}

class _GenreItemWidgetState extends State<GenreItemWidget> {
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
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => MediaItemsCubit(repository: getIt.get()),
                  child: MediaItemsPage(
                      title: widget.genre.title ?? "",
                      categoryId: widget.genre.id),
                )));
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
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image:
                      CachedNetworkImageProvider(widget.genre.poster ?? ""))),
          child: Stack(
            children: [
              Positioned.fill(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4))))),
              // Positioned.fill(
              //     child: ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Text(widget.genre.title ?? "",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
