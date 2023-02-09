// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/main_home_page.dart';
import 'package:flutter_application_2023/screens/navpages/my_screen.dart';
import 'package:flutter_application_2023/screens/navpages/search_screen.dart';
import 'package:flutter_application_2023/screens/navpages/settings_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../widgets/constant.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List pages = [
    MainHomePage(),
    SettingsScreen(),
    SearchScreen(),
    MyScreen(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            gap: 8,
            onTabChange: onTap,
            backgroundColor: Colors.transparent,
            color: kblack,
            activeColor: kblack,
            tabBackgroundColor: kyellow,
            padding: EdgeInsets.all(8),
            tabs: [
              GButton(
                icon: Icons.apps,
                text: 'Home',
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
              GButton(
                icon: Icons.account_circle_rounded,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
