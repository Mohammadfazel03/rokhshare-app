import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/feature/user/presentation/bloc/auth_cubit.dart';
import 'package:rokhshare/gen/assets.gen.dart';

import '../../../config/dependency_injection.dart';
import '../../login/presentation/bloc/login_cubit.dart';
import '../../login/presentation/login_page.dart';

class ConfirmEmailPage extends StatelessWidget {
  final String email;

  const ConfirmEmailPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .sizeOf(context)
        .width;
    return Scaffold(
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "لینک فعالسازی برای $email ارسال شد.",
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Assets.images.confirmEmailBox.image(
                  width: width / 2, height: width / 2),
              const SizedBox(height: 12),
              Text(
                "لطفاً جهت تأیید ایمیل خود، به صندوق ورودی (Inbox) مراجعه کرده و روی لینک ارسال‌شده کلیک کنید.",
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) =>
                          MultiBlocProvider(
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
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)))),
                child: const Text("بازگشت"),
              )
            ]
        ),
      )),
    );
  }
}
