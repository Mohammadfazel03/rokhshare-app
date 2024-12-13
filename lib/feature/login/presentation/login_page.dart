import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rokhshare/config/dependency_injection.dart';
import 'package:rokhshare/feature/login/presentation/bloc/login_cubit.dart';
import 'package:rokhshare/feature/login/presentation/widgets/login_text_field.dart';
import 'package:rokhshare/feature/signup/presentation/bloc/signup_cubit.dart';
import 'package:rokhshare/feature/signup/presentation/signup_page.dart';
import 'package:rokhshare/feature/user/presentation/bloc/auth_cubit.dart';
import 'package:rokhshare/gen/assets.gen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) async {
      if (state is LoginSuccessfully) {
        await BlocProvider.of<AuthCubit>(context).login(
            state.loginResponse.access!,
            state.loginResponse.refresh!,
            state.loginResponse.isPremium!,
            state.loginResponse.days,
            state.loginResponse.email!,
            state.loginResponse.username!);
        Navigator.of(context).pop();
      } else if (state is LoginFailed) {
        final snackBar = SnackBar(
          dismissDirection: DismissDirection.horizontal,
          behavior: SnackBarBehavior.floating,
          content: Text(state.error,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onInverseSurface)),
          backgroundColor: Theme.of(context).colorScheme.inverseSurface,
          duration: const Duration(seconds: 10),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }, builder: (context, state) {
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
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: height / 4),
                    if (Theme.of(context).brightness == Brightness.dark) ...[
                      Assets.images.loginLogoDark.image(width: 120, height: 120)
                    ] else ...[
                      Assets.images.loginLogoLight
                          .image(width: 120, height: 120)
                    ],
                    const SizedBox(height: 12),
                    Text(
                      "مرجع دانلود به روزترین\nفیلم ها و سریال ها",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    LoginTextField(
                      readOnly: state is LoginLoading,
                      controller: emailController,
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
                      readOnly: state is LoginLoading,
                      obscureText: true,
                      obscuringCharacter: '*',
                      controller: passwordController,
                      label: "رمز عبور",
                      leadingIcon: Assets.icons.lockKeyholeBold.svg(
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.onSurfaceVariant,
                              BlendMode.srcIn)),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) =>
                                MultiBlocProvider(providers: [
                                  BlocProvider.value(
                                      value: BlocProvider.of<AuthCubit>(
                                          context)),
                                  BlocProvider(
                                    create: (context) => SignupCubit(
                                        signupRepository: getIt.get()))
                                ], child:  const SignupPage())));
                      },
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "حساب کاربری ندارید؟",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface)),
                        TextSpan(
                            text: " ایجاد حساب کاربری +",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                      ])),
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: () {
                        if (state is! LoginLoading) {
                          BlocProvider.of<LoginCubit>(context).login(
                              emailController.text, passwordController.text);
                        }
                      },
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)))),
                      child: state is LoginLoading
                          ? SpinKitRing(
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 20,
                              lineWidth: 5,
                              duration: const Duration(milliseconds: 500),
                            )
                          : const Text("ورود"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
