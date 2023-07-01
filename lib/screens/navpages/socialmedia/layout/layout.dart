// // ignore_for_file: avoid_print, non_constant_identifier_names

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
// import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout_controller.dart';
// import 'package:flutter_application_2023/screens/navpages/socialmedia/model/friend_request.dart';
// import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/notifications_screen/notification_controller.dart';
// import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/notifications_screen/notificationsscreen.dart';
// import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/search_all_friend/search_all.dart';
// import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/constants.dart';
// import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/styles/colors.dart';
// import 'package:flutter_application_2023/widgets/constant.dart';
// import 'package:get/get.dart';

// class SocialLayout extends StatefulWidget {
//   const SocialLayout({super.key});

//   @override
//   State<SocialLayout> createState() => _SocialLayoutState();
// }

// class _SocialLayoutState extends State<SocialLayout> {
//   var friendrequestsQuery = FirebaseFirestore.instance
//       .collection('users')
//       .doc(uId)
//       .collection('receivedfriendrequest')
//       .orderBy('requestDate', descending: true)
//       .withConverter<FriendRequest>(
//         fromFirestore: (snapshot, _) =>
//             FriendRequest.fromJson(snapshot.data()!),
//         toFirestore: (request, _) => request.toJson(),
//       );
//   var controller = Get.put(NotificationController());
//   var socialLayoutController_needed = Get.find<SocialLayoutController>();
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SocialLayoutController>(
//         init: SocialLayoutController(),
//         builder: (socialLayoutController) {
//           return Scaffold(
//             appBar: AppBar(
//               toolbarHeight: 60,
//               backgroundColor: kblacklight2,
//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     socialLayoutController
//                         .appbar_title[socialLayoutController.currentIndex],
//                     style: socialLayoutController.currentIndex == 0
//                         ? TextStyle(color: knewwhite)
//                         : TextStyle(color: knewwhite),
//                   ),
//                   // Text(
//                   //   ap.userModel.unique.toUpperCase(),
//                   //   style: GoogleFonts.lato(
//                   //     fontSize: 15,
//                   //     fontWeight: FontWeight.w600,
//                   //     color: kblacklight,
//                   //   ),
//                   // ),
//                 ],
//               ),
//               actions: [
//                 IconButton(
//                     color: knewwhite,
//                     onPressed: () {
//                       Get.to(SearchAll());
//                     },
//                     icon: const Icon(Icons.search_rounded)),
//                 Badge(
//                   offset: const Offset(7, 10),
//                   alignment: Alignment.topCenter,
//                   label: const Text('0'),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: IconButton(
//                         color: knewwhite,
//                         onPressed: () {
//                           Get.to(const NotificationsScreen());
//                         },
//                         icon: const Icon(Icons.notifications)),
//                   ),
//                 ),
//               ],
//             ),
//             body: socialLayoutController.isGetNeededData!
//                 ? socialLayoutController
//                     .screens[socialLayoutController.currentIndex]
//                 : const Center(child: CircularProgressIndicator()),
//             bottomNavigationBar: BottomNavigationBar(
//               elevation: 30,
//               type: BottomNavigationBarType.fixed,
//               selectedItemColor: defaultColor,
//               onTap: (index) {
//                 print(index);
//                 //NOTE : if index equal 2 open NewPostScreen without change index

//                 socialLayoutController.onchangeIndex(index);
//               },
//               currentIndex: socialLayoutController.currentIndex,
//               items: socialLayoutController.bottomItems,
//             ),
//           );
//         });
//   }
// }
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout_controller.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/notifications_screen/notificationsscreen.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/search_all_friend/search_all.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/styles/colors.dart';
import 'package:flutter_application_2023/widgets/constant.dart';
import 'package:get/get.dart';

class SocialLayout extends StatefulWidget {
  const SocialLayout({super.key});

  @override
  State<SocialLayout> createState() => _SocialLayoutState();
}

class _SocialLayoutState extends State<SocialLayout> {
  @override
  Widget build(BuildContext context) {
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
                    color: knewwhite,
                    onPressed: () {
                      Get.to(SearchAll());
                    },
                    icon: const Icon(Icons.search_rounded)),
                Badge(
                  offset: const Offset(7, 10),
                  alignment: Alignment.topCenter,
                  label: const Text('0'),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        color: knewwhite,
                        onPressed: () {
                          Get.to(const NotificationsScreen());
                        },
                        icon: const Icon(Icons.notifications)),
                  ),
                ),
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
