import 'package:flutter/material.dart';
import 'package:rokhshare/gen/assets.gen.dart';

class MainBottomNavigationBar extends StatefulWidget {
  final PageController _controller;

  const MainBottomNavigationBar({super.key, required PageController controller})
      : _controller = controller;

  @override
  State<MainBottomNavigationBar> createState() =>
      _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  int _currentPageIndex = 0;

  PageController get _controller => widget._controller;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          _currentPageIndex = index;
          _controller.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        });
      },
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
      selectedIndex: _currentPageIndex,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      destinations: <Widget>[
        NavigationDestination(
          selectedIcon: Assets.icons.videoFrameSharp.svg(
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSecondaryContainer,
                  BlendMode.srcIn)),
          icon: Assets.icons.videoFrameOutline.svg(
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
          label: 'خانه',
        ),
        NavigationDestination(
          selectedIcon: Assets.icons.roundedMagniferSharp.svg(
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSecondaryContainer,
                  BlendMode.srcIn)),
          icon: Assets.icons.roundedMagniferOutline.svg(
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
          label: 'جستجو',
        ),
        NavigationDestination(
          selectedIcon: Assets.icons.categorySharp.svg(
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSecondaryContainer,
                  BlendMode.srcIn)),
          icon: Assets.icons.categoryOutline.svg(
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
          label: 'دسته بندی',
        ),
        NavigationDestination(
          selectedIcon: Assets.icons.userSharp.svg(
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSecondaryContainer,
                  BlendMode.srcIn)),
          icon: Assets.icons.userOutline.svg(
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
          label: 'حساب من',

        ),
      ],
    );
  }
}
