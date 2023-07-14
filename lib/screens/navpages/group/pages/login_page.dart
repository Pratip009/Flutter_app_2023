
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/group/pages/home_page.dart';
import 'package:flutter_application_2023/screens/navpages/group/pages/register_page.dart';
import 'package:flutter_application_2023/screens/navpages/group/service/auth_service.dart';
import 'package:flutter_application_2023/screens/navpages/group/widgets/widgets.dart';


import '../helper/helper_function.dart';
import '../service/database_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String email = " ";
  String password = " ";
  bool _isLoading = false;
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: (_isLoading)
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Groupie",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Login now to see what they are talking",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        Image.asset("assets/login.png"),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: "Email",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).colorScheme.secondary,
                              )),
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                              labelText: "Password",
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).colorScheme.secondary,
                              )),
                          onChanged: ((value) {
                            setState(() {
                              password = value;
                            });
                          }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                login();
                              },
                              child: Text("Login")),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text.rich(
                          TextSpan(text: "Don't have an account?", children: [
                            TextSpan(
                                text: " Register Here",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    nextScreenReplace(context, RegisterPage());
                                  },
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 14))
                          ]),
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        )
                      ],
                    )),
              ),
            ),
    );
  }

  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .loginWithUserNameandPassword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(email);

          // saving the values to our shared preferences
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(snapshot.docs[0]['userName']);
          
          if (snapshot.docs[0]['profilePic']!="") {
              await HelperFunctions.saveUserProfilePicFromSF(
              snapshot.docs[0]['profilePic']);
          }
          
        
          nextScreenReplace(context, const HomePage());
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
