

import 'package:flutter_application_2023/screens/navpages/audiovideo/constants/app_constants.dart';

import '../screens/auth_screen.dart';
import 'package:flutter/material.dart';

import '../../constants/global_constants.dart';
import 'animated_route.dart';
import 'texts.dart';

Widget LoginButton(BuildContext context) {
  Size size = MediaQuery.sizeOf(context);
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
          createRoute(AuthScreen()));
    },
    child: Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
      height: size.height * .05,
      width: size.width * .6,
      decoration: BoxDecoration(
          color: lightgreen, borderRadius: BorderRadius.circular(10)),
      child: Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(AppConstants.chat_icon,height: 20,width: 20,fit: BoxFit.fill,),
          smallhorizontal_space,
          signwitheasytext(context),
        ],
      )),
    ),
  );
}
