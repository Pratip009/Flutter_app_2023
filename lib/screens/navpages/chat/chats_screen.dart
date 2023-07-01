import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2023/firebase_options.dart';
import 'package:flutter_application_2023/screens/navpages/chat/screens/splash_screen.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';

import 'package:firebase_core/firebase_core.dart';

//global object for accessing device screen size
late Size mq;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //enter full-screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  //for setting orientation to portrait only
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    _initializeFirebase();
    runApp(const ChatsScreen());
  });
}

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreen(),
    );
    // MaterialApp(
    //     title: 'We Chat',
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData(
    //         appBarTheme: const AppBarTheme(
    //       centerTitle: true,
    //       elevation: 1,
    //       iconTheme: IconThemeData(color: Colors.black),
    //       titleTextStyle: TextStyle(
    //           color: Colors.black, fontWeight: FontWeight.normal, fontSize: 19),
    //       backgroundColor: Colors.white,
    //     )),
    //     home: const SplashScreen());
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var result = await FlutterNotificationChannel.registerNotificationChannel(
      description: 'For Showing Message Notification',
      id: 'chats',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'Chats');
  log('\nNotification Channel Result: $result');
}
