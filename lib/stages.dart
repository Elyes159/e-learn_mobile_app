import 'package:flutter/material.dart';
import 'package:pfe_1/constant/chapitre_button.dart';

class StagesPage extends StatefulWidget {
  @override
  _StagesPageState createState() => _StagesPageState();
}

class _StagesPageState extends State<StagesPage> {
  PageController _pageController = PageController(initialPage: 0);
  double progressValue1 = 100;
  double progressValue2 = 100;
  double progressValue3 = 100;
  double progressValue4 = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stages'),
      ),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          ChapterButton('Chapitre 1', () {
            Navigator.pushNamed(context, 'chapitre1');
          }, progressValue1, Colors.black12),
          ChapterButton('Chapitre 2', () {
            print('Chapitre 2 pressé!');
          }, progressValue2, Colors.green),
          ChapterButton('Chapitre 3', () {
            print('Chapitre 3 pressé!');
          }, progressValue3, Colors.blue),
          ChapterButton('Chapitre 4', () {
            print('Chapitre 4 pressé!');
          }, progressValue4, Colors.white),
          // Ajoutez autant de boutons que nécessaire
        ],
      ),
    );
  }
}
