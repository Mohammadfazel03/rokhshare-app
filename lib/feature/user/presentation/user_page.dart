import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/config/dependency_injection.dart';
import 'package:rokhshare/config/theme/theme_cubit.dart';
import 'package:rokhshare/feature/login/presentation/bloc/login_cubit.dart';
import 'package:rokhshare/feature/login/presentation/login_page.dart';
import 'package:rokhshare/feature/user/presentation/bloc/auth_cubit.dart';
import 'package:rokhshare/feature/user/presentation/bloc/auth_state.dart';
import 'package:rokhshare/gen/assets.gen.dart';
import 'package:shimmer/shimmer.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
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
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state.isLogin == false) {
                return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 200),
                            child: Assets.images.loginTv
                                .image(width: width / 24 * 11)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: FilledButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                              create: (context) => LoginCubit(
                                                  loginRepository:
                                                      getIt.get())),
                                          BlocProvider.value(
                                              value: BlocProvider.of<AuthCubit>(
                                                  context))
                                        ],
                                        child: const LoginPage(),
                                      )));
                            },
                            child: const Text("ورود و ثبت‌نام")),
                      ),
                    ]);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state.isLogin == true) {
                return ListTile(
                  onTap: () {},
                  leading: Assets.icons.userCircleBold.svg(
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).iconTheme.color ??
                              Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn)),
                  title: state.status == AuthStatus.loading
                      ? Shimmer.fromColors(
                          baseColor:
                              Theme.of(context).colorScheme.surfaceContainer,
                          highlightColor:
                              Theme.of(context).colorScheme.surfaceContainerLow,
                          child: Container(color: Colors.red, child: const Text("بدون اشتراک")))
                      : Text(state.username ?? "",
                          style: Theme.of(context).textTheme.labelLarge),
                  shape: Border.symmetric(
                      horizontal: BorderSide(
                          width: 0.5,
                          color: Theme.of(context).colorScheme.outlineVariant)),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state.isLogin == true) {
                return ListTile(
                  onTap: () {},
                  leading: Assets.icons.ticketStarBold.svg(
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).iconTheme.color ??
                              Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn)),
                  title: Text("وضعیت اشتراک",
                      style: Theme.of(context).textTheme.labelLarge),
                  trailing: state.status == AuthStatus.loading
                      ? Shimmer.fromColors(
                          baseColor:
                              Theme.of(context).colorScheme.surfaceContainer,
                          highlightColor:
                              Theme.of(context).colorScheme.surfaceContainerLow,
                          child: Container(padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(4)), child: const Text("بدون اشتراک")))
                      : Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: state.isPremium == true
                                  ? Colors.green[100]?.withOpacity(0.9)
                                  : Colors.red[100]?.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            state.error != null
                                ? 'خطا در دریافت'
                                : state.days != null
                                    ? "${state.days} روز"
                                    : 'بدون اشتراک',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    color: state.isPremium == true
                                        ? Colors.green[700]
                                        : Colors.red[700]),
                          ),
                        ),
                  shape: Border.symmetric(
                      horizontal: BorderSide(
                          width: 0.5,
                          color: Theme.of(context).colorScheme.outlineVariant)),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state.isLogin == true) {
                return ListTile(
                  onTap: () {},
                  leading: Assets.icons.billListBold.svg(
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).iconTheme.color ??
                              Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn)),
                  title: Text("پرداخت ها",
                      style: Theme.of(context).textTheme.labelLarge),
                  shape: Border.symmetric(
                      horizontal: BorderSide(
                          width: 0.5,
                          color: Theme.of(context).colorScheme.outlineVariant)),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state.isLogin == true) {
                return ListTile(
                  onTap: () {},
                  leading: Assets.icons.bellBold.svg(
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).iconTheme.color ??
                              Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn)),
                  title: Text("اعلان ها",
                      style: Theme.of(context).textTheme.labelLarge),
                  shape: Border.symmetric(
                      horizontal: BorderSide(
                          width: 0.5,
                          color: Theme.of(context).colorScheme.outlineVariant)),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
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
                title: Text("زمینه تیره",
                    style: Theme.of(context).textTheme.labelLarge),
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
            title: Text("سوالات متداول",
                style: Theme.of(context).textTheme.labelLarge),
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
            title: Text("درباره ما",
                style: Theme.of(context).textTheme.labelLarge),
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
            title: Text("تماس با ما",
                style: Theme.of(context).textTheme.labelLarge),
            shape: Border.symmetric(
                horizontal: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).colorScheme.outlineVariant)),
          ),
          BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
            if (state.isLogin == true) {
              return ListTile(
                onTap: () {
                  BlocProvider.of<AuthCubit>(context).logout();
                },
                leading: Transform.flip(
                  child: Assets.icons.logoutBold.svg(
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).iconTheme.color ??
                              Theme.of(context).colorScheme.onSurface,
                          BlendMode.srcIn)),
                ),
                title:
                    Text("خروج", style: Theme.of(context).textTheme.labelLarge),
                shape: Border.symmetric(
                    horizontal: BorderSide(
                        width: 0.5,
                        color: Theme.of(context).colorScheme.outlineVariant)),
              );
            } else {
              return const SizedBox.shrink();
            }
          })
        ],
      ),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
