import 'package:flutter/material.dart';
import 'package:rokhshare/feature/login/presentation/login_page.dart';
import 'package:rokhshare/feature/login/presentation/widgets/login_text_field.dart';
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: height/6),
                  if (Theme.of(context).brightness == Brightness.dark) ...[
                    Assets.images.loginLogoDark.image(width: 120, height: 120)
                  ] else ...[
                    Assets.images.loginLogoLight.image(width: 120, height: 120)
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
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "حساب کاربری دارید؟",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),
                      TextSpan(
                          text: " ورود",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary)),
                    ])),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)))),
                    child: const Text("ثبت نام"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
