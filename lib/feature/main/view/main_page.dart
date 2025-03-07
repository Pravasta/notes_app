import 'package:flutter/material.dart';

import '../../home/view/home_page.dart';
import '../../settings/view/settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const RouteSettings routeSettings = RouteSettings(name: '/main');

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  List<Widget> pages = [HomePage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 35),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 35),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
