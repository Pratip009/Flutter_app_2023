// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_2023/provider/auth_provider.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/modules/social_register/register_controller.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/components/componets.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/constants.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/helper/binding.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/network/local/cashhelper.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var uniqueIDController = TextEditingController();

  var passwordController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    uniqueIDController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  @override
  void initState() {
    super.initState();
    final ap = Provider.of<AuthProvider>(context, listen: false);
    nameController.text =
        "${ap.userModel.firstname}" "\u{00A0}" "${ap.userModel.lastname}";
    uniqueIDController.text = ap.userModel.unique;
    emailController.text = ap.userModel.email;
    phoneController.text = ap.userModel.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (socialRegisterController) => Center(
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
                      "REGISTER",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "REGISTER To Comunicate with friends",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                      controller: nameController,
                      text: "User Name",
                      prefixIcon: const Icon(Icons.person),
                      inputtype: TextInputType.name,
                      onvalidate: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter your User Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                      controller: uniqueIDController,
                      text: "User ID",
                      prefixIcon: const Icon(Icons.password),
                      inputtype: TextInputType.text,
                      onvalidate: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter your User Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: false,
                      child: defaultTextFormField(
                        controller: emailController,
                        text: "Email",
                        prefixIcon: const Icon(Icons.email_outlined),
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
                    defaultTextFormFieldForPassword(
                      controller: passwordController,
                      text: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      inputtype: TextInputType.emailAddress,
                      onvalidate: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter password';
                        }
                        return null;
                      },
                      obscure: socialRegisterController.showpassword,
                      suffixIcon: IconButton(
                        icon: socialRegisterController.showpassword
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          socialRegisterController.onObscurePassword();
                          print(socialRegisterController.showpassword);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: false,
                      child: defaultTextFormField(
                        controller: phoneController,
                        text: "Phone Number",
                        prefixIcon: const Icon(Icons.phone),
                        inputtype: TextInputType.phone,
                        onvalidate: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your Phone Number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    socialRegisterController.isloadingRegister!
                        ? const Center(child: CircularProgressIndicator())
                        : defaultButton(
                            text: "REGITSER",
                            isUppercase: true,
                            onpress: () async {
                              // NOTE : GET STATUS OF  register method
                              if (_formkey.currentState!.validate()) {
                                await socialRegisterController.registerUser(
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    phone: phoneController.text.trim(),
                                    uniqueID: uniqueIDController.text.trim());
                              }
                              print(
                                  "status firestore ${socialRegisterController.isSuccessRegisterToFireStore}");

                              if (socialRegisterController
                                      .isSuccessRegisterToFireStore &&
                                  socialRegisterController.statusLoginMessage ==
                                      ToastStatus.Success) {
                                //NOTE: uId saved in login method
                                CashHelper.saveData(key: "uId", value: uId);
                                Get.off(const SocialLayout(),
                                    binding: Binding());
                              }
                              showToast(
                                  message:
                                      socialRegisterController.statusMessage,
                                  status: socialRegisterController
                                      .statusLoginMessage!);
                            }),
                    const SizedBox(
                      height: 10,
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
