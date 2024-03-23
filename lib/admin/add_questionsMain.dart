import 'package:flutter/material.dart';
import 'package:pfe_1/admin/Add_Questions/add_questions.dart';
import 'package:pfe_1/admin/Add_Questions/add_scrambled.dart';
import 'package:pfe_1/admin/Add_Questions/add_sound.dart';
import 'package:pfe_1/admin/Add_Questions/add_textQuestion.dart';
import 'package:pfe_1/admin/Add_Questions/add_translation.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sélectionner un type de question'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddQuestionForm()),
                );
              },
              child: Text('Ajouter une question'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScrambledWordsQuestionForm()),
                );
              },
              child: Text('Question de mots mélangés'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SoundQuestionForm()),
                );
              },
              child: Text('Question sonore'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TextQuestionForm()),
                );
              },
              child: Text('Question de texte'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TranslationQuestionForm()),
                );
              },
              child: Text('Question de traduction'),
            ),
          ],
        ),
      ),
    );
  }
}
