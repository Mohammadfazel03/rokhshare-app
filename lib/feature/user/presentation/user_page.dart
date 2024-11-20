import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/config/theme/theme_cubit.dart';
import 'package:rokhshare/gen/assets.gen.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200),
                child: Assets.images.loginTv.image(width: width / 24 * 11)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton(
                onPressed: () {}, child: const Text("ورود و ثبت‌نام")),
          ),
          Builder(
            builder: (context) {
              var state =
                  BlocProvider.of<ThemeCubit>(context, listen: true).state;
              return SwitchListTile(
                secondary: Transform.flip(
                  flipX: true,
                  child: Assets.icons.moonBold.svg(
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).iconTheme.color ??
                              Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn)),
                ),
                value: state == ThemeMode.dark,
                onChanged: (value) {
                  BlocProvider.of<ThemeCubit>(context).changeTheme(
                      state != ThemeMode.dark
                          ? ThemeMode.dark
                          : ThemeMode.light);
                },
                title: const Text("زمینه تیره"),
                shape: Border.symmetric(
                    horizontal: BorderSide(
                        width: 0.5,
                        color: Theme.of(context).colorScheme.outlineVariant)),
              );
            },
          ),
          ListTile(
            onTap: () {},
            leading: Assets.icons.questionCircleBold.svg(
                colorFilter: ColorFilter.mode(
                    Theme.of(context).iconTheme.color ??
                        Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn)),
            title: const Text("سوالات متداول"),
            shape: Border.symmetric(
                horizontal: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.outlineVariant)),
          ),
          ListTile(
            onTap: () {},
            leading: Assets.icons.infoCircleBold.svg(
                colorFilter: ColorFilter.mode(
                    Theme.of(context).iconTheme.color ??
                        Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn)),
            title: const Text("درباره ما"),
            shape: Border.symmetric(
                horizontal: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.outlineVariant)),
          ),
          ListTile(
            onTap: () {},
            leading: Transform.flip(
              flipX: true,
              child: Assets.icons.phoneRoundedBold.svg(
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).iconTheme.color ??
                          Theme.of(context).colorScheme.onSurface,
                      BlendMode.srcIn)),
            ),
            title: const Text("تماس با ما"),
            shape: Border.symmetric(
                horizontal: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.outlineVariant)),
          ),
        ],
      ),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
