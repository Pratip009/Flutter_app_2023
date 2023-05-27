// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout_controller.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/model/friend_request.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/notifications_screen/notification_controller.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/constants.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/styles/colors.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';



class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  var friendrequestsQuery = FirebaseFirestore.instance
      .collection('users')
      .doc(uId)
      .collection('receivedfriendrequest')
      .orderBy('requestDate', descending: true)
      .withConverter<FriendRequest>(
        fromFirestore: (snapshot, _) =>
            FriendRequest.fromJson(snapshot.data()!),
        toFirestore: (request, _) => request.toJson(),
      );

  var controller = Get.put(NotificationController());
  var socialLayoutController_needed = Get.find<SocialLayoutController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              height: MediaQuery.of(context).size.height * 0.4,
              child: FirestoreListView<FriendRequest>(
                  // reverse: true,
                  //    physics: NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  pageSize: 5,
                  query: friendrequestsQuery,
                  // loadingBuilder: (context) => Center(
                  //       child: CircularProgressIndicator(),
                  //     ),
                  errorBuilder: (context, error, stackTrace) =>
                      Text('Something went wrong! $error - $stackTrace'),
                  itemBuilder: (context, snapshot) {
                    FriendRequest model;
                    int count_ofreceivedRequest = 0;

                    if (snapshot.isBlank!) {
                      print('snapshot blank');

                      print(snapshot.data().name);
                      return Container();
                    } else {
                      model = snapshot.data();
                      count_ofreceivedRequest++;
                      print('snapshot data');
                    }

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              const Text(
                                "Friend requests",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '$count_ofreceivedRequest',
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              const Spacer(),
                              const Text(
                                "See all",
                                style: TextStyle(color: defaultColor),
                              ),
                            ],
                          ),
                        ),
                        _buildRequestItem(model, context, controller),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  _buildRequestItem(FriendRequest model, BuildContext context,
      NotificationController controller) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .15,
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: model.image == null || model.image == ""
                  ? const AssetImage('assets/default_profile.png') as ImageProvider
                  : NetworkImage(model.image!),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.name.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      convertToAgo(model.requestDate!.toDate()),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: MaterialButton(
                        height: 40,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: defaultColor.shade800,
                        onPressed: () {
                          controller
                              .confirmRequest(
                                  myId: uId.toString(),
                                  user_requestId: model.requestId.toString())
                              .then((value) {
                            //after confirmed wait then get logged in user to show my new friends
                            Future.delayed(const Duration(seconds: 2)).then((value) {
                              socialLayoutController_needed
                                  .getLoggedInUserData();
                            });
                          });
                        },
                        child: const Text(
                          "confirm",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: MaterialButton(
                        height: 40,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: Colors.grey.shade300,
                        onPressed: () {
                          controller.deleteRequest(
                              myId: uId.toString(),
                              user_requestId: model.requestId.toString());
                        },
                        child: const Text("Delete"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}