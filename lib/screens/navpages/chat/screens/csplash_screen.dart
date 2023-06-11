import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2023/screens/navpages/chat/screens/settings_screen.dart';
import '../../../../utils/dimensions.dart';
import '../api/apis.dart';
import 'auth/login_screen.dart';

//splash screen
class CsplashScreen extends StatefulWidget {
  const CsplashScreen({super.key});

  @override
  State<CsplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<CsplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      //exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white));

      if (APIs.auth.currentUser != null) {
        log('\nUser: ${APIs.auth.currentUser}');
        //navigate to home screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
            
      } else {
        //navigate to login screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
  

    return Scaffold(
      //body
      body: Stack(children: [
        //app logo
        Positioned(
            top: Dimensions.screenHeight * .15,
            right: Dimensions.screenWidth * .25,
            width: Dimensions.screenWidth * .5,
            child: Image.asset('assets/images/chat.png')),

        //google login button
        Positioned(
            bottom: Dimensions.screenHeight * .15,
            width: Dimensions.screenWidth,
            child: const Text('MADE IN INDIA WITH ❤️',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, color: Colors.black87, letterSpacing: .5))),
      ]),
    );
  }
}
