import 'package:flutter/material.dart';

class ChapterButton extends StatelessWidget {
  final String chapterName;
  final Function onPressed;
  final double progressValue;
  final Color buttonColor;

  ChapterButton(
      this.chapterName, this.onPressed, this.progressValue, this.buttonColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      width: 350,
      child: ElevatedButton(
        onPressed: () {
          // Logique à exécuter lorsque le bouton du chapitre est pressé
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor, // Changer la couleur du bouton ici
          padding: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Column(
          children: [
            Text(chapterName),
            SizedBox(height: 10),
            LinearProgressIndicator(
              minHeight: 20,
              borderRadius: BorderRadius.circular(5),
              value: progressValue,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromARGB(255, 1, 214, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
