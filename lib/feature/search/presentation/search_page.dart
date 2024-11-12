import 'package:flutter/material.dart';
import 'package:rokhshare/feature/search/presentation/widgets/search_field_widget.dart';
import 'package:rokhshare/gen/assets.gen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: SizedBox(
                  height: 48,
                  child: SearchFieldWidget(),
                )),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)))),
                    onPressed: () {},
                    padding: const EdgeInsets.all(12),
                    icon: Assets.icons.filterBold.svg(
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.onSurfaceVariant,
                            BlendMode.srcIn))),
              ],
            ),
          )
        ],
      )),
    );
  }
}
