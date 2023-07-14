// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout_controller.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/model/user_model.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/components/componets.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';

import '../../shared/constants.dart';

class SearchFriendScreen extends StatelessWidget {
  var queryController = TextEditingController();
  //final usersQuery = FirebaseFirestore.instance.collection('users').orderBy('name');

  final usersQuery = FirebaseFirestore.instance
      .collection('users')
      .doc('uId')
      .collection('friends')
      .where('uId', isNotEqualTo: uId)
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );
  SearchFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel socialUserModel;

    return GetBuilder<SocialLayoutController>(
      init: Get.find<SocialLayoutController>(),
      builder: (socialLayoutController) => Scaffold(
        appBar: AppBar(
          title: defaultTextFormFieldForSocial(
              controller: queryController,
              onchange: (query) {
                print(query);
                socialLayoutController.searchForUser(query!);
              },
              inputtype: TextInputType.name,
              border: InputBorder.none,
              hinttext: "Search for a friend ... "),
        ),
        body: Container(
            margin: const EdgeInsets.only(top: 30),
            child: socialLayoutController.userfiltered == null
                ? FirestoreListView<UserModel>(
                    query: usersQuery,
                    itemBuilder: (context, snapshot) {
                      UserModel userModel = snapshot.data();

                      return buildChatItem(
                          context: context, userModel: userModel);
                    },
                  )
                : socialLayoutController.userfiltered!.isNotEmpty
                    ? ListView.separated(
                        itemBuilder: (context, index) {
                          return buildChatItem(
                              context: context,
                              userModel:
                                  socialLayoutController.userfiltered![index]);
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: socialLayoutController.userfiltered!.length)
                    : SizedBox(
                        width: double.infinity,
                        child: Text(
                          'No result for "${queryController.text}"',
                          textAlign: TextAlign.center,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      )),
      ),
    );
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class SearchFriendScreen extends StatefulWidget {
//   const SearchFriendScreen({super.key});

//   @override
//   State<SearchFriendScreen> createState() => _SearchFriendState();
// }

// class _SearchFriendState extends State<SearchFriendScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: FirebaseFirestore.instance.collection('users').doc('uId').get(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (!snapshot.hasData &&
//               snapshot.connectionState == ConnectionState.done) {
//             var data = snapshot.data.data();
//             var friends = data['friends'];

//             return ListView.builder(
//               shrinkWrap: true,
//               itemCount: friends.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Text(friends[index].toString());
//               },
//             );
//           } else {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20),
//               child: Column(
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(Icons.arrow_back)),
//                   const Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       'No friends exists!',
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
