// ignore_for_file: must_be_immutable, prefer_interpolation_to_compose_strings, avoid_print, unrelated_type_equality_checks

import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout_controller.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/components/componets.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/styles/colors.dart';
import 'package:flutter_application_2023/utils/dimensions.dart';
import 'package:get/get.dart';

class NewPostScreen extends StatelessWidget {
  var postBodyController = TextEditingController();

  bool? isImageClicked = false;
  bool _showEmoji = false;

  NewPostScreen({super.key, this.isImageClicked});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialLayoutController>(
        init: Get.find<SocialLayoutController>(),
        builder: (socialLayoutController) {
          var socialUserModel = socialLayoutController.socialUserModel!;
          if (isImageClicked == true) {
            socialLayoutController.pickPostImage().then((value) async {
              isImageClicked = false;
              if (socialLayoutController.postimage != null) {
                await decodeImageFromList(
                        File(socialLayoutController.postimage!.path)
                            .readAsBytesSync())
                    .then((value) {
                  print("image width : " + value.width.toString());
                  print("image height : " + value.height.toString());
                });
              }
            });
          }
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Scaffold(
                appBar: defaultAppBar(
                    context: context,
                    title: "Add Post",
                    actions: [
                      socialLayoutController.postBodyText != "" ||
                              socialLayoutController.postimage != null
                          ? defaultTextButton(
                              onpress: () {
                                socialLayoutController
                                    .createNewPost(
                                        postdate: DateTime.now().toString(),
                                        text: postBodyController.text,
                                        imagewidth: double.parse(
                                            socialLayoutController
                                                .post_imageWidth
                                                .toString()),
                                        imageheight: double.parse(
                                            socialLayoutController
                                                .post_imageHeight
                                                .toString()))
                                    .then((value) {
                                  if (!socialLayoutController
                                      .isloadingcreatePost!) {
                                    Navigator.pop(context);
                                  }
                                });
                              },
                              text: "Post")
                          : defaultTextButton(
                              onpress: () {
                                // ignore: avoid_returning_null_for_void
                                return null;
                              },
                              text: "Post",
                              color: Colors.grey)
                    ]),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if (socialLayoutController.isloadingcreatePost!)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: socialUserModel.image == null ||
                                    socialUserModel.image == ""
                                ? const AssetImage('assets/default_profile.png')
                                    as ImageProvider
                                : NetworkImage(socialUserModel.image!),
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
                                    socialUserModel.name ?? 'No Name',
                                    style: const TextStyle(height: 1.4),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  if (socialUserModel.isemailverified == true)
                                    const Icon(
                                      Icons.check_circle,
                                      color: defaultColor,
                                      size: 16,
                                    )
                                ],
                              ),
                            ],
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                _showEmoji = !_showEmoji;
                              },
                              icon: const Icon(Icons.emoji_emotions_outlined)),
                          Expanded(
                            child: defaultTextFormFieldForSocial(
                                ontap: () {
                                  if (_showEmoji) {
                                    _showEmoji = !_showEmoji;
                                  }
                                },
                                onchange: (value) {
                                  socialLayoutController
                                      .ontyping_postBody(value.toString());
                                },
                                controller: postBodyController,
                                inputtype: TextInputType.multiline,
                                border: InputBorder.none,
                                hinttext: "What is on your mind ..."),
                          ),
                        ],
                      ),
                      if (_showEmoji)
                        SizedBox(
                          height: Dimensions.height280,
                          child: EmojiPicker(
                            textEditingController:
                                postBodyController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
                            config: Config(
                              bgColor: Colors.white,
                              columns: 8,
                              emojiSizeMax: 32 *
                                  (Platform.isIOS
                                      ? 1.30
                                      : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                            ),
                          ),
                        ),
                      if (socialLayoutController.postimage != null)
                        Expanded(
                          flex: 2,
                          child: ListView(
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                      //curently fixed like this
                                      constraints:
                                          const BoxConstraints(maxHeight: 450),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                                        image: DecorationImage(
                                          image: FileImage(
                                              socialLayoutController
                                                  .postimage!),
                                          fit: BoxFit.fill,
                                        ),
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        //NOTE : Remove post image
                                        socialLayoutController
                                            .removePostImage();
                                      },
                                      icon: const CircleAvatar(
                                          radius: 20,
                                          child: Icon(
                                            Icons.close,
                                            size: 17,
                                          ))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      if (socialLayoutController.postimage == null)
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                  onPressed: () async {
                                    await socialLayoutController
                                        .pickPostImage()
                                        .then((value) {});
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Add Photo"),
                                    ],
                                  )),
                            ),
                            // Expanded(
                            //   child: TextButton(
                            //       onPressed: () {},
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           Text("# tags"),
                            //         ],
                            //       )),
                            // ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
