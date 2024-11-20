import 'package:flutter/material.dart';
import 'package:rokhshare/gen/assets.gen.dart';
import 'package:rokhshare/utils/error_entity.dart';

class CustomErrorWidget extends StatelessWidget {
  final ErrorEntity error;
  final bool showIcon;
  final bool showTitle;
  final bool showMessage;
  final bool showButton;
  final Widget? icon;
  final Widget? retryButton;
  final Function() onRetry;

  const CustomErrorWidget(
      {super.key,
      required this.error,
      required this.onRetry,
      this.showIcon = false,
      this.showTitle = false,
      this.showMessage = true,
      this.showButton = true,
      this.icon,
      this.retryButton});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showIcon) ...[
              if (icon != null) ...[
                icon!,
                const SizedBox(height: 8)
              ] else ...[
                Assets.icons.wifiLowBound.svg(
                    width: 128,
                    height: 128,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: 8)
              ]
            ],
            if (showTitle && error.title != null) ...[
              Text(error.title!),
              const SizedBox(height: 4),
            ],
            if (showMessage) ...[
              Text(error.error),
            ],
            if (showButton) ...[
              if (retryButton != null) ...[
                retryButton!
              ] else ...[
                TextButton.icon(
                    onPressed: onRetry,
                    label: const Text("تلاش دوباره"),
                    icon: const Icon(Icons.refresh))
              ]
            ]
          ],
        ),
      ),
    );
  }
}
