import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rokhshare/config/dependency_injection.dart';
import 'package:rokhshare/config/theme/theme_cubit.dart';

import 'config/theme/themes.dart';
import 'feature/main/presentation/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(localStorageService: getIt.get()),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
              title: 'Rokhshare',
              darkTheme: Themes.dark,
              theme: Themes.light,
              themeMode: state,
              locale: const Locale("fa", "IR"),
              localizationsDelegates: const [
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [Locale("fa", "IR")],
              home: const MainPage());
        },
      ),
    );
  }
}
