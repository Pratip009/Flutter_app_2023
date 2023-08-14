// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:flutter_application_2023/widgets/constant.dart';

import 'colors.dart';

// ThemeData darkThem() => ThemeData(
//       scaffoldBackgroundColor: HexColor('#525252'),
//       primarySwatch: defaultColor,
//       appBarTheme: AppBarTheme(
//           iconTheme: IconThemeData(color: kblue),
//           backgroundColor: HexColor('#525252'),
//           elevation: 0,
//           actionsIconTheme: IconThemeData(color: kblue),
//           backwardsCompatibility: false,
//           titleTextStyle: TextStyle(
//               color: kblack, fontWeight: FontWeight.bold, fontSize: 25),
//           systemOverlayStyle: SystemUiOverlayStyle(
//             statusBarColor: HexColor('#525252'),
//             statusBarIconBrightness: Brightness.light,
//           )),
//       floatingActionButtonTheme:
//           FloatingActionButtonThemeData(backgroundColor: defaultColor),
//       bottomNavigationBarTheme: BottomNavigationBarThemeData(
//           backgroundColor: HexColor('#525252'),
//           unselectedItemColor: Colors.grey),

//       //NOTE : set default bodytext1
//       textTheme: TextTheme(
//         bodyText1: TextStyle(
//             color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//         subtitle1: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         bodyText2: TextStyle(
//           color: Colors.white,
//         ),
//       ),
//     );

ThemeData lightTheme() => ThemeData(
      primarySwatch: defaultColor,
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: knewwhite),
          backgroundColor: kblue,
          elevation: 0,
          actionsIconTheme: IconThemeData(color: knewwhite),
          // backwardsCompatibility: false,
          titleTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          )),
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: defaultColor),

      //NOTE : set default bodytext1
      textTheme: const TextTheme(
        bodyText1: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        bodyText2: TextStyle(
          color: Colors.black,
        ),
        subtitle1: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
