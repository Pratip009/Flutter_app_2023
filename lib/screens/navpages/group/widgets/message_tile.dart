
import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/group/helper/timestamp_converter.dart';
import 'package:flutter_application_2023/screens/navpages/group/pages/imageview.dart';


class MessageTile extends StatefulWidget {
  const MessageTile(
      {super.key,
      required this.isMe,
      required this.message,
      required this.sender,
      required this.messageTimeStamp,
      required this.image});

  final String message;
  final String sender;
  final bool isMe;
  final String image;
  final int messageTimeStamp;

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.image != "") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ImageViewPage(
                      imagePath: widget.image, message: widget.message)));
        }
      },
      child: Container(
          padding: EdgeInsets.only(
              top: 4,
              bottom: 4,
              left: widget.isMe ? 0 : 24,
              right: widget.isMe ? 24 : 0),
          alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Column(
              crossAxisAlignment: (widget.isMe)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.only(
                        top: 17,
                        bottom: 17,
                        left: (widget.image == "") ? 20 : 10,
                        right: (widget.image == "") ? 20 : 10),
                    decoration: BoxDecoration(
                      borderRadius: widget.isMe
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            )
                          : const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                      color: widget.isMe
                          ? Theme.of(context).colorScheme.secondary
                          : const Color(0xffb383152),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.sender.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          (widget.image == "")
                              ? const SizedBox.shrink()
                              : ClipRRect(
                                  child: Image.network(
                                    widget.image,
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 150,
                                  ),
                                ),
                          Text(
                            widget.message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14),
                          )
                        ])),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(DateTimeConverter.convertTimeStamp(
                      widget.messageTimeStamp)),
                )
              ])),
    );
  }
}