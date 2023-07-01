// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, avoid_print

import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout_controller.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/addstory/story_controller.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/components/componets.dart';
import 'package:get/get.dart';

class AddStoryScreen extends StatelessWidget {
  AddStoryScreen({Key? key}) : super(key: key);
  var storyBodyController = TextEditingController();

  SocialLayoutController socialLayoutController =
      Get.find<SocialLayoutController>();
  @override
  Widget build(BuildContext context) {
    //NOTE remove status and bottom bar
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
    return GetBuilder<StoriesController>(
      init: StoriesController(tag: "AddStoryScreen"),
      builder: (storyController) => Scaffold(
        backgroundColor: Colors.black,
        body: storyController.storyimage != null
            ? Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                ),
                                image: DecorationImage(
                                  image: FileImage(storyController.storyimage!),
                                  fit: BoxFit.contain,
                                ),
                              )),
                          IconButton(
                              onPressed: () {
                                //NOTE : Remove post image
                                storyController.removeStoryImage();
                                storyController.pickStoryImage();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 30,
                              )),
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: () {
                                Get.back();
                                SystemChrome.setEnabledSystemUIMode(
                                  SystemUiMode.manual,
                                  overlays: [SystemUiOverlay.top],
                                );
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          )
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 3, right: 3),
                        child: Container(
                            child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                                child: defaultTextFormField(
                                    controller: storyBodyController,
                                    inputtype: TextInputType.name,
                                    border: InputBorder.none,
                                    prefixIcon: const Icon(Icons.image),
                                    hinttext: "Add a caption..."),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Obx(
                              () => storyController.isLoadingAddStory.value
                                  ? const CircularProgressIndicator()
                                  : GestureDetector(
                                      onTap: () async {
                                        print("send button");
                                        await storyController
                                                .AddStoryToFireStore(
                                                    caption: storyBodyController
                                                        .text
                                                        .toString()
                                                        .trim())
                                            .then((value) async {
                                          await socialLayoutController
                                              .getStories()
                                              .then((value) {
                                            print("THEN");
                                          });
                                          print("OUTIDE THEN");
                                          Get.back();
                                          SystemChrome.setEnabledSystemUIMode(
                                            SystemUiMode.manual,
                                            overlays: [SystemUiOverlay.top],
                                          );
                                          print('after back');
                                        });
                                      },
                                      child: const CircleAvatar(
                                        radius: 25,
                                        child: Icon(Icons.send),
                                      ),
                                    ),
                            )
                          ],
                        )),
                      ),

                      // Row(
                      //   children: [
                      //     IconButton(
                      //       icon: Icon(Icons.close),
                      //       onPressed: () {
                      //         Get.back();
                      //       },
                      //     ),
                      //     Spacer(),
                      //     defaultTextButton(onpress: () {}, text: "Share"),
                      //   ],
                      // ),
                      // Expanded(
                      //   child: defaultTextFormField(
                      //       maxligne: 5,
                      //       onchange: (value) {
                      //         socialLayoutController
                      //             .ontyping_postBody(value.toString());
                      //       },
                      //       controller: storyBodyController,
                      //       inputtype: TextInputType.multiline,
                      //       border: InputBorder.none,
                      //       hinttext: "What is on your mind ..."),
                      // ),
                    ],
                  ),
                  // CircularProgressIndicator()
                ],
              )
            : const SizedBox(
                width: 0,
              ),
      ),
    );
  }
}
