import 'dart:io';
import 'package:flutter/material.dart';

class MyImageWidget extends StatelessWidget {
  final String imagePath;

  const MyImageWidget({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.file(File(imagePath));
  }
}
