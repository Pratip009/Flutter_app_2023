// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_2023/provider/auth_provider.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout_controller.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/styles/colors.dart';
import 'package:flutter_application_2023/widgets/constant.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return GetBuilder<SocialLayoutController>(
        init: SocialLayoutController(),
        builder: (socialLayoutController) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 60,
              backgroundColor: kblacklight2,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    socialLayoutController
                        .appbar_title[socialLayoutController.currentIndex],
                    style: socialLayoutController.currentIndex == 0
                        ? TextStyle(color: knewwhite)
                        : TextStyle(color: knewwhite),
                  ),
                  // Text(
                  //   ap.userModel.unique.toUpperCase(),
                  //   style: GoogleFonts.lato(
                  //     fontSize: 15,
                  //     fontWeight: FontWeight.w600,
                  //     color: kblacklight,
                  //   ),
                  // ),
                ],
              ),
              actions: [
                IconButton(
                    color: kblacklight,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                    )),
                IconButton(
                    color: kblacklight,
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
