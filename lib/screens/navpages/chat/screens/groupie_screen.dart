import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/chat/api/apis.dart';
import 'package:flutter_application_2023/screens/navpages/chat/groupchat/pages/home_page.dart';
import 'package:flutter_application_2023/screens/navpages/chat/groupchat/pages/login_page.dart';

class GroupieScreen extends StatefulWidget {
  const GroupieScreen({super.key});

  @override
  State<GroupieScreen> createState() => _GroupieScreenState();
}

class _GroupieScreenState extends State<GroupieScreen> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await APIs.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isSignedIn ? const HomePage() : const LoginPage();
  }
}
