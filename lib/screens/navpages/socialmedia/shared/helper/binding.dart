import 'package:flutter_application_2023/screens/navpages/socialmedia/layout/layout_controller.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    //NOTE:  implement dependencies

    Get.lazyPut<SocialLayoutController>(() => SocialLayoutController());
  }
}