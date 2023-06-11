// import 'package:flutter/material.dart';
// import 'package:flutter_application_2023/screens/navpages/chat/api/apis.dart';
// import 'package:flutter_application_2023/screens/navpages/chat/groupchat/pages/home_page.dart';
// import 'package:flutter_application_2023/screens/navpages/chat/groupchat/pages/login_page.dart';

// class GroupieScreen extends StatefulWidget {
//   const GroupieScreen({super.key});

//   @override
//   State<GroupieScreen> createState() => _GroupieScreenState();
// }

// class _GroupieScreenState extends State<GroupieScreen> {
//   bool _isSignedIn = false;

//   @override
//   void initState() {
//     super.initState();
//     getUserLoggedInStatus();
//   }

//   getUserLoggedInStatus() async {
//     await APIs.getUserLoggedInStatus().then((value) {
//       if (value != null) {
//         setState(() {
//           _isSignedIn = value;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _isSignedIn ? const HomePage() : const LoginPage();
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_2023/screens/navpages/chat/api/apis.dart';
import 'package:flutter_application_2023/screens/navpages/chat/groupchat/pages/home_page.dart';
import 'package:flutter_application_2023/screens/navpages/chat/groupchat/pages/login_page.dart';
import 'package:flutter_application_2023/widgets/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp();
  }

  runApp(const GroupieScreen());
}

class GroupieScreen extends StatefulWidget {
  const GroupieScreen({Key? key}) : super(key: key);

  @override
  State<GroupieScreen> createState() => _MyAppState();
}

class _MyAppState extends State<GroupieScreen> {
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
    return MaterialApp(
      theme: ThemeData(
          primaryColor: kblack, scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: _isSignedIn ? const HomePage() : const LoginPage(),
      //_isSignedIn ? const HomePage() :
    );
  }
}
