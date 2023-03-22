import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/chat_app/colors.dart';

import 'package:flutter_application_2023/widgets/constant.dart';

class ChatCustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const ChatCustomButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: tabColor,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: kblack,
        ),
      ),
    );
  }
}
