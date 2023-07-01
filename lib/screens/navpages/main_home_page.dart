// ignore_for_file: avoid_print

import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/social_login/login.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/constants.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/network/local/cashhelper.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget widget;

    uId = CashHelper.getData(key: "uId");
    print("UId :$uId");

    if (uId != null) {
      widget = const SocialLayout();
    } else {
      widget = const LoginScreen();
    }
    return Scaffold(
      body: widget,
    );
  }
}
