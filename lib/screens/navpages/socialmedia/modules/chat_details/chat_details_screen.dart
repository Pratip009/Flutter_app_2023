// ignore_for_file: must_be_immutable, avoid_print, prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/model/message_model.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/model/user_model.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/chat_details/chatdetailsController.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/friend_profile/friend_profile_screen.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/constants.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/styles/colors.dart';
import 'package:flutter_application_2023/widgets/constant.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatDetailsScreen extends StatefulWidget {
  UserModel socialUserModel;
  var messagesQuery;

  ChatDetailsScreen({super.key, required this.socialUserModel}) {
    messagesQuery = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(socialUserModel.uId)
        .collection('messages')
        .orderBy('messageDate', descending: true)
        .withConverter<MessageModel>(
          fromFirestore: (snapshot, _) =>
              MessageModel.fromJson(snapshot.data()!),
          toFirestore: (message, _) => message.toJson(),
        );
  }

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // show top status bar
    // Future.delayed(Duration(microseconds: 2)).then((value) {
    //   SystemChrome.setEnabledSystemUIMode(
    //     SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top],
    //   );
    // });

    return GetBuilder<ChatDetailsController>(
        init: ChatDetailsController(),
        builder: (chatDetailsController) {
          //  chatDetailsController.getMessages(receiverId: socialUserModel.uId!);

          //   if (chatDetailsController.listOfMessages.length > 0 &&
          //       chatDetailsController.listOfMessages.first.senderId != uId!)
          //     chatDetailsController
          //         .updatestatusMessage(chatDetailsController.listOfMessages);

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: knewwhite,
                ),
                onPressed: () {
                  Get.off(const SocialLayout());
                },
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.video_call_rounded,
                      color: knewwhite,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.phone,
                      color: knewwhite,
                    ))
              ],
              titleSpacing: 0,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(FriendProfileScreen(
                          widget.socialUserModel.uId.toString()));
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: widget.socialUserModel.image == null ||
                              widget.socialUserModel.image == ""
                          ? const AssetImage('assets/default_profile.png')
                              as ImageProvider
                          : NetworkImage(
                              widget.socialUserModel.image.toString()),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.socialUserModel.name.toString(),
                    style: TextStyle(color: knewwhite),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                // NOTE while image uploading to firebase storage
                chatDetailsController.isloadingUrlMessage == true
                    ? const LinearProgressIndicator()
                    : const SizedBox(
                        height: 0,
                      ),

                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/background_image.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: FirestoreListView<MessageModel>(
                      reverse: true,
                      //    physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      pageSize: 10,
                      query: widget.messagesQuery,
                      loadingBuilder: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorBuilder: (context, error, stackTrace) =>
                          Text('Something went wrong! $error - $stackTrace'),
                      itemBuilder: (context, snapshot) {
                        MessageModel model;

                        if (snapshot.data().text == null) {
                          print('snapshot blank');

                          print(snapshot.data().text);
                          return const Text("no messages yet");
                        } else {
                          model = snapshot.data();
                          print('snapshot data');
                          print(snapshot.data().text);
                        }

                        if (model.senderId != uId &&
                            model.isReadByfriend == false) {
                          chatDetailsController.updatestatusMessage(model);
                        }

                        if (model.senderId == uId) {
                          return Column(
                            children: [
                              _buildMyMessage(model, context),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              _buildMessage(model, context),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),

                // Spacer(),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    // borderRadius: BorderRadius.circular(15)),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Obx(
                    () => Row(
                      children: [
                        //NOTE if an image picked so displayed inside Row
                        chatDetailsController.messageImage != null
                            ? Expanded(
                                child: Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    Container(
                                        constraints: const BoxConstraints(
                                          maxHeight: 300,
                                        ),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                          ),
                                          image: DecorationImage(
                                            image: FileImage(
                                                chatDetailsController
                                                    .messageImage!),
                                            fit: BoxFit.fill,
                                          ),
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          //NOTE : Remove post image
                                          chatDetailsController
                                              .removeMessageImage();
                                        },
                                        icon: const CircleAvatar(
                                            radius: 20,
                                            child: Icon(
                                              Icons.close,
                                              size: 17,
                                            ))),
                                  ],
                                ),
                              )
                            //NOTE if not image picked so textformfield display to typing
                            :
                            // Expanded(
                            //     child: Padding(
                            //       padding: const EdgeInsets.symmetric(
                            //         horizontal: 50,
                            //       ),
                            //       child: TextFormField(
                            //         controller: textController,
                            //         keyboardType: TextInputType.multiline,
                            //         onChanged: (value) {
                            //           chatDetailsController
                            //               .ontypingmessage(value);
                            //         },
                            //         style:
                            //             Theme.of(context).textTheme.bodyLarge,
                            //         maxLines: 40,
                            //         minLines: 1,
                            //         decoration: const InputDecoration(
                            //             border: InputBorder.none,
                            //             hintText: 'Type your message here ...',
                            //             hintStyle: TextStyle(
                            //               fontWeight: FontWeight.normal,
                            //             )),
                            //       ),
                            //     ),
                            //   ),
                            Expanded(
                                child: TextField(
                                controller: textController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                onTap: () {
                                  // if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                                },
                                decoration: InputDecoration(
                                  hintText: 'Type Something..',
                                  hintStyle: TextStyle(color: kblack),
                                  border: InputBorder.none,
                                ),
                              )),

                        // NOTE if textformField has data display send button
                        chatDetailsController.messageText.value != ""
                            ? Container(
                                color: defaultColor,
                                width: 50,
                                child: MaterialButton(
                                  onPressed: () {
                                    //NOTE to close keyboard
                                    // SystemChannels.textInput
                                    //     .invokeMethod('TextInput.hide');

                                    chatDetailsController.sendMessage(
                                        receiverId: widget.socialUserModel.uId
                                            .toString(),
                                        messageDate: DateTime.now().toString(),
                                        text: textController.text);
                                    textController.clear();
                                    chatDetailsController.ontypingmessage("");
                                    // scrollController.animateTo(
                                    //     scrollController
                                    //         .position.maxScrollExtent,
                                    //     duration: Duration(microseconds: 500),
                                    //     curve: Curves.fastOutSlowIn);
                                  },
                                  minWidth: 1,
                                  child: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                ))
                            // NOTE if textform field is empty so is check is an image picked if yes display send else display camera button
                            : chatDetailsController.messageImage != null
                                ? Container(
                                    color: defaultColor,
                                    width: 50,
                                    child: MaterialButton(
                                      onPressed: () async {
                                        // NOTE uplaod Image to firebase and wait to get url image
                                        await chatDetailsController
                                            .uploadMessageImage(widget
                                                .socialUserModel.uId
                                                .toString());
                                        // NOTE remove image from row
                                        chatDetailsController
                                            .removeMessageImage();
                                      },
                                      minWidth: 1,
                                      child: const Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ),
                                    ))
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Container(
                                        color: defaultColor,
                                        width: 50,
                                        child: MaterialButton(
                                          onPressed: () {
                                            chatDetailsController.pickImage();
                                          },
                                          minWidth: 1,
                                          child: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                          ),
                                        )),
                                  ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildMyMessage(MessageModel model, BuildContext context) => model.text
              .toString() !=
          ""
      ? Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: defaultColor.withOpacity(0.4),
              borderRadius: const BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              ),
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.62),
                      child: Text(
                        model.text.toString(),
                        style: const TextStyle(fontSize: 23),
                        maxLines: 100,
                      ),
                    ),
                    const Flexible(
                      child: SizedBox(
                        width: 80,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat("h:mm a")
                          .format(DateTime.parse(model.messageDate.toString())),
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    model.isReadByfriend == true
                        ? Icon(Icons.check,
                            size: 17, color: Colors.blue.shade700)
                        : Icon(Icons.check,
                            size: 17, color: Colors.grey.shade700),
                  ],
                ),
              ],
            ),
          ),
        )
      : Stack(
          alignment: Alignment.bottomRight,
          children: [
            SizedBox(
              width: double.infinity,
              height: 180,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(4),
              //   image: DecorationImage(
              //     image: NetworkImage('${model.image}'),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              child: CachedNetworkImage(
                imageUrl: model.image.toString(),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      // colorFilter: ColorFilter.mode(
                      //     Colors.red, BlendMode.colorBurn)
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/notfound.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                getMessageTimeFromDate(model.messageDate.toString()),
                style: TextStyle(color: Colors.grey.shade900),
              ),
            ),
          ],
        );

  Widget _buildMessage(MessageModel model, context) => model.text.toString() !=
          ""
      ? Align(
          alignment: AlignmentDirectional.centerStart,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10),
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              ),
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.62),
                      child: Text(
                        model.text.toString(),
                        style: const TextStyle(fontSize: 23),
                        maxLines: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                  ],
                ),
                Text(
                  DateFormat("h:mm a")
                      .format(DateTime.parse(model.messageDate.toString())),
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        )
      // Image
      : Stack(
          alignment: Alignment.bottomRight,
          children: [
            SizedBox(
              width: double.infinity,
              height: 180,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(4),
              //   image: DecorationImage(
              //     image: NetworkImage('${model.image}'),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              child: CachedNetworkImage(
                imageUrl: model.image.toString(),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      // colorFilter: ColorFilter.mode(
                      //     Colors.red, BlendMode.colorBurn)
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/notfound.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                getMessageTimeFromDate(model.messageDate.toString()),
                style: TextStyle(color: Colors.grey.shade900),
              ),
            ),
          ],
        );
}
