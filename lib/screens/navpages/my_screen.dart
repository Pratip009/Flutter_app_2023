import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/user_face_model.dart';
import '../../provider/face_provider.dart';
import '../../utils/dimensions.dart';
import '../../utils/utils.dart';
import '../../widgets/constant.dart';
import 'main_screen.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  File? faceImage;
  void selectFaceImage() async {
    faceImage = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => selectFaceImage(),
                  child: faceImage == null
                      ? Stack(
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: kred,
                              size: 50,
                            ),
                          ],
                        )
                      : Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  color: kgreen,
                                  size: 50,
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: kyellow)),
                                  height: Dimensions.height20 * 4,
                                  width: 150,
                                  child: Image(
                                    image: FileImage(faceImage!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            ElevatedButton(
                onPressed: () {
                  storeFaceData();
                },
                child: Text('Submit')),
          ],
        ),
      ),
    );
  }

  void storeFaceData() async {
    final fp = Provider.of<FaceProvider>(context, listen: false);
    UserFaceModel userFaceModel = UserFaceModel(
      faceImage: "",
    );
    if (faceImage != null) {
      fp.saveUserfaceDataToFirebase(
        context: context,
        userFaceModel: userFaceModel,
        faceImage: faceImage!,
        onSuccess: () {
          var snackBar = const SnackBar(
              content: Text(
            'Thank you ! you are now a verified user.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const MyScreen(),
              ),
              (route) => false);
        },
      );
    } else {
      showSnackBar(context, "Please upload your adhaar photo");
    }
  }
  // if (faceImage != null) {
  //     ap.saveUserfaceDataToFirebase(
  //       context: context,
  //       userModel: userModel,
  //       adhaarImage: adhaarImage!,
  //       onSuccess: () {
  //         ap.saveUserDataToSP().then(
  //               (value) => ap.setSignIn().then(
  //                     (value) => Navigator.pushAndRemoveUntil(
  //                         context,
  //                         MaterialPageRoute(
  //                           builder: (context) => const MainScreen(),
  //                         ),
  //                         (route) => false),
  //                   ),
  //             );
  //       },
  //     );
  //   } else {
  //     showSnackBar(context, "Please upload your adhaar photo");
  //   }
}
