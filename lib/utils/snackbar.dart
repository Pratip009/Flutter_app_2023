import 'package:flutter/material.dart';

void showSnackBar(
    {required BuildContext context,
    required String content,
    required Color color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}
// void showSnackbar(context, color, message) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(
//         message,
//         style: const TextStyle(fontSize: 14),
//       ),
//       backgroundColor: color,
//       duration: const Duration(seconds: 2),
//       action: SnackBarAction(
//         label: "OK",
//         onPressed: () {},
//         textColor: Colors.white,
//       ),
//     ),
//   );
// }