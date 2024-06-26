import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/audiovideo/ui/screens/root_screen.dart';
import 'package:flutter_application_2023/screens/navpages/audiovideo/video_call.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';
import '../ui/screens/onboarding_screen.dart';

class AuthProvider extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isloading = false;

  Future signInFunction(BuildContext context) async {
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return;
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);

    DocumentSnapshot userExist = await _firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .get();

    if (userExist.exists) {
      log("User Already Exists in Database");
    } else {
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': userCredential.user!.email,
        'name': userCredential.user!.displayName,
        'image': userCredential.user!.photoURL,
        'uid': userCredential.user!.uid,
        'date': DateTime.now(),
      });
    }

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const VideoCall()),
            (route) => false);
  }
  Future<Widget> userSignedIn() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return RootScreen( index: 0,);
    } else {
      return const OnBoardingScreen();
    }
  }
  void submitAuthForm(String email, String password, String username,
      File image, bool isLogin, BuildContext context) async {
    UserCredential authResult;

    try {
        isloading = true;
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .get()
            .then((value){ authResult.user!.updateDisplayName(value['name']);
        authResult.user!.updatePhotoURL(value['image']);
        });

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const VideoCall()),
                (route) => false);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        authResult.user!.updateDisplayName(username);
        final ref = FirebaseStorage.instance
            .ref()
            .child('image')
            .child(authResult.user!.uid + '.jpg');

        await ref.putFile(image);


        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user?.uid)
            .set({
          'email': email,
          'uid': authResult.user!.uid ,
          'date': DateTime.now(),
          'name': username,
          // 'password': password,
          'image': url,
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const VideoCall()),
                (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      String message = "error Occurred";

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ));
      isloading = false;
    } catch (e) {
      print(e);
      isloading = false;

    }
  }
  Future logOut(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await _auth.signOut().then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => OnBoardingScreen()));
      });
    } catch (e) {
      print("error");
    }
  }
}