import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_face_model.dart';
import '../utils/utils.dart';

class FaceProvider extends ChangeNotifier {
  String? _uid;
  String get uid => _uid!;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  UserFaceModel? _userFaceModel;
  UserFaceModel get userModel => _userFaceModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  void saveUserfaceDataToFirebase({
    required BuildContext context,
    required UserFaceModel userFaceModel,
    required File faceImage,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      await storeFaceFileToStorage("faceImage/$_uid", faceImage).then((value) {
        userFaceModel.faceImage = value;
      });
      _userFaceModel = userFaceModel;

      // uploading to database
      await _firebaseFirestore
          .collection("usersface")
          .doc(_uid)
          .set(userFaceModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> storeFaceFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future getDataFaceDataFromFirestore() async {
    await _firebaseFirestore
        .collection("usersface")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userFaceModel = UserFaceModel(
        faceImage: snapshot['faceImage'],
      );
    });
  }

  Future saveUserFaceDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_face_model", jsonEncode(userModel.toMap()));
  }

  Future getFaceDataFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_face_model") ?? '';
    _userFaceModel = UserFaceModel.fromMap(jsonDecode(data));

    notifyListeners();
  }
}
