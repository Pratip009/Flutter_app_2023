
import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/model/user_details_model.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/resources/cloudfirestore_methods.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel userDetails;

  UserDetailsProvider()
      : userDetails = UserDetailsModel(name: "Loading", address: "Loading");

  Future getData() async {
    userDetails = await CloudFirestoreClass().getNameAndAddress();
    notifyListeners();
  }
}
