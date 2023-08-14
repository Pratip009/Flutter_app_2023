import 'package:flutter/material.dart';

final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();
final TextEditingController onemessagecontroller = TextEditingController();
final TextEditingController groubmessagecontroller = TextEditingController();

Color scafold_background = const Color(0xffc8d7d7);
Color mygreen = const Color(0xff03001C);
Color lightgreen = const Color(0xff6D9886);
Color unchosencolor = const Color(0xff1cfca6);
Color chosencolor = const Color(0xff129664);
SizedBox smallvertical_space = const SizedBox(
  height: 5,
);
SizedBox vertical_space = const SizedBox(
  height: 10,
);
SizedBox horizontal_space = const SizedBox(
  width: 10,
);
SizedBox smallhorizontal_space = const SizedBox(
  width: 5,
);
ButtonStyle elevatedstyle =
    ButtonStyle(backgroundColor: MaterialStateProperty.all(mygreen));
TextStyle greenstyle = TextStyle(
  color: mygreen,
  fontSize: 25,
  fontWeight: FontWeight.bold,
  fontFamily: "IndieFlower",
);
TextStyle smallgreenstyle = TextStyle(
  color: mygreen,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);
TextStyle normalgreenstyle = TextStyle(
  color: mygreen,
  fontSize: 21,
  fontWeight: FontWeight.bold,
);
TextStyle bigwhite = const TextStyle(
    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23);
TextStyle normalwhite = const TextStyle(
    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18);
