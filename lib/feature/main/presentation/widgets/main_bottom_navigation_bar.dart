import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  int _currentPageIndex = 1;

  // int _currentPageIndex = 0;

  PageController get _controller => widget._controller;

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.sizeOf(context).width - 112;
    return BottomAppBar(
      color: Colors.transparent,
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  if (_currentPageIndex != 1) {
                    setState(() {
                      _currentPageIndex = 1;
                      _controller.animateToPage(0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear);
                    });
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.icons.videoFrameOutline
                        .svg(
                            colorFilter: ColorFilter.mode(
                                Theme.of(context).unselectedWidgetColor,
                                BlendMode.srcIn))
                        .animate(target: _currentPageIndex == 1 ? 1 : 0)
                        .swap(
                            duration: 50.ms,
                            builder: (_, __) => Assets.icons.videoFrameSharp
                                .svg(
                                    colorFilter: ColorFilter.mode(
                                        Theme.of(context).colorScheme.onSurface,
                                        BlendMode.srcIn)))
                        .scale(
                            duration: 200.ms,
                            end: const Offset(1, 1),
                            begin: const Offset(0.9, 0.9))
                        .move(
                            duration: 200.ms,
                            end: const Offset(0, 0),
                            begin: const Offset(0, 8)),
                    Text("خانه", style: Theme.of(context).textTheme.labelMedium)
                        .animate(target: _currentPageIndex == 1 ? 1 : 0)
                        .fadeIn(begin: 0, duration: 200.ms)
                        .move(begin: const Offset(0, 8), end: const Offset(0, 0))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: VerticalDivider(
                  thickness: 1,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest),
            ),
            Expanded(
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  if (_currentPageIndex != 2) {
                    setState(() {
                      _currentPageIndex = 2;
                      _controller.animateToPage(1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear);
                    });
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.icons.roundedMagniferOutline
                        .svg(
                            colorFilter: ColorFilter.mode(
                                Theme.of(context).unselectedWidgetColor,
                                BlendMode.srcIn))
                        .animate(target: _currentPageIndex == 2 ? 1 : 0)
                        .swap(
                            duration: 50.ms,
                            builder: (_, __) =>
                                Assets.icons.roundedMagniferSharp.svg(
                                    colorFilter: ColorFilter.mode(
                                        Theme.of(context).colorScheme.onSurface,
                                        BlendMode.srcIn)))
                        .scale(
                            duration: 200.ms,
                            end: const Offset(1, 1),
                            begin: const Offset(0.9, 0.9))
                        .move(
                            duration: 200.ms,
                            end: const Offset(0, 0),
                            begin: const Offset(0, 8)),
                    Text("جستجو",
                            style: Theme.of(context).textTheme.labelMedium)
                        .animate(target: _currentPageIndex == 2 ? 1 : 0)
                        .fadeIn(begin: 0, duration: 200.ms)
                        .move(begin: const Offset(0, 8), end: const Offset(0, 0))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: VerticalDivider(
                  thickness: 1,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest),
            ),
            Expanded(
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  if (_currentPageIndex != 3) {
                    setState(() {
                      _currentPageIndex = 3;
                      _controller.animateToPage(2,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear);
                    });
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.icons.categoryOutline
                        .svg(
                            colorFilter: ColorFilter.mode(
                                Theme.of(context).unselectedWidgetColor,
                                BlendMode.srcIn))
                        .animate(target: _currentPageIndex == 3 ? 1 : 0)
                        .swap(
                            duration: 50.ms,
                            builder: (_, __) => Assets.icons.categorySharp.svg(
                                colorFilter: ColorFilter.mode(
                                    Theme.of(context).colorScheme.onSurface,
                                    BlendMode.srcIn)))
                        .scale(
                            duration: 200.ms,
                            end: const Offset(1, 1),
                            begin: const Offset(0.9, 0.9))
                        .move(
                            duration: 200.ms,
                            end: const Offset(0, 0),
                            begin: const Offset(0, 8)),
                    Text("دسته‌بندی",
                            style: Theme.of(context).textTheme.labelMedium)
                        .animate(target: _currentPageIndex == 3 ? 1 : 0)
                        .fadeIn(begin: 0, duration: 200.ms)
                        .move(begin: const Offset(0, 8), end: const Offset(0, 0))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: VerticalDivider(
                  thickness: 1,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest),
            ),
            Expanded(
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  if (_currentPageIndex != 4) {
                    setState(() {
                      _currentPageIndex = 4;
                      _controller.animateToPage(3,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear);
                    });
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.icons.userOutline
                        .svg(
                            colorFilter: ColorFilter.mode(
                                Theme.of(context).unselectedWidgetColor,
                                BlendMode.srcIn))
                        .animate(target: _currentPageIndex == 4 ? 1 : 0)
                        .swap(
                            duration: 50.ms,
                            builder: (_, __) => Assets.icons.userSharp.svg(
                                colorFilter: ColorFilter.mode(
                                    Theme.of(context).colorScheme.onSurface,
                                    BlendMode.srcIn)))
                        .scale(
                            duration: 200.ms,
                            end: const Offset(1, 1),
                            begin: const Offset(0.9, 0.9))
                        .move(
                            duration: 200.ms,
                            end: const Offset(0, 0),
                            begin: const Offset(0, 8)),
                    Text("حساب من",
                            style: Theme.of(context).textTheme.labelMedium)
                        .animate(target: _currentPageIndex == 4 ? 1 : 0)
                        .fadeIn(begin: 0, duration: 200.ms)
                        .move(begin: const Offset(0, 8), end: const Offset(0, 0))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    // return Padding(
    //   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.circular(8),
    //     child: BottomNavigationBar(
    //       type: BottomNavigationBarType.shifting,
    //       backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
    //       currentIndex: _currentPageIndex,
    //       elevation: 32,
    //       showUnselectedLabels: false,
    //       selectedFontSize: 12,
    //       fixedColor: Theme.of(context).colorScheme.onSurface,
    //       onTap: (int index) {
    //         setState(() {
    //           _currentPageIndex = index;
    //           _controller.animateToPage(index,
    //               duration: const Duration(milliseconds: 300),
    //               curve: Curves.linear);
    //         });
    //       },
    //       items: <BottomNavigationBarItem>[
    //         BottomNavigationBarItem(
    //           backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
    //           activeIcon: Assets.icons.videoFrameSharp.svg(
    //               colorFilter: ColorFilter.mode(
    //                   Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
    //           icon: Assets.icons.videoFrameOutline.svg(
    //               colorFilter: ColorFilter.mode(
    //                   Theme.of(context).unselectedWidgetColor, BlendMode.srcIn)),
    //           label: 'خانه',
    //         ),
    //         BottomNavigationBarItem(
    //           backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
    //           activeIcon: Assets.icons.roundedMagniferSharp.svg(
    //               colorFilter: ColorFilter.mode(
    //                   Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
    //           icon: Assets.icons.roundedMagniferOutline.svg(
    //               colorFilter: ColorFilter.mode(
    //                   Theme.of(context).unselectedWidgetColor, BlendMode.srcIn)),
    //           label: 'جستجو',
    //         ),
    //         BottomNavigationBarItem(
    //           backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
    //           activeIcon: Assets.icons.categorySharp.svg(
    //               colorFilter: ColorFilter.mode(
    //                   Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
    //           icon: Assets.icons.categoryOutline.svg(
    //               colorFilter: ColorFilter.mode(
    //                   Theme.of(context).unselectedWidgetColor, BlendMode.srcIn)),
    //           label: 'دسته‌بندی',
    //         ),
    //         BottomNavigationBarItem(
    //           backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
    //           activeIcon: Assets.icons.userSharp.svg(
    //               colorFilter: ColorFilter.mode(
    //                   Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
    //           icon: Assets.icons.userOutline.svg(
    //               colorFilter: ColorFilter.mode(
    //                   Theme.of(context).unselectedWidgetColor, BlendMode.srcIn)),
    //           label: 'حساب من',
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
