// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_application_2023/screens/navpages/main_screen.dart';
import 'package:flutter_application_2023/widgets/constant.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import '../model/user_model.dart';
import '../provider/auth_provider.dart';
import '../utils/dimensions.dart';
import '../utils/utils.dart';
import '../widgets/custom_button.dart';
import 'package:intl/intl.dart';

class UserInfromationScreen extends StatefulWidget {
  const UserInfromationScreen({super.key});

  @override
  State<UserInfromationScreen> createState() => _UserInfromationScreenState();
}

class _UserInfromationScreenState extends State<UserInfromationScreen> {
  final _formKey = GlobalKey<FormState>();
  //Profile Image
  File? image;
  //adhaar
  File? adhaarImage;
  //pan
  File? panImage;

  // ignore: non_constant_identifier_names
  final FirstnameController = TextEditingController();
  // ignore: non_constant_identifier_names
  final LastnameController = TextEditingController();
  // final emailController = TextEditingController();
  final ageController = TextEditingController();
  final adhaarController = TextEditingController();
  final panController = TextEditingController();
  final addressController = TextEditingController();
  final districtController = TextEditingController();
  final cityController = TextEditingController();
  final pinController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    FirstnameController.dispose();
    LastnameController.dispose();
    // emailController.dispose();
    ageController.dispose();
    adhaarController.dispose();
    panController.dispose();
    addressController.dispose();
    districtController.dispose();
    cityController.dispose();
    pinController.dispose();
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
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: kyellow,
                ),
              )
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: kblacklight2,
                      ),
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
                                            width: 2,
                                            color: kblacklight,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              color:
                                                  Colors.white.withOpacity(0.1),
                                              offset: Offset(0, 10),
                                            )
                                          ],
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: AssetImage(
                                                "assets/images/profile.png"),
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
                                              width: 2,
                                              color: kblacklight,
                                            ),
                                            color: kblacklight2,
                                          ),
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            color: kblacklight,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    children: [
                                      Container(
                                        height: Dimensions.height120,
                                        width: Dimensions.width120,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 4,
                                            color: Colors.white,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              color: Colors.black87
                                                  .withOpacity(0.1),
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
                                        bottom: 60,
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
                          Text(
                            'Registration',
                            style: TextStyle(
                                fontSize: 20,
                                color: knewwhite,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          Text(
                            'Please fill out the following form',
                            style: TextStyle(
                              fontSize: 16,
                              color: knewwhite,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            margin: const EdgeInsets.only(top: 15),
                            child: Column(
                              children: [
                                // first name field
                                textField(
                                  labelText: 'First Name',
                                  ontap: () {},
                                  hintlText: "Enter your First Name",
                                  icon: Icons.account_circle,
                                  inputType: TextInputType.name,
                                  maxLines: 1,
                                  controller: FirstnameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'User Name Required';
                                    }
                                    return null;
                                  },
                                ),
                                // last name field
                                textField(
                                  labelText: 'Last Name',
                                  ontap: () {},
                                  hintlText: "Enter your Last Name",
                                  icon: Icons.account_circle,
                                  inputType: TextInputType.name,
                                  maxLines: 1,
                                  controller: LastnameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'User Name Required';
                                    }
                                    return null;
                                  },
                                ),

                                // email
                                // textField(
                                //   labelText: 'Email',
                                //   ontap: () {},
                                //   hintlText: "Enter your Email",
                                //   icon: Icons.email,
                                //   inputType: TextInputType.emailAddress,
                                //   maxLines: 1,
                                //   controller: emailController,
                                //   validator: (value) {
                                //     if (value == null || value.isEmpty) {
                                //       return 'Email id Required';
                                //     }
                                //     return null;
                                //   },
                                // ),
                                //age
                                textField(
                                  labelText: 'Date Of Birth',
                                  hintlText:
                                      "Select Date Of Birth from calender",
                                  icon: Icons.calendar_month_outlined,
                                  inputType: TextInputType.number,
                                  maxLines: 1,
                                  controller: ageController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Date of Birth required';
                                    }
                                    return null;
                                  },
                                  ontap: () async {
                                    DateTime? pickeddate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime(2100));
                                    if (pickeddate != null) {
                                      ageController.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickeddate);
                                    }
                                  },
                                ),

                                // adhhar
                                textField(
                                  labelText: 'Adhaar Number',
                                  ontap: () {},
                                  hintlText: "Enter your Adhaar Number",
                                  icon: Icons.document_scanner_sharp,
                                  inputType: TextInputType.number,
                                  maxLines: 1,
                                  controller: adhaarController,
                                  validator: (value) {
                                    if (value?.length != 12) {
                                      return 'Adhaar Number must be of 12 digit';
                                    }
                                    return null;
                                  },
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
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF191919),
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kblacklight,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height: 35,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      color: kwhite,
                                                    ),
                                                    padding: EdgeInsets.all(8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.search,
                                                          color: kblack,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "Choose File",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: kblack,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kwhite,
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
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF191919),
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kblacklight,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height: 35,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      color: kwhite,
                                                    ),
                                                    padding: EdgeInsets.all(8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.search,
                                                          color: kblack,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "Choose File",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: kblack,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kwhite,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.height20,
                                                  ),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: kyellow)),
                                                      height:
                                                          Dimensions.height20 *
                                                              4,
                                                      width: 150,
                                                      child: Image(
                                                        image: FileImage(
                                                            adhaarImage!),
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
                                  labelText: 'PAN Number',
                                  ontap: () {},
                                  hintlText: "Enter your PAN number",
                                  icon: Icons.add_card,
                                  inputType: TextInputType.text,
                                  maxLines: 1,
                                  controller: panController,
                                  validator: (value) {
                                    if (value?.length != 10) {
                                      return 'PAN Number must be of 10 digit';
                                    }
                                    return null;
                                  },
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
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF191919),
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kblacklight,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height: 35,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      color: kwhite,
                                                    ),
                                                    padding: EdgeInsets.all(8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.search,
                                                          color: kblack,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "Choose File",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: kblack,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kwhite,
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
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF191919),
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kblacklight,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height: 35,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      color: kwhite,
                                                    ),
                                                    padding: EdgeInsets.all(8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.search,
                                                          color: kblack,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          "Choose File",
                                                          style:
                                                              GoogleFonts.lato(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: kblack,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kwhite,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.height20,
                                                  ),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: kyellow),
                                                      ),
                                                      height:
                                                          Dimensions.height20 *
                                                              4,
                                                      width: 150,
                                                      child: Image(
                                                        image: FileImage(
                                                            panImage!),
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
                                  labelText: 'Address',
                                  ontap: () {},
                                  hintlText: "Enter your full Address",
                                  icon: Icons.edit,
                                  inputType: TextInputType.name,
                                  maxLines: 1,
                                  controller: addressController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'User Name Required';
                                    }
                                    return null;
                                  },
                                ),
                                textField(
                                  labelText: 'District',
                                  ontap: () {},
                                  hintlText: "Enter your District name",
                                  icon: Icons.place_outlined,
                                  inputType: TextInputType.name,
                                  maxLines: 1,
                                  controller: districtController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'User Name Required';
                                    }
                                    return null;
                                  },
                                ),
                                textField(
                                  labelText: 'City',
                                  ontap: () {},
                                  hintlText: "Enter your City name",
                                  icon: Icons.location_city_outlined,
                                  inputType: TextInputType.name,
                                  maxLines: 1,
                                  controller: cityController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'User Name Required';
                                    }
                                    return null;
                                  },
                                ),
                                textField(
                                  labelText: 'PIN Number',
                                  ontap: () {},
                                  hintlText: "Enter your PIN number",
                                  icon: Icons.numbers,
                                  inputType: TextInputType.number,
                                  maxLines: 1,
                                  controller: pinController,
                                  validator: (value) {
                                    if (value?.length != 6) {
                                      return 'PIN must be of 6 digit';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: CustomButton(
                              text: "SUBMIT",
                              onPressed: () => storeData(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget textField({
    required String hintlText,
    required String labelText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
    required VoidCallback ontap,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        validator: validator,
        onTap: ontap,
        cursorColor: kwhite,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        style: GoogleFonts.roboto(
          color: klight,
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: kblacklight2,
                border: Border.all(
                  color: kblacklight,
                )),
            child: Icon(
              icon,
              size: 20,
              color: kblacklight,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: kblack,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: kgreen,
            ),
          ),
          labelText: labelText,
          labelStyle: GoogleFonts.roboto(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          hintText: hintlText,
          hintStyle: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            letterSpacing: 1,
            color: kwhite,
          ),
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Color(0xFF191919),
          filled: true,
        ),
      ),
    );
  }

  // store user data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      firstname: FirstnameController.text.trim(),
      lastname: LastnameController.text.trim(),
      // email: emailController.text.trim(),
      age: ageController.text.trim(),
      adhaar: adhaarController.text.trim(),
      pan: panController.text.trim(),
      address: addressController.text.trim(),
      district: districtController.text.trim(),
      city: cityController.text.trim(),
      pin: pinController.text.trim(),
      profilePic: "",
      createdAt: "",
      phoneNumber: "",
      uid: "",
      adhaarImage: "",
      panImage: "",
    );
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print('Validated!');
    } else {
      print("Not validated!");
    }
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
                            builder: (context) => const MainScreen(),
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
                            builder: (context) => const MainScreen(),
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
                (value) => ap.setSignIn().then((value) =>
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                        (route) => false)),
              );
        },
      );
    } else {
      showSnackBar(context, "Please upload your pan photo");
    }
  }
}
