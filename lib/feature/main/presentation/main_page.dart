import 'package:flutter/material.dart';
import 'package:rokhshare/feature/category/presentation/category_page.dart';
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
    return Scaffold(
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
    );
  }
}
