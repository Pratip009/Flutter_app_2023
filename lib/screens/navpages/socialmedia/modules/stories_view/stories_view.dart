// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout_controller.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/model/storymodel.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/addstory/story_controller.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/constants.dart';
import 'package:get/get.dart';

import "package:story_view/story_view.dart";

class StoryViewScreen extends StatelessWidget {
  String? storyUId;
  StoryViewScreen(this.storyUId, {super.key});

  final storyController = StoryController();
  var storiesController_needed = Get.put(StoriesController());

  @override
  Widget build(BuildContext context) {
    //NOTE remove status and bottom bar
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
    return GetBuilder<SocialLayoutController>(
        init: Get.find<SocialLayoutController>(),
        builder: (socialLayoutController) {
          List<StoryModel> stories = [];
          socialLayoutController.storiesMap[storyUId]!.forEach((element) {
            stories.add(StoryModel.formJson(element));
          });
          return Scaffold(
            body: _DisplayStories(stories),
          );
        });
  }

  _DisplayStories(List<StoryModel> stories) {
    List<StoryItem> storyItems = [];

    stories.forEach((element) {
      storyItems.add(StoryItem.inlineImage(
        imageFit: BoxFit.contain,
        url: element.image.toString(),
        controller: storyController,
        caption: Text(
          element.caption.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            backgroundColor: Colors.black54,
            fontSize: 17,
          ),
        ),
      ));
      print(DateTime.parse(stories[0].storyDate!.toDate().toString()));
      storiesController_needed.onchangeStorytime(stories[0].storyDate);
    });

    return GetBuilder<StoriesController>(
      init: StoriesController(),
      builder: (storiesController) => Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          StoryView(
            controller: storyController,
            storyItems: storyItems,

            onStoryShow: (storyitem) {
              print("Showing a story");
              int pos = storyItems.indexOf(storyitem);
              if (pos > 0) {
                storiesController.onchangeStorytime(stories[pos].storyDate);
              }
            },
            onComplete: () {
              print("Completed a cycle");
              Get.back();
              //NOTE show top bar after finishing
              SystemChrome.setEnabledSystemUIMode(
                SystemUiMode.manual,
                overlays: [SystemUiOverlay.top],
              );
            },
            progressPosition: ProgressPosition.top,
            repeat: false,
            //  inline: true,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35.0, left: 25),
            child: Row(
              children: [
                const CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage('assets/default_profile.png')),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stories[0].storyName.toString(),
                      style: const TextStyle(
                        height: 1.4,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '${convertToAgo(DateTime.parse(storiesController.storytime!.toDate().toString()))} ago',
                      style: const TextStyle(color: Colors.white),
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