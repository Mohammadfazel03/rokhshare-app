import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rokhshare/config/dependency_injection.dart';
import 'package:rokhshare/feature/confirm_email/presentation/confirm_email_page.dart';
import 'package:rokhshare/feature/login/presentation/bloc/login_cubit.dart';
import 'package:rokhshare/feature/login/presentation/login_page.dart';
import 'package:rokhshare/feature/login/presentation/widgets/login_text_field.dart';
import 'package:rokhshare/feature/signup/presentation/bloc/signup_cubit.dart';
import 'package:rokhshare/feature/user/presentation/bloc/auth_cubit.dart';
import 'package:rokhshare/gen/assets.gen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late final TextEditingController usernameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Stack(
      children: [
        Positioned.fill(
            child: Theme.of(context).brightness == Brightness.dark
                ? Assets.images.loginFrameDark.image(fit: BoxFit.fill)
                : Assets.images.loginFrameLight.image(fit: BoxFit.fill)),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SingleChildScrollView(
              child: BlocConsumer<SignupCubit, SignupState>(
                listener: (context, state) {
                  if (state is SignupSuccessfully) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                              value: BlocProvider.of<AuthCubit>(context),
                              child:
                                  ConfirmEmailPage(email: emailController.text),
                            )));
                  } else if (state is SignupFailed) {
                    BlocProvider.of<SignupCubit>(context).init();
                    final snackBar = SnackBar(
                      dismissDirection: DismissDirection.horizontal,
                      behavior: SnackBarBehavior.floating,
                      content: Text(state.error,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onInverseSurface)),
                      backgroundColor:
                          Theme.of(context).colorScheme.inverseSurface,
                      duration: const Duration(seconds: 10),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: height / 6),
                      if (Theme.of(context).brightness == Brightness.dark) ...[
                        Assets.images.loginLogoDark
                            .image(width: 120, height: 120)
                      ] else ...[
                        Assets.images.loginLogoLight
                            .image(width: 120, height: 120)
                      ],
                      const SizedBox(height: 12),
                      Text(
                        "جهــت ثبـت نـام اطـلاعات خودتــان را وارد کنـید",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      LoginTextField(
                        readOnly: state is SignupLoading,
                        controller: usernameController,
                        label: 'نام کاربری',
                        leadingIcon: Assets.icons.userSharp.svg(
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.onSurfaceVariant,
                                BlendMode.srcIn)),
                      ),
                      const SizedBox(height: 12),
                      LoginTextField(
                        readOnly: state is SignupLoading,
                        controller: emailController,
                        label: 'ایمیل',
                        leadingIcon: Assets.icons.letterBold.svg(
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.onSurfaceVariant,
                                BlendMode.srcIn)),
                      ),
                      const SizedBox(height: 12),
                      LoginTextField(
                        readOnly: state is SignupLoading,
                        obscureText: true,
                        obscuringCharacter: '*',
                        controller: passwordController,
                        label: 'رمز عبور',
                        leadingIcon: Assets.icons.lockKeyholeBold.svg(
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.onSurfaceVariant,
                                BlendMode.srcIn)),
                      ),
                      const SizedBox(height: 12),
                      LoginTextField(
                        readOnly: state is SignupLoading,
                        obscureText: true,
                        obscuringCharacter: '*',
                        controller: confirmPasswordController,
                        label: "تایید رمز عبور",
                        leadingIcon: Assets.icons.lockKeyholeBold.svg(
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.onSurfaceVariant,
                                BlendMode.srcIn)),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: state is SignupLoading
                            ? null
                            : () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (_) => MultiBlocProvider(
                                              providers: [
                                                BlocProvider(
                                                    create: (context) =>
                                                        LoginCubit(
                                                            loginRepository:
                                                                getIt.get())),
                                                BlocProvider.value(
                                                    value: BlocProvider.of<
                                                        AuthCubit>(context))
                                              ],
                                              child: const LoginPage(),
                                            )));
                              },
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "حساب کاربری دارید؟",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface)),
                          TextSpan(
                              text: " ورود",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                        ])),
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: () {
                          if (state is! SignupLoading) {
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              final snackBar = SnackBar(
                                dismissDirection: DismissDirection.horizontal,
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                    "رمز عبور با تایید آن مطابقت ندارد.",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onInverseSurface)),
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .inverseSurface,
                                duration: const Duration(seconds: 10),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              BlocProvider.of<SignupCubit>(context).register(
                                  usernameController.text,
                                  emailController.text,
                                  passwordController.text);
                            }
                          }
                        },
                        style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)))),
                        child: state is SignupLoading
                            ? SpinKitRing(
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 20,
                                lineWidth: 5,
                                duration: const Duration(milliseconds: 500),
                              )
                            : const Text("ثبت نام"),
                      ),
                      const SizedBox(height: 24)
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
