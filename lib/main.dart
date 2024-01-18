import 'package:flutter/material.dart';
import 'package:pfe_1/chapitre1/chapitre1.dart';
import 'package:pfe_1/ML/image_picker.dart';
import 'package:pfe_1/stages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImagePickerDemo(),
      routes: {
        'stages': (context) => StagesPage(),
        'chapitre1': (context) => Chapitre1(),
      },
    );
  }
}
