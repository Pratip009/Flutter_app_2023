import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/cloud_store_data/cloud_data_management.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthentication {
  final FacebookAuth _facebookLogin = FacebookAuth.instance;
  final CloudDataStore _cloudDataStore = CloudDataStore();

  Future<bool> facebookLogIn() async {
    try {
      if (await _facebookLogin.accessToken == null) {
        final LoginResult _fbLogInResult = await _facebookLogin.login();

        if (_fbLogInResult.status == LoginStatus.success) {
          final OAuthCredential _oAuthCredential =
          FacebookAuthProvider.credential(
              _fbLogInResult.accessToken!.token);

          if (FirebaseAuth.instance.currentUser != null)
            FirebaseAuth.instance.signOut();

          final UserCredential fbUser = await FirebaseAuth.instance
              .signInWithCredential(_oAuthCredential);

          print(
              'Fb Log In Info: ${fbUser.user}    ${fbUser.additionalUserInfo}');

          await _cloudDataStore.dataStoreForConsumers(fbUser.user!.email.toString());

          return true;
        }
        return false;
      } else {
        print('Already Fb Logged In');
        await logOut();
        return false;
      }
    } catch (e) {
      print('Facebook Log In Error: ${e.toString()}');
      return false;
    }
  }

  Future<bool> logOut() async {
    try {
      print('Facebook Log Out');
      if (await _facebookLogin.accessToken != null) {
        await _facebookLogin.logOut();
        await FirebaseAuth.instance.signOut();
        return true;
      }
      return false;
    } catch (e) {
      print('Facebook Log out Error: ${e.toString()}');
      return false;
    }
  }
}
