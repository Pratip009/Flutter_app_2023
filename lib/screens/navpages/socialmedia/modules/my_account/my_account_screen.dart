// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_application_2023/provider/auth_provider.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout_controller.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/model/friend_request.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/model/post_model.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/model/user_model.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/addstory/add_story.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/comments_screen/comment_screen.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/edit_profile/edit_profile.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/my_account/friends_page.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/new_post/new_post_screen.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/notifications_settings/notification_settings.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/constants.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/styles/colors.dart';
import 'package:flutter_application_2023/widgets/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import '../../../../wallet-functions-payment-stuffs/transfer_money.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
//   @override
//   void initState() {
//     getUserFriendsList();
//     super.initState();
//   }

// getUserFriendsList()async{
//   FirebaseFirestore.instance.collection('users').where('')
// }

  final double coverAndProfileheight = 220;

  final double coverimageheight = 180;

  double profileheight = 60;

  List<String> firendsName = ['A', 'B'];

  final mypostsQuery = FirebaseFirestore.instance
      .collection('posts')
      .where('uId', isEqualTo: uId)
      .orderBy('postdate', descending: true)
      .withConverter<PostModel>(
        fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
        toFirestore: (post, _) => post.toJson(),
      );

  //static get uid => null;
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return GetBuilder<SocialLayoutController>(
        init: Get.find<SocialLayoutController>(),
        builder: (socialLayoutController) {
          var socialUserModel = socialLayoutController.socialUserModel!;
          // var profileimage = socialLayoutController.profileimage;
          // var coverimage = socialLayoutController.coverimage;
          return Scaffold(
            backgroundColor: Colors.grey.shade400,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 12.0, left: 12, right: 12),
                      child: Column(
                        children: [
                          //NOTE Cover And Profile ---------------------
                          SizedBox(
                            height: coverAndProfileheight,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                //NOTE : Cover Image
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Container(
                                      height: coverimageheight,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                                        image: DecorationImage(
                                          image: socialUserModel.coverimage ==
                                                      null ||
                                                  socialUserModel.coverimage ==
                                                      ""
                                              ? const AssetImage(
                                                      'assets/default_profile.png')
                                                  as ImageProvider
                                              : NetworkImage(
                                                  socialUserModel.coverimage!),
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                ),

                                //NOTE profileImage
                                CircleAvatar(
                                  radius: profileheight + 3,
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    radius: profileheight,
                                    backgroundImage: socialUserModel.image ==
                                                null ||
                                            socialUserModel.image == ""
                                        ? const AssetImage(
                                                'assets/default_profile.png')
                                            as ImageProvider
                                        : NetworkImage(socialUserModel.image!),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //NOTE Name
                          Text(
                            socialUserModel.name.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: 22),
                          ),
                          Text(
                            "ID:  ${ap.userModel.unique.toUpperCase()}",
                            style: GoogleFonts.lato(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: kblack,
                            ),
                          ),
                          // NOTE bio
                          Text(
                            socialUserModel.bio.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 15),
                          ),

                          // NOTE : Edit Profile Button
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: MaterialButton(
                                    height: 40,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    color: defaultColor.shade800,
                                    onPressed: () {
                                      Get.to(AddStoryScreen());
                                    },
                                    child: Container(
                                      // color: defaultColor,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                              radius: 9,
                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                Icons.add,
                                                size: 16,
                                                color: defaultColor.shade800,
                                              )),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Text(
                                            "Add to story",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: MaterialButton(
                                    height: 40,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    color: Colors.grey.shade300,
                                    onPressed: () {
                                      Get.to(EditProfile());
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.edit,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("Edit Profile"),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                MaterialButton(
                                  minWidth: 10,
                                  height: 40,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  color: Colors.grey.shade300,
                                  onPressed: () {
                                    Get.to(const NotificationSettingsScreen());
                                  },
                                  child: const Text("..."),
                                ),
                                // OutlinedButton(
                                //     onPressed: () {}, child: Icon(Icons.edit)),
                              ],
                            ),
                          ),

                          // Note About
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Divider(
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.grey.shade700,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Single",
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.more_horiz_outlined,
                                color: Colors.grey.shade700,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "See your About info",
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(height: 10),
                          // buildFirendsHedear(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Friends",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${socialUserModel.nbOffriends.toString()} friends",
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                    ),
                                  ]),
                              // const Text(
                              //   "Find Friends",
                              //   style: TextStyle(color: defaultColor),
                              // )
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Wrap(
                          //   spacing: 10,
                          //   children: [
                          //     ...firendsName.map((e) => buildFirendsHedear()),
                          //   ],
                          // ),
                          MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FriendsPage()));
                              },
                              minWidth: double.infinity,
                              color: Colors.grey.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text("See all friends")),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildWhatonYourMind(socialUserModel),
                  const SizedBox(
                    height: 10,
                  ),

                  //NOTE For Posts
                  FirestoreListView<PostModel>(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    pageSize: 5,
                    query: mypostsQuery,
                    loadingBuilder: (context) => const Center(
                      child: SingleChildScrollView(),
                    ),
                    errorBuilder: (context, error, stackTrace) =>
                        Text('Something went wrong! $error - $stackTrace'),
                    itemBuilder: (context, snapshot) {
                      PostModel model;
                      if (snapshot.isBlank!) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 200,
                                child: SvgPicture.asset(
                                    'assets/svg/no_posts_yet.svg')),
                            const Text(
                              "No Posts Yes",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 30),
                            ),
                          ],
                        );
                      } else {
                        model = snapshot.data();
                      }

                      return buildPostItem(
                          model, socialLayoutController, context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  // buildFriendItem(
  //   BuildContext context,
  //   String text,
  // ) {
  //   return SizedBox(
  //       width: MediaQuery.of(context).size.width * .28,
  //       height: 140,
  //       child: Column(
  //         children: [
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(8),
  //             child: SizedBox(
  //                 height: 100,
  //                 width: MediaQuery.of(context).size.width * .28,
  //                 child: Image.network(
  //                   '',
  //                   fit: BoxFit.fitWidth,
  //                 )),
  //           ),
  //           const SizedBox(
  //             height: 5,
  //           ),
  //           Text(
  //             text,
  //             style: const TextStyle(fontWeight: FontWeight.bold),
  //             maxLines: 2,
  //             overflow: TextOverflow.ellipsis,
  //           )
  //         ],
  //       ));
  // }

  final List<String> _streamItems = [
    'Live',
    'Photo',
    'Life event',
  ];

  final List<IconData> _streamIcons = [
    Icons.live_tv_sharp,
    Icons.filter,
    Icons.flag
  ];

  final List<Color> _streamIconColors = [
    Colors.pink.shade400,
    Colors.purple.shade400,
    defaultColor,
  ];

  _buildWhatonYourMind(UserModel? socialUserModel) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(children: [
              const Text(
                "Posts",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Spacer(),
              MaterialButton(
                minWidth: 6,
                height: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.grey.shade300,
                onPressed: () {
                  Get.to(const NotificationSettingsScreen());
                },
                child: const Icon(Icons.filter_list, size: 16),
              ),
              const SizedBox(
                width: 5,
              ),
              MaterialButton(
                minWidth: 6,
                height: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.grey.shade300,
                onPressed: () {
                  Get.to(const NotificationSettingsScreen());
                },
                child: const Icon(Icons.settings, size: 16),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Get.to(NewPostScreen());
              },
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: socialUserModel!.image == null ||
                                  socialUserModel.image == ""
                              ? const AssetImage('assets/default_profile.png')
                                  as ImageProvider
                              : NetworkImage(socialUserModel.image!),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                            child: Text(
                          "What's on your mind?",
                          style: TextStyle(fontSize: 20),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            const Divider(),
            _buildStreamsRow(),
          ],
        ),
      ),
    );
  }

  _buildStreamsRow() {
    return Container(
      child: Row(
        children: [
          ..._streamItems.map(
            (e) => Expanded(
                child: _buildStreamItem(
              e,
              _streamIcons[_streamItems.indexOf(e)],
              _streamIconColors[_streamItems.indexOf(e)],
            )),
          ),
        ],
      ),
    );
  }

  _buildStreamItem(String text, IconData icon, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
          size: 16,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        ),
      ],
    );
  }

  Widget buildPostItem(
    PostModel model,
    SocialLayoutController socialLayoutController,
    BuildContext context,
  ) {
    model.imageHeight = model.imageHeight != 0
        ? double.parse(model.imageHeight.toString()) - model.imageHeight! / 1.5
        : 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
          margin: EdgeInsets.zero,
          elevation: 5,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //NOTE : header of post (circle avatar and name and date of post)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: model.image == null || model.image == ""
                          ? const AssetImage('assets/default_profile.png')
                              as ImageProvider
                          : NetworkImage(model.image!),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${model.name}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 20),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            if (model.isEmailVerified == true)
                              const Icon(
                                Icons.check_circle,
                                color: defaultColor,
                                size: 16,
                              ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 2,
                              child: MaterialButton(
                                height: 40,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                color: kblacklight,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TransferMoney()));
                                },
                                child: Container(
                                  // color: defaultColor,

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                          radius: 9,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.monetization_on,
                                            size: 16,
                                            color: kblacklight,
                                          )),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Pay For Paid Ad.",
                                        style: TextStyle(color: knewwhite),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          convertToAgo(DateTime.parse(model.postdate!)),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(height: 1.4),
                        ),
                      ],
                    )),
                    // IconButton(
                    //     onPressed: () async {},
                    //     icon: const Icon(
                    //       Icons.more_horiz,
                    //     )),
                    //!paid ad
                  ],
                ),
              ),
              //NOTE: Divider()
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10.0),
              //   child: Container(
              //     width: double.infinity,
              //     height: 1,
              //     color: Colors.grey,
              //   ),
              // ),
              //NOTE: post body()
              if (model.text != "")
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: Text(
                    '${model.text}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),

              //NOTE : Image Of post
              if (model.postImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 13.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    //NOTE height - heigt /1.5 ==> about 40% from real height
                    height: model.imageHeight,

                    child: GestureDetector(
                      onDoubleTap: () {
                        // final double scale = 2;
                        // final zoomed = Matrix4.identity()..scale(scale);
                        // final value = zoomed;
                        // print("ok");
                      },
                      child: InteractiveViewer(
                          // transformationController: transformationController,
                          constrained: true,
                          //minScale: 1,
                          maxScale: 2.5,
                          child: Image.network(
                            model.postImage!,
                            fit: BoxFit.fitWidth,
                          )),
                    ),
                  ),
                ),
              //NOTE : Likes And Comments
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    if (model.nbOfLikes > 0)
                      Expanded(
                        child: InkWell(
                          child: Row(
                            children: [
                              const CircleAvatar(
                                  radius: 10,
                                  backgroundColor: defaultColor,
                                  child: FaIcon(
                                    FontAwesomeIcons.solidThumbsUp,
                                    color: Colors.white,
                                    size: 12,
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                model.nbOfLikes.toString(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          child: model.nbOfComments != 0
                              ? Text(
                                  "${model.nbOfComments} comments",
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              : Container(),
                          onTap: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //NOTE: Divider()
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: double.infinity,
                  height: 0.5,
                  color: Colors.grey,
                ),
              ),
              // NOTE like share comment
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LikeButton(
                      size: 51,
                      onTap: (isLiked) async {
                        if (model.likes!.any(
                          (element) => element == uId,
                        )) {
                          socialLayoutController.likePost(
                              model.postId.toString(),
                              isForremove: true);
                        } else {
                          socialLayoutController
                              .likePost(model.postId.toString());
                        }
                        return !isLiked;
                      },
                      circleColor: const CircleColor(
                          start: defaultColor, end: defaultColor),
                      bubblesColor: const BubblesColor(
                        dotPrimaryColor: defaultColor,
                        dotSecondaryColor: defaultColor,
                        // dotThirdColor: Color.fromARGB(220, 12, 199, 43),
                      ),
                      isLiked: model.likes!.isNotEmpty &&
                              model.likes!.contains(uId.toString())
                          ? true
                          : false,
                      likeBuilder: (bool isLiked) {
                        return Row(
                          children: [
                            FaIcon(FontAwesomeIcons.solidThumbsUp,
                                size: 18,
                                color: isLiked ? defaultColor : Colors.grey),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Like",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color:
                                          isLiked ? defaultColor : Colors.grey),
                            ),
                          ],
                        );
                      },
                    ),
                    InkWell(
                      onTap: () {
                        print("pressed");
                        Get.to(CommentsScreen(
                            model.postId,
                            socialLayoutController.socialUserModel?.name
                                .toString(),
                            socialLayoutController.socialUserModel?.image,
                            model.nbOfLikes));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.message,
                              color: Colors.grey,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Comments",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.share,
                              color: Colors.grey,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Share",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //NOTE: Divider()
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: double.infinity,
                  height: 0.5,
                  color: Colors.grey,
                ),
              ),

              //NOTE : Write a Comment  and like post
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage: socialLayoutController
                                              .socialUserModel!.image ==
                                          null ||
                                      socialLayoutController
                                              .socialUserModel!.image ==
                                          ""
                                  ? const AssetImage(
                                          'assets/default_profile.png')
                                      as ImageProvider
                                  : NetworkImage(
                                      '${socialLayoutController.socialUserModel!.image}'),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text("Write a Comment",
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

// buildFirendsHedear() {
//   return const Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Text(
//           "Friends",
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         Text(
//           "2 friends",
//           style: TextStyle(color: Colors.grey, fontSize: 15),
//         ),
//       ]),
//       Text(
//         "Find Friends",
//         style: TextStyle(color: defaultColor),
//       )
//     ],
//   );
// }
