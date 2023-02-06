// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/onboard_screen.dart';
import 'package:flutter_application_2023/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 4500), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const OnBoardScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Icon(
                Icons.android_outlined,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Icon(
                Icons.apple_outlined,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Icon(
                Icons.integration_instructions_outlined,
                size: 100,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
