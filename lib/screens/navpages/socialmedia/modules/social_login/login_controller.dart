import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/components/componets.dart';
import 'package:flutter_application_2023/screens/navpages/socialmedia/shared/constants.dart';
import 'package:get/get.dart';


class LoginController extends GetxController {
  // NOTE: ---------------------   User Login--------------

  ToastStatus? _statusLoginMessage;
  ToastStatus? get statusLoginMessage => _statusLoginMessage;

  String? _statusMessage = "";
  String? get statusMessage => _statusMessage;

  bool _showpassword = true;
  bool get showpassword => _showpassword;

  bool _isloadingLogin = false;
  bool get isloadingLogin => _isloadingLogin;

  onObscurePassword() {
    _showpassword = !showpassword;
    update();
  }

  Future<void> userlogin(
      {required String email, required String password,required String uniqueID}) async {
    _isloadingLogin = true;
    update();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password, )
          .then((value) {
        uId = value.user!.uid;
        _statusLoginMessage = ToastStatus.Success;
        _statusMessage = "Logged In Successfully";
        _isloadingLogin = false;
        update();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _statusMessage = "No user found for that email.";
        _statusLoginMessage = ToastStatus.Error;
      } else if (e.code == 'wrong-password') {
        _statusMessage = "Wrong password provided for that user.";
        _statusLoginMessage = ToastStatus.Error;
      }
      _isloadingLogin = false;
      update();
    }
  }
}