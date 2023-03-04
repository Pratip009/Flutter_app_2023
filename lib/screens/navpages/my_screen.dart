// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_2023/screens/navpages/profile_navigations/face_detection/face_detector_page.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Detector'),
      ),
      body: _body(),
    );
  }

  Widget _body() => Center(
        child: SizedBox(
          width: 350,
          height: 80,
          child: OutlinedButton(
            style: ButtonStyle(
              side: MaterialStatePropertyAll(
                const BorderSide(
                  color: Colors.blue,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FaceDetectorPage())),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                _buildIconWidget(
                  Icons.arrow_forward_ios,
                ),
                Text(
                  'Go to face detector',
                  style: TextStyle(fontSize: 20),
                ),
                _buildIconWidget(
                  Icons.arrow_back_ios,
                ),
              ],
            ),
          ),
        ),
      );
}

Widget _buildIconWidget(final IconData icon) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Icon(
        icon,
        size: 24,
      ),
    );
