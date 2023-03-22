import 'package:flutter/material.dart';

import '../../../colors.dart';

class OTPScreen extends StatefulWidget {
  static const String routeName = "/otp-screen";
  final String verificationId;
  OTPScreen({super.key, required this.verificationId});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifying your number'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
