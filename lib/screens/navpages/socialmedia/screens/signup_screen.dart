// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/resources/auth_methods.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/responsive/mobile_screen_layout.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/responsive/responsive_layout.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/responsive/web_screen_layout.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/screens/login_screen.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/utils/utils.dart';
import 'package:flutter_application_2023/widgets/constant.dart';
import 'package:flutter_application_2023/widgets/text_field_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/dimensions.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblacklight2,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Text(
                'Social Media',
                style: GoogleFonts.lobster(
                  color: kblacklight,
                  fontSize: 30,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: kblacklight,
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: const NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png'),
                          backgroundColor: kblacklight,
                        ),
                  Positioned(
                    bottom: 0,
                    left: 87,
                    child: InkWell(
                      onTap: selectImage,
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
                    // IconButton(
                    //   onPressed: selectImage,
                    //   icon: Icon(
                    //     Icons.add_a_photo,
                    //     color: kblacklight,
                    //   ),
                    // ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Enter your bio',
                textInputType: TextInputType.text,
                textEditingController: _bioController,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: kblacklight,
                  ),
                  child: !_isLoading
                      ? Text(
                          'Sign up',
                          style: TextStyle(
                              color: kblack, fontWeight: FontWeight.w600),
                        )
                      : CircularProgressIndicator(
                          color: kblacklight,
                        ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: knewwhite,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        ' Login.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: knewwhite),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
