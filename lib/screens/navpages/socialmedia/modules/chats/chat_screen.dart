// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout_controller.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/search_friend/search_friend.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/components/componets.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/styles/colors.dart';
import 'package:flutter_application_2023/widgets/constant.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialLayoutController>(
      init: Get.find<SocialLayoutController>(),
      builder: (socialLayoutController) => Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 25),
          child: socialLayoutController.myFriends.isNotEmpty
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildChatItem(
                      context: context,
                      userModel: socialLayoutController.myFriends[index],
                      isForChatScreen: true),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: socialLayoutController.myFriends.length)
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 20),
                        children: [
                          TextSpan(
                              text:
                                  'To Start messaging contact who have social app, tap ',
                              style: TextStyle(color: kblack)),
                          const WidgetSpan(
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: 1.0, left: 2, right: 2),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: defaultColor,
                                child: Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                          ),
                          const TextSpan(text: ' bottom to start chat'),
                        ],
                      ),
                    ),
                    // child: Text(
                    //   'To Start messaging contact who have social app, tap the bottom to start chat',
                    //   style: TextStyle(color: Colors.grey, fontSize: 25),
                    //   textAlign: TextAlign
                    //       .center, // NOTE to center all paragraph in center
                    // ),
                  ),
                ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => SearchFriendScreen());
            },
            child: const Icon(
              Icons.add,
            )),
      ),
    );
  }
}
