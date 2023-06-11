// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2023/widgets/constant.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../provider/auth_provider.dart';
import '../../../../utils/dimensions.dart';
import '../api/apis.dart';
import '../helper/dialogs.dart';

import '../models/chat_user.dart';

//profile screen -- to show signed in user info
class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return GestureDetector(
      // for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: kblacklight2,
          //app bar
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: kblack,
                )),
            centerTitle: true,
            elevation: 1,
            title: Text(
              'Profile',
              style: TextStyle(color: kblack),
            ),
            backgroundColor: klight,
          ),

          // floating button to log out
          // floatingActionButton: Padding(
          //   padding: const EdgeInsets.only(bottom: 10),
          //   child:
          //   FloatingActionButton.extended(
          //       backgroundColor: Colors.redAccent,
          //       onPressed: () async {
          //         //for showing progress dialog
          //         Dialogs.showProgressBar(context);

          //         await APIs.updateActiveStatus(false);

          //         //sign out from app
          //         await APIs.auth.signOut().then((value) async {
          //           await GoogleSignIn().signOut().then((value) {
          //             //for hiding progress dialog
          //             Navigator.pop(context);

          //             //for moving to home screen
          //             Navigator.pop(context);

          //             APIs.auth = FirebaseAuth.instance;

          //             //replacing home screen with login screen
          //             Navigator.pushReplacement(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (_) => const LoginScreen()));
          //           });
          //         });
          //       },
          //       icon: Icon(
          //         Icons.logout,
          //         color: knewwhite,
          //       ),
          //       label: Text(
          //         'Logout',
          //         style: TextStyle(color: knewwhite),
          //       )),
          // ),

          //body
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.screenWidth * .05),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // for adding some space
                    SizedBox(
                        width: Dimensions.screenWidth,
                        height: Dimensions.screenHeight * .03),

                    //user profile picture
                    Stack(
                      children: [
                        //profile picture
                        _image != null
                            ?

                            //local image
                            ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.screenHeight * .1),
                                child: Image.file(File(_image!),
                                    width: Dimensions.screenHeight * .2,
                                    height: Dimensions.screenHeight * .2,
                                    fit: BoxFit.cover))
                            :

                            //image from server
                            ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.screenHeight * .1),
                                child: CachedNetworkImage(
                                  width: Dimensions.screenHeight * .2,
                                  height: Dimensions.screenHeight * .2,
                                  fit: BoxFit.cover,
                                  imageUrl: ap.userModel.profilePic,
                                  errorWidget: (context, url, error) =>
                                      const CircleAvatar(
                                          child: Icon(CupertinoIcons.person)),
                                ),
                              ),

                        //edit image button
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: MaterialButton(
                            elevation: 1,
                            onPressed: () {
                              _showBottomSheet();
                            },
                            shape: const CircleBorder(),
                            color: kblacklight,
                            child: Icon(Icons.edit, color: knewwhite),
                          ),
                        )
                      ],
                    ),

                    // for adding some space
                    SizedBox(height: Dimensions.screenHeight * .03),

                    // user email label
                    Text(ap.userModel.unique,
                        style: TextStyle(color: knewwhite, fontSize: 16)),

                    // for adding some space
                    SizedBox(height: Dimensions.screenHeight * .05),

                    // name input field
                    TextFormField(
                      enabled: false,
                      style: TextStyle(color: knewwhite),
                      initialValue: "${ap.userModel.firstname}"
                          "\u{00A0}"
                          "${ap.userModel.lastname}",
                      // onSaved: (val) => APIs.me.name = val ?? '',
                      // validator: (val) => val != null && val.isNotEmpty
                      //     ? null
                      //     : 'Required Field',
                      decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: kblacklight)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: knewwhite), //<-- SEE HERE
                          ),
                          prefixIcon: Icon(Icons.person, color: kblacklight),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'eg. Happy Singh',
                          label: Text(
                            'Name',
                            style: TextStyle(color: knewwhite),
                          )),
                    ),

                    // for adding some space
                    SizedBox(height: Dimensions.screenHeight * .02),

                    // about input field
                    TextFormField(
                      style: TextStyle(color: knewwhite),
                      initialValue: widget.user.about,
                      onSaved: (val) => APIs.me.about = val ?? '',
                      validator: (val) => val != null && val.isNotEmpty
                          ? null
                          : 'Required Field',
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: knewwhite), //<-- SEE HERE
                          ),
                          prefixIcon:
                              Icon(Icons.info_outline, color: kblacklight),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'eg. Feeling Happy',
                          label: Text(
                            'About',
                            style: TextStyle(color: knewwhite),
                          )),
                    ),

                    // for adding some space
                    SizedBox(height: Dimensions.screenHeight * .05),

                    // update profile button
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kblacklight,
                          shape: const StadiumBorder(),
                          minimumSize: Size(Dimensions.screenWidth * .5,
                              Dimensions.screenHeight * .06)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          APIs.updateUserInfo().then((value) {
                            Dialogs.showSnackbar(
                                context, 'Profile Updated Successfully!');
                          });
                        }
                      },
                      icon: const Icon(Icons.edit, size: 28),
                      label:
                          const Text('UPDATE', style: TextStyle(fontSize: 16)),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  // bottom sheet for picking a profile picture for user
  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: Dimensions.screenHeight * .03,
                bottom: Dimensions.screenHeight * .05),
            children: [
              //pick profile picture label
              const Text('Pick Profile Picture',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),

              //for adding some space
              SizedBox(height: Dimensions.screenHeight * .02),

              //buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //pick from gallery button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(Dimensions.screenWidth * .3,
                              Dimensions.screenHeight * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });

                          APIs.updateProfilePicture(File(_image!));
                          // for hiding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/images/add_image.png')),

                  //take picture from camera button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: Size(Dimensions.screenWidth * .3,
                              Dimensions.screenHeight * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _image = image.path;
                          });

                          APIs.updateProfilePicture(File(_image!));
                          // for hiding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/images/camera.png')),
                ],
              )
            ],
          );
        });
  }
}
