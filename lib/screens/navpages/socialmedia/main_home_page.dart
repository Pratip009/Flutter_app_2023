import 'package:flutter/material.dart';

import 'package:flutter_application_2023/screens/navpages/socialmedia/screens/signup_screen.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return const SignupScreen();
  }
}
