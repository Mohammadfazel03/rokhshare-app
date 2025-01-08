import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MediaActionButtonWidget extends StatefulWidget {
  final String text;
  final String iconAssets;
  final String? selectedIconAssets;
  final bool isSelected;
  final Function()? onTap;

  const MediaActionButtonWidget(
      {super.key,
      required this.text,
      required this.iconAssets,
      this.isSelected = false,
      this.selectedIconAssets,
      this.onTap});

  @override
  State<MediaActionButtonWidget> createState() =>
      _MediaActionButtonWidgetState();
}

class _MediaActionButtonWidgetState extends State<MediaActionButtonWidget> {
  late bool isSelected;

  @override
  void initState() {
    isSelected = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      tooltip: widget.text,
      padding: const EdgeInsets.all(16),
        onPressed: () {
          if (widget.selectedIconAssets != null) {
            setState(() {
              isSelected = !isSelected;
            });
          }
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        icon: SvgPicture(SvgAssetLoader(widget.iconAssets),
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onSecondaryContainer,
                    BlendMode.srcIn),
                height: 24,
                width: 24)
            .animate(target: isSelected ? 1 : 0)
            .swap(
                duration: 50.ms,
                builder: (_, __) => SvgPicture(
                    SvgAssetLoader(widget.selectedIconAssets ?? ""),
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onSecondaryContainer,
                        BlendMode.srcIn),
                    height: 24,
                    width: 24)));
    // return Column(
    //   mainAxisSize: MainAxisSize.min,
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     InkWell(
    //       radius: 32,
    //       onTap: () {
    //         if (widget.selectedIconAssets != null) {
    //           setState(() {
    //             isSelected = !isSelected;
    //           });
    //         }
    //         if (widget.onTap != null) {
    //           widget.onTap!();
    //         }
    //       },
    //       child: DecoratedBox(
    //         decoration: BoxDecoration(
    //             color: Theme.of(context).colorScheme.secondaryContainer,
    //             borderRadius: BorderRadius.circular(32)),
    //         child: Padding(
    //           padding: const EdgeInsets.all(12),
    //           child: SvgPicture(SvgAssetLoader(widget.iconAssets),
    //                   colorFilter: ColorFilter.mode(
    //                       Theme.of(context).colorScheme.onSecondaryContainer,
    //                       BlendMode.srcIn),
    //                   height: 28,
    //                   width: 28)
    //               .animate(target: isSelected ? 1 : 0)
    //               .swap(
    //                   duration: 50.ms,
    //                   builder: (_, __) => SvgPicture(
    //                       SvgAssetLoader(widget.selectedIconAssets ?? ""),
    //                       colorFilter: ColorFilter.mode(
    //                           Theme.of(context)
    //                               .colorScheme
    //                               .onSecondaryContainer,
    //                           BlendMode.srcIn),
    //                       height: 28,
    //                       width: 28)),
    //         ),
    //       ),
    //     ),
    //     // const SizedBox(height: 8),
    //     // Text(
    //     //   widget.text,
    //     //   style: Theme.of(context).textTheme.labelMedium,
    //     //   textAlign: TextAlign.center,
    //     // )
    //   ],
    // );
  }
}
