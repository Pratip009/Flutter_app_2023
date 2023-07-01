// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:flutter_application_2023/provider/auth_provider.dart';
import 'package:flutter_application_2023/provider/face_provider.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/model/message_model.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/model/user_model.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/chat_details/chat_details_screen.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/styles/thems.dart';
import 'package:get/get.dart';
import 'package:flutter_application_2023/screens/splash_screen.dart';
import 'package:flutter_application_2023/widgets/constant.dart';
import 'package:provider/provider.dart';
import 'screens/navpages/socialmedia/layout/layout_controller.dart';
import 'screens/navpages/socialmedia/shared/network/local/cashhelper.dart';
import 'screens/navpages/socialmedia/shared/network/remote/diohelper.dart';

List<CameraDescription> cameras = [];
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message');
  print(" message data background ${message.data}");

  //showToast(message: "on background message", status: ToastStatus.Success);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp(
    name: 'flutter_application_2023',
    options: const FirebaseOptions(
        apiKey: "AIzaSyABci8JgVHaVRkt_FMmhhkGMbPk1okSio4",
        projectId: "myapp--backend",
        messagingSenderId: "168217810649",
        storageBucket: "myapp--backend.appspot.com",
        appId: "1:168217810649:web:0eb898ae6a6a2c593950c8"),
  );
  await DioHelper.init();
  FirebaseMessaging.onMessage.listen((message) {
    print("message data ${message.data}");
    SocialLayoutController controller = Get.find<SocialLayoutController>();
    controller.getMyFriend();
    // showToast(message: "on message", status: ToastStatus.Success);
  });
  // NOTE : catch notification  with parameter while app is closed and when on press notification
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print("message data opened ${message.data['messageModel']}");
    SocialLayoutController controller = Get.find<SocialLayoutController>();

    MessageModel messageModel =
        MessageModel.fromJson(json.decode(message.data['messageModel']));

    UserModel userModel = controller.myFriends
        .where((element) => element.uId == messageModel.senderId)
        .single;

    Get.to(() => ChatDetailsScreen(socialUserModel: userModel));
  });

// NOTE : catch notification  with parameter while app is in background
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await CashHelper.Init();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        ChangeNotifierProvider(create: (_) => FaceProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        themeMode: ThemeMode.light,
        home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("error");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return SplashScreen();
            }
            return CircularProgressIndicator(
              color: kyellow,
            );
          },
        ),
      ),
    );
  }
}
