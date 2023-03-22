import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/chat_app/features/auth/chat_login_screen.dart';
import 'package:flutter_application_2023/screens/chat_app/features/auth/screens/otp_screen.dart';
import 'package:flutter_application_2023/widgets/error.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ChatLoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const ChatLoginScreen(),
      );
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(
          verificationId: verificationId,
        ),
      );
    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: ErrorScreen(error: 'This page doesn\'t exist'),
              ));
  }
}
