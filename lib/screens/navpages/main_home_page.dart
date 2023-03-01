import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Flutter App GoSpeedy"),
        actions: [
          IconButton(
            onPressed: () {
              ap.userSignOut().then(
                    (value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ),
                    ),
                  );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.purple,
              backgroundImage: NetworkImage(ap.userModel.profilePic),
              radius: 50,
            ),
            const SizedBox(height: 20),
            Text(ap.userModel.uid),
            Text(ap.userModel.name),
            Text(ap.userModel.phoneNumber),
            Text(ap.userModel.email),
            Text(ap.userModel.pan),
            Text(ap.userModel.adhaar),
            Text(ap.userModel.city),
            Text(ap.userModel.age),
            Text(ap.userModel.pin),
            Image(
              image: NetworkImage(ap.userModel.adhaarImage),
              height: 100,
              width: 200,
            ),
            Image(
              image: NetworkImage(ap.userModel.panImage),
              height: 100,
              width: 200,
            )
          ],
        ),
      ),
    );
  }
}
