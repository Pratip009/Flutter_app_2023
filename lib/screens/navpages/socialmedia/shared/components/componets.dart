import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/model/user_model.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/chat_details/chat_details_screen.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/styles/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

//NOTE  ---------default APP bar -------------------------
AppBar defaultAppBar(
        {required BuildContext context,
        String? title,
        List<Widget>? actions}) =>
    AppBar(
      titleSpacing: 5,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(title.toString()),
      actions: actions,
    );

//NOTE ----------default Button -----------------------------
Widget defaultButton(
        {double width = double.infinity,
        Color background = Colors.blue,
        VoidCallback? onpress,
        required String text,
        double radius = 0,
        double height = 40,
        double textSize = 14,
        bool? isUppercase}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        height: height,
        onPressed: onpress,
        child: Text(
          (isUppercase != null && isUppercase) ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white, fontSize: textSize),
        ),
      ),
    );

//NOTE ----------default Text  Button -----------------------------
Widget defaultTextButton(
        {@required VoidCallback? onpress,
        @required String? text,
        Color? color}) =>
    TextButton(
      onPressed: onpress,
      child: Text(
        text!,
        style: TextStyle(color: color ?? defaultColor),
      ),
    );

//NOTE ----------default TextFormField -----------------------------
Widget defaultTextFormField(
        {required TextEditingController controller,
        required TextInputType inputtype,
        Function(String?)? onfieldsubmit,
        VoidCallback? ontap,
        String? Function(String?)? onvalidate,
        Function(String?)? onchange,
        String? text,
        Widget? prefixIcon,
        Widget? suffixIcon,
        bool obscure = false,
        InputBorder? border,
        String? hinttext,
        int? maxligne}) =>
    TextFormField(
        controller: controller,
        keyboardType: inputtype,
        onFieldSubmitted: onfieldsubmit,
        onTap: ontap,
        maxLines: maxligne ?? 1,
        obscureText: obscure,
        onChanged: onchange,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          labelText: text,
          hintText: hinttext,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: border ?? const OutlineInputBorder(),
        ),
        validator: onvalidate);

//NOTE ----------My Divider -----------------------------
Widget myDivider() => Container(
      color: Colors.grey,
      width: double.infinity,
      height: 1,
    );

//NOTE ----------Toast message -----------------------------

void showToast({required message, required ToastStatus status}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseToastColor(status),
        textColor: Colors.white,
        fontSize: 16.0);

//NOTE ----------Toast Types -----------------------------

// ignore: constant_identifier_names
enum ToastStatus { Success, Error, Warning }

//NOTE ----------choose Toast Color -----------------------------
Color chooseToastColor(ToastStatus status) {
  Color color;
  switch (status) {
    case ToastStatus.Success:
      color = defaultColor;
      break;
    case ToastStatus.Error:
      color = Colors.red;
      break;
    case ToastStatus.Warning:
      color = Colors.amber;
      break;
  }
  return color;
}

// NOTE buildChatItem
Widget buildChatItem(
        {required BuildContext context,
        required UserModel userModel,
        bool isForChatScreen = false}) =>
    InkWell(
      onTap: () {
        // socialLayoutController.getMessages(
        //     receiverId: userModel.uId.toString());
        Get.to(ChatDetailsScreen(
          socialUserModel: userModel,
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: userModel.image == null || userModel.image == ""
                  ? const AssetImage('assets/default_profile.png')
                      as ImageProvider
                  : NetworkImage(userModel.image!),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        userModel.name.toString(),
                        style: const TextStyle(
                            height: 1.4,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    isForChatScreen && userModel.messageModel != null
                        ? Text(
                            DateFormat("h:mm a").format(DateTime.parse(userModel
                                .messageModel!.messageDate
                                .toString())),
                            style: const TextStyle(color: Colors.grey),
                          )
                        : const SizedBox(
                            width: 0,
                          ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                isForChatScreen && userModel.messageModel != null
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          userModel.messageModel!.text.toString(),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : const SizedBox(
                        height: 0,
                      ),
              ],
            )),
          ],
        ),
      ),
    );

buildFriendItem(BuildContext context, String text) {
  return SizedBox(
      width: MediaQuery.of(context).size.width * .28,
      height: 140,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width * .28,
                child: Image.asset(
                  "assets/profile_test.jpg",
                  fit: BoxFit.fitWidth,
                )),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ));
}


