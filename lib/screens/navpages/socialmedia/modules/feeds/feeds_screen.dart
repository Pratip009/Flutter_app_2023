import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout_controller.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/model/post_model.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/model/storymodel.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/model/user_model.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/addstory/add_story.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/comments_screen/comment_screen.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/friend_profile/friend_profile_screen.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/new_post/new_post_screen.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/social_login/login.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/stories_view/stories_view.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/components/componets.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/constants.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/styles/colors.dart';
import 'package:flutter_application_2023/widgets/constant.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';

import 'package:like_button/like_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

// ignore: must_be_immutable

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  // ! screenshot
  final controller = ScreenshotController();
  final postsQuery = FirebaseFirestore.instance
      .collection('posts')
      .orderBy('postdate', descending: true)
      .withConverter<PostModel>(
        fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
        toFirestore: (post, _) => post.toJson(),
      );

  //! final storiesQuery = FirebaseFirestore.instance
  late SocialLayoutController controller_NeededInBuildPost;

  bool test = false;

  @override
  Widget build(BuildContext context) {
    controller_NeededInBuildPost = Get.find<SocialLayoutController>();
    return GetBuilder<SocialLayoutController>(
        init: Get.find<SocialLayoutController>(),
        builder: (socialLayoutController) {
          return Scaffold(
            backgroundColor: kblacklight2,
            // socialLayoutController.isloadingGetStories
            //     ? Center(child: CircularProgressIndicator())
            //     :
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NOTE what's on your mind
                  _buildWhatonYourMind(socialLayoutController.socialUserModel),

                  //NOTE for Story
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      color: kblacklight2,
                      padding: const EdgeInsets.all(15),
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          buildStoryItem(context: context, isForMe: true),
                          const SizedBox(
                            width: 10,
                          ),
                          socialLayoutController.storiesMap.isNotEmpty
                              ? Row(
                                  children: [
                                    socialLayoutController.storiesMap[
                                                    uId.toString()] !=
                                                null &&
                                            socialLayoutController
                                                .storiesMap[uId.toString()]!
                                                .isNotEmpty
                                        ? buildStoryItem(
                                            context: context,
                                            isForMe: true,
                                            isHasStories: true,
                                            story: StoryModel.formJson(
                                                socialLayoutController
                                                    .storiesMap[uId.toString()]!
                                                    .last))
                                        : const SizedBox(
                                            width: 0,
                                          ),
                                    if (socialLayoutController
                                        .storiesMap.isNotEmpty)
                                      for (var e in socialLayoutController
                                          .storiesMap.entries)
                                        if (e.value.last['storyUserId'] != uId)
                                          buildStoryItem(
                                              context: context,
                                              isForMe: false,
                                              isHasStories: true,
                                              story: StoryModel.formJson(
                                                  e.value.last)),
                                  ],
                                )
                              : _noStoriesWidget(context),
                        ],
                      )
                      // : FirestoreListView<StoryModel>(
                      //     scrollDirection: Axis.horizontal,
                      //     pageSize: 8,
                      //     query: storiesQuery,
                      //     loadingBuilder: (context) => Center(
                      //       child: SingleChildScrollView(),
                      //     ),
                      //     errorBuilder: (context, error, stackTrace) => Text(
                      //         'Something went wrong! ${error} - ${stackTrace}'),
                      //     itemBuilder: (context, snapshot) {
                      //       StoryModel model = snapshot.data();

                      //       return buildStoryItem(
                      //         context: context,
                      //         story: model,
                      //       );
                      //     },
                      //   ),
                      ),
                  const SizedBox(
                    height: 10,
                  ),
                  //NOTE Old get posts from controller
                  // ListView.separated(
                  //   itemBuilder: (context, index) {
                  //     return buildPostItem(
                  //         socialLayoutController
                  //             .listOfPost[index],
                  //         context,
                  //         index);
                  //   },
                  //   itemCount:
                  //       socialLayoutController.listOfPost.length,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   separatorBuilder: (context, int index) =>
                  //       SizedBox(
                  //     height: 10,
                  //   ),
                  // ),
                  //NOTE For Posts
                  FirestoreListView<PostModel>(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    pageSize: 8,
                    query: postsQuery,
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

                      return buildPostItem(model,
                          socialLayoutController.socialUserModel!, context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget buildStoryItem({
    required BuildContext context,
    required bool isForMe,
    isHasStories = false,
    StoryModel? story,
  }) {
    return isForMe
        // if current logged does not have stories
        ? !isHasStories
            ? Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  border: Border.all(color: kgrey),
                  borderRadius: BorderRadius.circular(30),
                ),
                height: 220,
                child: Column(
                  children: [
                    SizedBox(
                      height: 142,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          //NOTE : Cover Image
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                                height: 160,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: (controller_NeededInBuildPost
                                                    .socialUserModel !=
                                                null &&
                                            (controller_NeededInBuildPost
                                                        .socialUserModel!
                                                        .image ==
                                                    null ||
                                                controller_NeededInBuildPost
                                                        .socialUserModel!
                                                        .image ==
                                                    ""))
                                        ? const AssetImage('assets/story.png')
                                            as ImageProvider
                                        : NetworkImage(
                                            controller_NeededInBuildPost
                                                .socialUserModel!.image
                                                .toString()),
                                    // : NetworkImage(socialUserModel.coverimage!),
                                    fit: BoxFit.fill,
                                  ),
                                )),
                          ),

                          //NOTE profileImage

                          CircleAvatar(
                            radius: 17,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 15,
                              child: InkWell(
                                onTap: () {
                                  // controller_NeededInBuildPost.AddStory(
                                  //     controller_NeededInBuildPost
                                  //         .socialUserModel!.uId
                                  //         .toString());
                                  Get.to(() => AddStoryScreen());
                                },
                                child: Icon(
                                  Icons.add,
                                  color: kwhite,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Create story',
                      style: TextStyle(
                          color: klight, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            //NOTE if current user  has stories
            : InkWell(
                onTap: () {
                  Get.to(() => StoryViewScreen(story.storyUserId.toString()));
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 220,
                  child: SizedBox(
                    height: 175,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            //NOTE : Cover Image
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Container(
                                  decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(story!.image.toString()),
                                  // : NetworkImage(socialUserModel.coverimage!),
                                  fit: BoxFit.cover,
                                ),
                              )),
                            ),

                            //NOTE profileImage

                            const Padding(
                              padding: EdgeInsetsDirectional.only(
                                  bottom: 10, end: 15),
                              child: Text(
                                'Your Story',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // NOTE circle avatar inside story
                        ...profileStory(story)
                      ],
                    ),
                  ),
                ),
              )
        : InkWell(
            onTap: () {
              Get.to(() => StoryViewScreen(story.storyUserId.toString()));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 220,
              child: SizedBox(
                height: 175,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        //NOTE : Cover Image
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                              decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(story!.image.toString()),
                              // : NetworkImage(socialUserModel.coverimage!),
                              fit: BoxFit.cover,
                            ),
                          )),
                        ),

                        //NOTE profileImage

                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              bottom: 10, end: 15),
                          child: Text(
                            story.storyName.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // NOTE circle avatar inside story // this is list of circle avatar in a stack
                    ...profileStory(story)
                  ],
                ),
              ),
            ),
          );
  }

  Widget buildPostItem(
    PostModel model,
    UserModel userModel,
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
                    GestureDetector(
                      onTap: () {
                        if (model.uId != uId) {
                          Get.to(FriendProfileScreen(model.uId.toString()));
                        } else {
                          controller_NeededInBuildPost.onchangeIndex(3);
                        }
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            model.image == null || model.image == ""
                                ? const AssetImage('assets/default_profile.png')
                                    as ImageProvider
                                : NetworkImage(model.image!),
                      ),
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
                              )
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
                    //     onPressed: () async {
                    //       //!delete post
                    //     },
                    //     icon: Icon(
                    //       Icons.more_vert,
                    //       color: kblacklight,
                    //     )),
                    IconButton(
                        onPressed: () async {
                          // ! here is the code to download file from firebase
                          // final image = await controller.capture();
                          // if (image == null) return;
                          // await saveImage(image);
                        },
                        icon: Icon(
                          Icons.download,
                          color: kblacklight,
                        )),
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

              //!NOTE : Image Of post
              if (model.postImage != null)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    //NOTE height - heigt /1.5 ==> about 40% from real height
                    height: model.imageHeight,

                    child: InkWell(
                      onTap: () async {},
                      child: FullScreenWidget(
                        disposeLevel: DisposeLevel.Medium,
                        child: Image.network(
                          model.postImage!,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
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
                              CircleAvatar(
                                  radius: 10,
                                  backgroundColor: kblacklight,
                                  child: const FaIcon(
                                    FontAwesomeIcons.solidThumbsUp,
                                    color: Colors.white,
                                    size: 12,
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                model.nbOfLikes.toString(),
                                style: TextStyle(
                                  color: kblacklight,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    Expanded(
                      child: InkWell(
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 10,
                                backgroundColor: kblacklight,
                                child: const FaIcon(
                                  FontAwesomeIcons.eye,
                                  color: Colors.white,
                                  size: 12,
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            // ! counter
                            ValueListenableBuilder(
                              valueListenable: counter,
                              builder: (context, value, child) {
                                return Text(
                                  counter.value.toString(),
                                  style: TextStyle(
                                    color: kblacklight,
                                    fontSize: 12,
                                  ),
                                );
                              },
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
                                  style: TextStyle(
                                    color: kblacklight,
                                    fontSize: 12,
                                  ),
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
                          controller_NeededInBuildPost.likePost(
                              model.postId.toString(),
                              isForremove: true);
                        } else {
                          controller_NeededInBuildPost
                              .likePost(model.postId.toString());
                        }
                        return !isLiked;
                      },
                      circleColor:
                          CircleColor(start: kblacklight, end: kblacklight),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: kblacklight,
                        dotSecondaryColor: kblue,
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
                                color: isLiked ? kblacklight : Colors.grey),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Like",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: isLiked ? kblacklight : kgrey),
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
                            controller_NeededInBuildPost.socialUserModel?.name
                                .toString(),
                            controller_NeededInBuildPost.socialUserModel?.image,
                            model.nbOfLikes));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.message,
                              color: kgrey,
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
                                  ?.copyWith(color: kgrey),
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
                              backgroundImage: userModel.image == null ||
                                      userModel.image == ""
                                  ? const AssetImage(
                                          'assets/default_profile.png')
                                      as ImageProvider
                                  : NetworkImage('${userModel.image}'),
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
// ! screenshot
  // Future<String> saveImage(Uint8List bytes) async {
  //   await [Permission.storage].request();
  //   final time = DateTime.now()
  //       .toIso8601String()
  //       .replaceAll('.', '_')
  //       .replaceAll('.', '_');
  //   final name = 'screenshot_$time';
  //   final result = await ImageGallerySaver.saveImage(bytes, name: name);
  //   return result['filePath'];
  // }

  profileStory(StoryModel story) {
    return [
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: CircleAvatar(radius: 24, backgroundColor: defaultColor.shade800),
      ),
      Padding(
        padding: const EdgeInsets.all(14.0),
        child: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.grey.shade400.withOpacity(0.3),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16),
        child: CircleAvatar(
          radius: 20,
          backgroundImage: story.storyUserImage == null ||
                  story.storyUserImage == ""
              ? const AssetImage('assets/default_profile.png') as ImageProvider
              : NetworkImage(story.storyUserImage!),
        ),
      ),
    ];
  }

  _noStoriesWidget(BuildContext context) => Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          border: Border.all(color: kgrey),
          borderRadius: BorderRadius.circular(30),
        ),
        width: MediaQuery.of(context).size.width * 0.40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No stories yet",
              style: TextStyle(color: klight, fontSize: 22),
            ),
            const SizedBox(height: 10),
            defaultButton(
                text: "Try Again",
                textSize: 12,
                background: kblue,
                radius: 20,
                width: 85),
          ],
        ),
      );

  _buildWhatonYourMind(UserModel? socialUserModel) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
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
                      Expanded(
                        child:
                            // GestureDetector(
                            //     onTap: () {
                            //       Get.to(const SocialSearchScreen());
                            //     },
                            //     child: const Text(
                            //       'Search your friend here...',
                            //       style: TextStyle(
                            //           fontSize: 18, fontWeight: FontWeight.bold),
                            //     )),

                            GestureDetector(
                          onTap: () {
                            Get.to(NewPostScreen());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: kblack),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("What's on your mind..."),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                // IconButton(
                //   icon: const Icon(Icons.filter, color: Colors.green),
                //   onPressed: () {
                //     Get.to(NewPostScreen(
                //       isImageClicked: true,
                //     ));
                //   },
                // ),
                InkWell(
                  onTap: () {
                    Get.to(NewPostScreen(
                      isImageClicked: true,
                    ));
                  },
                  child: Image.asset(
                    'assets/picture.png',
                    width: 30,
                  ),
                )
              ],
            ),
          ),
          _buildStreamsRow(),
        ],
      ),
    );
  }

  final List<IconData> _streamIcons = [
    FontAwesomeIcons.clapperboard,
    FontAwesomeIcons.video,
    Icons.groups_rounded,
    Icons.live_tv_sharp
  ];

  final List<Color> _streamIconColors = [
    Colors.pink.shade400,
    Colors.purple.shade400,
    defaultColor,
    Colors.red.shade400
  ];

  _buildStreamsRow() {
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(10.0),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [],
      ),
    );
  }

  _buildStreamItem(String text, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
        child: Row(
          children: [
            icon == Icons.groups_rounded
                ? CircleAvatar(
                    radius: 8,
                    backgroundColor: defaultColor,
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 14,
                    ),
                  )
                : Icon(
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
        ),
      ),
    );
  }
}
// Future _refreshData() async {
//   Get.delete<SocialLayoutController>();
//   await Future.delayed(Duration(seconds: 3));
//   Get.put(SocialLayoutController());
//   SocialLayoutController.onload();
// }
