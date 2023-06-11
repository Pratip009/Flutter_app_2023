// // ignore_for_file: use_build_context_synchronously

// import 'dart:developer';
// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_2023/screens/navpages/chat/screens/settings_screen.dart';
// import 'package:flutter_application_2023/utils/dimensions.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import '../../api/apis.dart';
// import '../../helper/dialogs.dart';

// //login screen -- implements google sign in or sign up feature for app
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool _isAnimate = false;

//   @override
//   void initState() {
//     super.initState();

//     //for auto triggering animation
//     Future.delayed(const Duration(milliseconds: 500), () {
//       setState(() => _isAnimate = true);
//     });
//   }

//   // handles google login button click
//   _handleGoogleBtnClick() {
//     //for showing progress bar
//     Dialogs.showProgressBar(context);

//     _signInWithGoogle().then((user) async {
//       //for hiding progress bar
//       Navigator.pop(context);

//       if (user != null) {
//         log('\nUser: ${user.user}');
//         log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

//         if ((await APIs.userExists())) {
//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (_) => const HomeScreen()));
//         } else {
//           await APIs.createUser().then((value) {
//             Navigator.pushReplacement(
//                 context, MaterialPageRoute(builder: (_) => const HomeScreen()));
//           });
//         }
//       }
//     });
//   }

//   Future<UserCredential?> _signInWithGoogle() async {
//     try {
//       await InternetAddress.lookup('google.com');
//       // Trigger the authentication flow
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//       // Obtain the auth details from the request
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;

//       // Create a new credential
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );

//       // Once signed in, return the UserCredential
//       return await APIs.auth.signInWithCredential(credential);
//     } catch (e) {
//       log('\n_signInWithGoogle: $e');
//       Dialogs.showSnackbar(context, 'Something Went Wrong (Check Internet!)');
//       return null;
//     }
//   }

//   //sign out function
//   // _signOut() async {
//   //   await FirebaseAuth.instance.signOut();
//   //   await GoogleSignIn().signOut();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     //initializing media query (for getting device screen size)
//     // mq = MediaQuery.of(context).size;

//     return Scaffold(
//       //app bar
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text('Welcome to We Chat'),
//       ),

//       //body
//       body: Stack(children: [
//         //app logo
//         AnimatedPositioned(
//             top: Dimensions.screenHeight * .15,
//             right: _isAnimate
//                 ? Dimensions.screenWidth * .25
//                 : -Dimensions.screenWidth * .5,
//             width: Dimensions.screenWidth * .5,
//             duration: const Duration(seconds: 1),
//             child: Image.asset('assets/images/chat.png')),

//         //google login button
//         Positioned(
//             bottom: Dimensions.screenHeight * .15,
//             left: Dimensions.screenWidth * .05,
//             width: Dimensions.screenWidth * .9,
//             height: Dimensions.screenHeight * .06,
//             child: ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 223, 255, 187),
//                     shape: const StadiumBorder(),
//                     elevation: 1),
//                 onPressed: () {
//                   _handleGoogleBtnClick();
//                 },

//                 //google icon
//                 icon: Image.asset('assets/images/google.png',
//                     height: Dimensions.screenHeight * .03),

//                 //login with google label
//                 label: RichText(
//                   text: const TextSpan(
//                       style: TextStyle(color: Colors.black, fontSize: 16),
//                       children: [
//                         TextSpan(text: 'Login with '),
//                         TextSpan(
//                             text: 'Google',
//                             style: TextStyle(fontWeight: FontWeight.w500)),
//                       ]),
//                 ))),
//       ]),
//     );
//   }
// }


// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_2023/provider/auth_provider.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/social_login/login_controller.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/social_register/register.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/components/componets.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/constants.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/helper/binding.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/network/local/cashhelper.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var uniqueIDController = TextEditingController();

  var passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    uniqueIDController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    final ap = Provider.of<AuthProvider>(context, listen: false);
    uniqueIDController.text = ap.userModel.unique;
    emailController.text = ap.userModel.email;
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (socialLoginController) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LOGIN",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Login To comunicate with friends",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: false,
                      child: defaultTextFormField(
                        controller: emailController,
                        text: "Email",
                        prefixIcon: const Icon(Icons.email),
                        inputtype: TextInputType.emailAddress,
                        onvalidate: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your email address';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultTextFormField(
                      controller: uniqueIDController,
                      text: "User ID",
                      prefixIcon: const Icon(Icons.password),
                      inputtype: TextInputType.text,
                      onvalidate: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter your User ID';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultTextFormFieldForPassword(
                      controller: passwordController,
                      text: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      inputtype: TextInputType.visiblePassword,
                      onvalidate: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter password';
                        }
                        return null;
                      },
                      obscure: socialLoginController.showpassword,
                      suffixIcon: IconButton(
                        icon: socialLoginController.showpassword
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          socialLoginController.onObscurePassword();
                          print(socialLoginController.showpassword);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    socialLoginController.isloadingLogin
                        ? const Center(child: CircularProgressIndicator())
                        : defaultButton(
                            text: "Login",
                            isUppercase: true,
                            onpress: () async {
                              if (_formkey.currentState!.validate()) {
                                await socialLoginController.userlogin(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    uniqueID: uniqueIDController.text.trim());
                              }

                              if (socialLoginController.statusLoginMessage ==
                                  ToastStatus.Success) {
                                //NOTE: uId saved in login method
                                CashHelper.saveData(key: "uId", value: uId);
                                Get.off(const SocialLayout(),
                                    binding: Binding());
                              }

                            }),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                        ),
                        defaultTextButton(
                            onpress: () {
                              Get.to(const RegisterScreen());
                            },
                            text: "Register".toUpperCase()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
