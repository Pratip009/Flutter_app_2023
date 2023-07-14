import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/group/pages/home_page.dart';
import 'package:flutter_application_2023/screens/navpages/group/pages/login_page.dart';
import 'package:flutter_application_2023/screens/navpages/group/theme/theme.dart';

import 'helper/helper_function.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // run initialization for web
    await Firebase.initializeApp();
  } else {
    // run initialization for android and ios
    await Firebase.initializeApp();
  }

  runApp(const GroupChat());
}

class GroupChat extends StatefulWidget {
  const GroupChat({super.key});

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.appTheme(context),
        darkTheme: MyTheme.appTheme(context),
        home: (_isSignedIn) ? HomePage() : LoginPage());
  }
}
