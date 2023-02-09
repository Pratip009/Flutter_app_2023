// ignore_for_file: prefer_const_constructors, unused_field, sort_child_properties_last

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? _image;
  final imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              height: 500,
              width: double.infinity,
              child: Column(
                children: [
                  Text('Upload Image'),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(),
                    flex: 4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
