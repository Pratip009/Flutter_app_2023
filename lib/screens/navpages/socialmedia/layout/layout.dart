// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout_controller.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/styles/colors.dart';
import 'package:flutter_application_2023/widgets/constant.dart';
import 'package:get/get.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialLayoutController>(
        init: SocialLayoutController(),
        builder: (socialLayoutController) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 60,
              backgroundColor: kblacklight2,
              title: Text(
                socialLayoutController
                    .appbar_title[socialLayoutController.currentIndex],
                style: socialLayoutController.currentIndex == 0
                    ? TextStyle(color: knewwhite)
                    : TextStyle(color: knewwhite),
              ),
              actions: [
                IconButton(
                    color: knewwhite,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                    )),
                IconButton(
                    color: knewwhite,
                    onPressed: () {},
                    icon: const Icon(Icons.notifications))
              ],
            ),
            body: socialLayoutController.isGetNeededData!
                ? socialLayoutController
                    .screens[socialLayoutController.currentIndex]
                : const Center(child: CircularProgressIndicator()),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 30,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: defaultColor,
              onTap: (index) {
                print(index);
                //NOTE : if index equal 2 open NewPostScreen without change index

                socialLayoutController.onchangeIndex(index);
              },
              currentIndex: socialLayoutController.currentIndex,
              items: socialLayoutController.bottomItems,
            ),
          );
        });
  }
}
