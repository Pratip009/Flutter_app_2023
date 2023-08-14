
import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/audiovideo/constants/app_constants.dart';
import 'package:flutter_application_2023/screens/navpages/audiovideo/constants/global_constants.dart';
import 'package:flutter_application_2023/screens/navpages/audiovideo/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: scafold_background,
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppConstants.background_image),
                  fit: BoxFit.fill)),
          child: AuthForm(authProvider.submitAuthForm)),
    );
  }
}
