import 'package:flutter/material.dart';
import 'package:rokhshare/feature/login/presentation/widgets/login_text_field.dart';
import 'package:rokhshare/feature/signup/presentation/signup_page.dart';
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
                    Assets.images.loginLogoLight.image(width: 120, height: 120)
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
                          builder: (context) => SignupPage()));
                    },
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "حساب کاربری ندارید؟",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),
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
                    onPressed: () {},
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)))),
                    child: const Text("ورود"),
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
