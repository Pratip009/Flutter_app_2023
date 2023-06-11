// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/chat/groupchat/pages/group_info.dart';
import 'package:flutter_application_2023/screens/navpages/chat/groupchat/services/database_services.dart';

import 'package:flutter_application_2023/screens/navpages/chat/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../utils/dimensions.dart';
import '../../../../../widgets/constant.dart';
import '../../api/apis.dart';
import '../../widgets/message_tile.dart';

class ChatPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;
  const ChatPage({
    Key? key,
    required this.groupId,
    required this.groupName,
    required this.userName,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();
  String admin = "";
  @override
  void initState() {
    getChatandAdmin();
    super.initState();
  }

  getChatandAdmin() {
    DatabaseService().getChats(widget.groupId).then((val) {
      setState(() {
        chats = val;
      });
    });
    DatabaseService().getGroupAdmin(widget.groupId).then((val) {
      setState(() {
        admin = val;
      });
    });
  }

  bool _showEmoji = false, _isUploading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
          //if emojis are shown & back button is pressed then hide emojis
          //or else simple close current screen on back button click
          onWillPop: () {
            if (_showEmoji) {
              setState(() => _showEmoji = !_showEmoji);
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            //app bar
            appBar: AppBar(
              elevation: 1,
              centerTitle: true,
              title: Text(widget.groupName),
              backgroundColor: Theme.of(context).primaryColor,
              actions: [
                IconButton(
                    onPressed: () {
                      nextScreen(
                          context,
                          GroupInfo(
                            groupId: widget.groupId,
                            groupName: widget.groupName,
                            adminName: admin,
                          ));
                    },
                    icon: const Icon(Icons.info))
              ],
            ),

            backgroundColor: kblacklight2,

            //body
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: chats,
                    builder: (context, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                return MessageTile(
                                    message: snapshot.data.docs[index]
                                        ['message'],
                                    sender: snapshot.data.docs[index]['sender'],
                                    sentByMe: widget.userName ==
                                        snapshot.data.docs[index]['sender']);
                              },
                            )
                          : Container();
                    },
                  ),
                ),

                //progress indicator for showing uploading
                if (_isUploading)
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          child: CircularProgressIndicator(strokeWidth: 2))),
                //chat input filed
                chatTextInput(),

                //show emojis on keyboard emoji button click & vice versa
                if (_showEmoji)
                  SizedBox(
                    height: Dimensions.screenHeight * .35,
                    child: EmojiPicker(
                      textEditingController: messageController,
                      config: Config(
                        bgColor: const Color.fromARGB(255, 234, 248, 255),
                        columns: 8,
                        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget chatTextInput() {
    return SizedBox(
      child: Row(
        children: [
          //input field & buttons
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  //emoji button
                  IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() => _showEmoji = !_showEmoji);
                      },
                      icon: Icon(Icons.emoji_emotions,
                          color: kblacklight, size: 25)),

                  Expanded(
                    child: TextField(
                      controller: messageController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onTap: () {
                        if (_showEmoji) {
                          setState(() => _showEmoji = !_showEmoji);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Send a message...",
                        hintStyle: TextStyle(color: kblack),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  //pick image from gallery button
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Picking multiple images
                        final List<XFile> images =
                            await picker.pickMultiImage(imageQuality: 50);

                        // uploading & sending image one by one
                        for (var i in images) {
                          log('Image Path: ${i.path}');
                          setState(
                            () => _isUploading = true,
                          );
                          await APIs.sendGroupChatImage(
                              widget.userName, File(i.path));
                          setState(
                            () => _isUploading = false,
                          );
                        }
                      },
                      icon: Icon(Icons.image, color: kblacklight, size: 26)),

                  //take image from camera button
                  // IconButton(
                  //     onPressed: () async {
                  //       final ImagePicker picker = ImagePicker();

                  //       // Pick an image
                  //       final XFile? image = await picker.pickImage(
                  //           source: ImageSource.camera, imageQuality: 70);
                  //       if (image != null) {
                  //         log('Image Path: ${image.path}');
                  //         setState(() => _isUploading = true);

                  //         setState(() => _isUploading = false);
                  //       }
                  //     },
                  //     icon: Icon(Icons.camera_alt_rounded,
                  //         color: kblacklight, size: 26)),

                  //adding some space
                  SizedBox(width: Dimensions.screenWidth * .02),
                ],
              ),
            ),
          ),

          //send message button
          MaterialButton(
            onPressed: () {
              sendMessage();
            },
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: kblacklight,
            child: const Icon(Icons.send, color: Colors.white, size: 28),
          )
        ],
      ),
    );
  }

  chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      message: snapshot.data.docs[index]['message'],
                      sender: snapshot.data.docs[index]['sender'],
                      sentByMe: widget.userName ==
                          snapshot.data.docs[index]['sender']);
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService().sendMessage(widget.groupId, chatMessageMap);
      setState(() {
        messageController.clear();
      });
    }
  }
}
