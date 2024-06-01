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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 200.0,
              color: Color(0xFF3DB2FF),
              child: Center(
                child: Text(
                  'Sélectionner un type de question',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3DB2FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddQuestionForm()),
                      );
                    },
                    child: Text('question d\'image'),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3DB2FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScrambledWordsQuestionForm()),
                      );
                    },
                    child: Text('Question de mots mélangés'),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3DB2FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SoundQuestionForm()),
                      );
                    },
                    child: Text('Question sonore'),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3DB2FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TextQuestionForm()),
                      );
                    },
                    child: Text('Question de texte'),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3DB2FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      textStyle: TextStyle(fontSize: 16),
                    ),
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
          ],
        ),
      ),
    );
  }
}
