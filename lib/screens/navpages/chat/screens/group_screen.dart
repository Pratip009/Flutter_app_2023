import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/chat/screens/groupie_screen.dart';
import 'package:flutter_application_2023/screens/navpages/chat/screens/settings_screen.dart';

import '../../../../utils/dimensions.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _HomePageState();
}

class _HomePageState extends State<GroupScreen> {
  int currentTab = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const GroupieScreen(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currenScreen = const HomeScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: currenScreen,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: Dimensions.height10,
          child: SizedBox(
            height: Dimensions.height70,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MaterialButton(
                          minWidth: Dimensions.width10 * 4,
                          onPressed: () {
                            setState(() {
                              currenScreen = const HomeScreen();
                              currentTab = 0;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.chat_bubble,
                                color: currentTab == 0
                                    ? const Color(0xFF0158BE)
                                    : const Color(0xFFCCCCCC),
                              ),
                              Text(
                                'Single Chat',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: currentTab == 0
                                      ? const Color(0xFF0158BE)
                                      : const Color(0xFFCCCCCC),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      color: Colors.black12,
                      thickness: 1,
                    ),
                    Row(
                      children: [
                        MaterialButton(
                          minWidth: Dimensions.width10 * 4,
                          onPressed: () {
                            setState(() {
                              currenScreen = const GroupieScreen();
                              currentTab = 1;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.group_sharp,
                                color: currentTab == 1
                                    ? const Color(0xFF0158BE)
                                    : const Color(0xFFCCCCCC),
                              ),
                              Text(
                                'Group Chat',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: currentTab == 1
                                      ? const Color(0xFF0158BE)
                                      : const Color(0xFFCCCCCC),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
