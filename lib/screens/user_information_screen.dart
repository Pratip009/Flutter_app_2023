// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/main_home_page.dart';
import 'package:flutter_application_2023/widgets/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../model/user_model.dart';
import '../provider/auth_provider.dart';
import '../utils/dimensions.dart';
import '../utils/utils.dart';
import '../widgets/custom_button.dart';

class UserInfromationScreen extends StatefulWidget {
  const UserInfromationScreen({super.key});

  @override
  State<UserInfromationScreen> createState() => _UserInfromationScreenState();
}

class _UserInfromationScreenState extends State<UserInfromationScreen> {
  //Profile Image
  File? image;
  //adhaar
  File? adhaarImage;
  //pan
  File? panImage;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final adhaarController = TextEditingController();
  final panController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    adhaarController.dispose();
    panController.dispose();
    addressController.dispose();
  }

  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  //adhaar photo select
  void selectadhaarImage() async {
    adhaarImage = await pickImage(context);
    setState(() {});
  }

  //pan photo select
  void selectpanImage() async {
    panImage = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: kyellow,
                ),
              )
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
                child: Center(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => selectImage(),
                        child: image == null
                            ? Stack(
                                children: [
                                  Container(
                                    height: Dimensions.height120,
                                    width: Dimensions.width120,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: Dimensions.width5,
                                        color: kblue,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color:
                                              Colors.black87.withOpacity(0.1),
                                          offset: Offset(0, 10),
                                        )
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            "assets/images/user.png"),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 60,
                                    child: Container(
                                      height: Dimensions.height20 * 2,
                                      width: Dimensions.width10 * 4,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 4,
                                          color: kblack,
                                        ),
                                        color: kyellow,
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Stack(
                                children: [
                                  Container(
                                    height: Dimensions.height20 * 6,
                                    width: Dimensions.width10 * 12,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 4,
                                        color: Colors.white,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color:
                                              Colors.black87.withOpacity(0.1),
                                          offset: Offset(0, 10),
                                        )
                                      ],
                                      shape: BoxShape.circle,
                                    ),
                                    child: CircleAvatar(
                                      backgroundImage: FileImage(image!),
                                      radius: 50,
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      height: Dimensions.height20 * 2,
                                      width: Dimensions.width10 * 4,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 4,
                                          color: Colors.white,
                                        ),
                                        color: kyellow,
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            // name field
                            textField(
                              hintlText: "Full Name",
                              icon: Icons.account_circle,
                              inputType: TextInputType.name,
                              maxLines: 1,
                              controller: nameController,
                            ),

                            // email
                            textField(
                              hintlText: "Email",
                              icon: Icons.email,
                              inputType: TextInputType.emailAddress,
                              maxLines: 1,
                              controller: emailController,
                            ),
                            //age
                            textField(
                              hintlText: "Age",
                              icon: Icons.numbers,
                              inputType: TextInputType.number,
                              maxLines: 1,
                              controller: ageController,
                            ),

                            // adhhar
                            textField(
                              hintlText: "Adhaar Number",
                              icon: Icons.document_scanner_sharp,
                              inputType: TextInputType.number,
                              maxLines: 1,
                              controller: adhaarController,
                            ),
                            //adhaar image dropbox
                            InkWell(
                              onTap: () => selectadhaarImage(),
                              child: adhaarImage == null
                                  ? Stack(
                                      children: [
                                        Container(
                                          height: 175,
                                          width: double.infinity,
                                          margin: EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(color: kblack),
                                          ),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.cloud_upload_rounded,
                                                size: 60,
                                                color: kwhite,
                                              ),
                                              Text(
                                                "Drop Your Adhaar Image Here",
                                                style: GoogleFonts.lato(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 35,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade300,
                                                ),
                                                padding: EdgeInsets.all(8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    Icon(
                                                      Icons.search,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "Choose File",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Max file size: 5MB",
                                                style: GoogleFonts.lato(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Stack(
                                      children: [
                                        Container(
                                          height: 280,
                                          width: double.infinity,
                                          margin: EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(color: kblack),
                                          ),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.cloud_upload_rounded,
                                                size: 60,
                                                color: kwhite,
                                              ),
                                              Text(
                                                "Drop Your Adhaar Image Here",
                                                style: GoogleFonts.lato(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 35,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade300,
                                                ),
                                                padding: EdgeInsets.all(8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    Icon(
                                                      Icons.search,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "Choose File",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Max file size: 5MB",
                                                style: GoogleFonts.lato(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              SizedBox(
                                                height: Dimensions.height20,
                                              ),
                                              Container(
                                                  height:
                                                      Dimensions.height20 * 4,
                                                  width: 150,
                                                  child: Image(
                                                    image:
                                                        FileImage(adhaarImage!),
                                                    fit: BoxFit.cover,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                            //pan
                            textField(
                              hintlText: "PAN Number",
                              icon: Icons.add_card,
                              inputType: TextInputType.number,
                              maxLines: 1,
                              controller: panController,
                            ),
                            //pan image
                            InkWell(
                              onTap: () => selectpanImage(),
                              child: panImage == null
                                  ? Stack(
                                      children: [
                                        Container(
                                          height: 175,
                                          width: double.infinity,
                                          margin: EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(color: kblack),
                                          ),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.cloud_upload_rounded,
                                                size: 60,
                                                color: kwhite,
                                              ),
                                              Text(
                                                "Drop Your PAN Image Here",
                                                style: GoogleFonts.lato(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 35,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade300,
                                                ),
                                                padding: EdgeInsets.all(8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    Icon(
                                                      Icons.search,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "Choose File",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Max file size: 5MB",
                                                style: GoogleFonts.lato(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Stack(
                                      children: [
                                        Container(
                                          height: 280,
                                          width: double.infinity,
                                          margin: EdgeInsets.only(bottom: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(color: kblack),
                                          ),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.cloud_upload_rounded,
                                                size: 60,
                                                color: kwhite,
                                              ),
                                              Text(
                                                "Drop Your PAN Image Here",
                                                style: GoogleFonts.lato(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 35,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade300,
                                                ),
                                                padding: EdgeInsets.all(8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    Icon(
                                                      Icons.search,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "Choose File",
                                                      style: GoogleFonts.lato(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Max file size: 5MB",
                                                style: GoogleFonts.lato(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              SizedBox(
                                                height: Dimensions.height20,
                                              ),
                                              Container(
                                                  height:
                                                      Dimensions.height20 * 4,
                                                  width: 150,
                                                  child: Image(
                                                    image: FileImage(panImage!),
                                                    fit: BoxFit.cover,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                            //bio
                            textField(
                              hintlText: "Address",
                              icon: Icons.edit,
                              inputType: TextInputType.name,
                              maxLines: 1,
                              controller: addressController,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: CustomButton(
                          text: "CONTINUE",
                          onPressed: () => storeData(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget textField({
    required String hintlText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: kblack,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: kwhite,
                border: Border.all(
                  color: kblack,
                )),
            child: Icon(
              icon,
              size: 20,
              color: kblack,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: kblack,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black26,
            ),
          ),
          hintText: hintlText,
          hintStyle: GoogleFonts.lato(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
            color: Colors.black87,
          ),
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.white70,
          filled: true,
        ),
      ),
    );
  }

  // store user data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      age: ageController.text.trim(),
      adhaar: adhaarController.text.trim(),
      pan: panController.text.trim(),
      address: addressController.text.trim(),
      profilePic: "",
      createdAt: "",
      phoneNumber: "",
      uid: "",
      adhaarImage: "",
      panImage: "",
    );
    if (image != null) {
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        profilePic: image!,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainHomePage(),
                          ),
                          (route) => false),
                    ),
              );
        },
      );
    } else {
      showSnackBar(context, "Please upload your profile photo");
    }
    //adhaar
    if (adhaarImage != null) {
      ap.saveUseradhaarDataToFirebase(
        context: context,
        userModel: userModel,
        adhaarImage: adhaarImage!,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainHomePage(),
                          ),
                          (route) => false),
                    ),
              );
        },
      );
    } else {
      showSnackBar(context, "Please upload your adhaar photo");
    }
    //pan
    if (panImage != null) {
      ap.saveUserpanDataToFirebase(
        context: context,
        userModel: userModel,
        panImage: panImage!,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainHomePage(),
                          ),
                          (route) => false),
                    ),
              );
        },
      );
    } else {
      showSnackBar(context, "Please upload your pan photo");
    }
  }
}
