import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokhshare/config/dependency_injection.dart';
import 'package:rokhshare/feature/category/presentation/bloc/category_cubit.dart';
import 'package:rokhshare/feature/category/presentation/category_page.dart';
import 'package:rokhshare/feature/home/presentation/bloc/home_cubit.dart';
import 'package:rokhshare/feature/home/presentation/home_page.dart';
import 'package:rokhshare/feature/main/presentation/widgets/main_bottom_navigation_bar.dart';
import 'package:rokhshare/feature/search/presentation/search_page.dart';
import 'package:rokhshare/feature/user/presentation/user_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit(repository: getIt.get())),
          BlocProvider(
              create: (context) => CategoryCubit(repository: getIt.get()))
        ],
        child: Scaffold(
          bottomNavigationBar: MainBottomNavigationBar(controller: _controller),
          body: PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              HomePage(),
              SearchPage(),
              CategoryPage(),
              UserPage()
            ],
          ),
        ));
  }
}
