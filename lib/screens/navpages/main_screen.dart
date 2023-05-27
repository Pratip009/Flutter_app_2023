// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/chat/screens/group_screen.dart';
import 'package:flutter_application_2023/screens/navpages/main_home_page.dart';

import 'package:flutter_application_2023/screens/navpages/my_screen.dart';
import 'package:flutter_application_2023/screens/navpages/search_screen.dart';
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
    GroupScreen(),
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
        color: Color(0xFF1A1A40),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            gap: 8,
            onTabChange: onTap,
            backgroundColor: Colors.transparent,
            color: kyellow,
            activeColor: kblack,
            tabBackgroundColor: kyellow,
            padding: EdgeInsets.all(8),
            tabs: [
              GButton(
                icon: Icons.wallet,
                text: 'Home',
              ),
              GButton(
                icon: Icons.chat_outlined,
                text: 'Chat',
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
