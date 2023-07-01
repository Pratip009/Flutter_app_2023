// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';

// import 'Routes/generated_routes.dart';

// Future<void> main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   final AppRouter _appRouter = AppRouter();

//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: const Color.fromRGBO(4, 123, 213, 1),
//   ));

//   runApp(
//     MaterialApp(
//       title: 'Easy Market',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: const Color.fromRGBO(4, 123, 213, 1),
//         fontFamily: 'Lora', colorScheme: ColorScheme.light(
//           primary: const Color.fromRGBO(4, 123, 213, 1),
//         ).copyWith(secondary: const Color.fromRGBO(4, 123, 213, 1)),
//       ),
//       onGenerateRoute: _appRouter.onGenerateRoute,
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/ecommerce/Routes/generated_routes.dart';

void main() => runApp(SearchScreen());

class SearchScreen extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(4, 123, 213, 1),
        fontFamily: 'Lora',
        colorScheme: ColorScheme.light(
          primary: const Color.fromRGBO(4, 123, 213, 1),
        ).copyWith(secondary: const Color.fromRGBO(4, 123, 213, 1)),
      ),
      onGenerateRoute: _appRouter.onGenerateRoute,
      
    );
  }
}
