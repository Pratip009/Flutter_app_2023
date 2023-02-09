//height => 816.7272727272727
//width => 392.72727272727275

import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  //height
  static double height10 = screenHeight / 81.67272727272727;
  static double height20 = screenHeight / 40.836363636363635;
  static double height100 = screenHeight / 8.167272727272727;
  static double height120 = screenHeight / 3.2727272727272729166666666666667;

  //width

  static double width5 = screenWidth / 78.54545454545455;
  static double width10 = screenWidth / 39.272727272727275;
  static double width15 = screenWidth / 26.181818181818183333333333333333;
  static double width120 = screenHeight / 6.8060606060606058333333333333333;
}
