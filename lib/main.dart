// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2023/provider/auth_provider.dart';
import 'package:flutter_application_2023/provider/face_provider.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/providers/user_provider.dart';
import 'package:flutter_application_2023/screens/splash_screen.dart';
import 'package:flutter_application_2023/screens/user_information_screen.dart';
import 'package:flutter_application_2023/widgets/constant.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

List<CameraDescription> cameras = [];
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
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => FaceProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
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
