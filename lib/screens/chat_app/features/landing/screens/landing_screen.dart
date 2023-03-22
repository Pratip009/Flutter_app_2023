import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/chat_app/colors.dart';
import 'package:flutter_application_2023/utils/dimensions.dart';
import 'package:flutter_application_2023/widgets/constant.dart';

import '../../../../../widgets/chat_custom_button.dart';
import '../../auth/chat_login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, ChatLoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: Dimensions.height25 * 2,
              ),
              Text(
                "Welcome To Chat-App",
                style: TextStyle(
                  fontSize: 33,
                  color: kwhite,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Image.asset(
                'assets/images/logo.png',
                height: 340,
                width: 340,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Read Our Privacy policy.Tap"Agree and Continue" to Accept the terms of Services. ',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Dimensions.screenHeight / 9,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ChatCustomButton(
                  onPressed: () => navigateToLoginScreen(context),
                  text: 'AGREE AND CONTINUE',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
