// ignore_for_file: avoid_print

import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
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

final ValueNotifier<int> counter = ValueNotifier(0);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var uniqueIDController = TextEditingController();

  var passwordController = TextEditingController();
  int _counter = 0;

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

  void _incrementCounter() {
    counter.value++;
  }

  // Future<void> _loadCounter() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _counter = (prefs.getInt('counter') ?? 0);
  //   });
  // }

  //Incrementing counter after click
  // Future<void> _incrementCounter() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _counter = (prefs.getInt('counter') ?? 0) + 1;
  //     prefs.setInt('counter', _counter);
  //   });
  // }

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

                              showToast(
                                  message: socialLoginController.statusMessage,
                                  status: socialLoginController
                                      .statusLoginMessage!);
                              _incrementCounter();
                              print('$counter');
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
