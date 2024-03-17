import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pfe_1/constant/question.dart';

class AddSoundQuestionForm extends StatefulWidget {
  @override
  _AddSoundQuestionFormState createState() => _AddSoundQuestionFormState();
}

class _AddSoundQuestionFormState extends State<AddSoundQuestionForm> {
  // Contrôleurs de texte pour les champs de saisie
  TextEditingController questionTextController = TextEditingController();
  TextEditingController option1TextController = TextEditingController();
  TextEditingController option2TextController = TextEditingController();
  TextEditingController option3TextController = TextEditingController();
  TextEditingController option4TextController = TextEditingController();
  TextEditingController spokenWordController = TextEditingController();
  TextEditingController Chapitre_LeconController = TextEditingController();

  @override
  void dispose() {
    questionTextController.dispose();
    option1TextController.dispose();
    option2TextController.dispose();
    option3TextController.dispose();
    option4TextController.dispose();
    spokenWordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Sound Question'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: questionTextController,
              decoration: InputDecoration(labelText: 'Question Text'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: option1TextController,
              decoration: InputDecoration(labelText: 'Option 1 Text'),
            ),
            TextField(
              controller: option2TextController,
              decoration: InputDecoration(labelText: 'Option 2 Text'),
            ),
            TextField(
              controller: option3TextController,
              decoration: InputDecoration(labelText: 'Option 3 Text'),
            ),
            TextField(
              controller: option4TextController,
              decoration: InputDecoration(labelText: 'Option 4 Text'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: spokenWordController,
              decoration: InputDecoration(labelText: 'Spoken Word'),
            ),
            TextField(
              controller: Chapitre_LeconController,
              decoration: InputDecoration(
                  labelText:
                      'ecris sous la forme suivante : chapitre/lecon<Numero de lecon>'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Récupérer les données du formulaire
                String questionText = questionTextController.text;
                List<Option1> options = [
                  Option1(option1TextController.text, ''),
                  Option1(option2TextController.text, ''),
                  Option1(option3TextController.text, ''),
                  Option1(option4TextController.text, ''),
                ];
                String spokenWord = spokenWordController.text;

                // Enregistrer les données dans Firestore
                try {
                  // Obtenir une référence à la collection "admin" dans Firestore
                  CollectionReference adminCollection = FirebaseFirestore
                      .instance
                      .collection('admin')
                      .doc()
                      .collection("Question_added");

                  // Ajouter un nouveau document avec les données du formulaire
                  await adminCollection.add({
                    'chapitre_lecon': Chapitre_LeconController.text,
                    'questionText': questionText,
                    'options': options
                        .map((option) => {
                              'text': option.text,
                              'imagePath': option.imagePath,
                            })
                        .toList(),
                    'spokenWord': spokenWord,
                  });
                } catch (e) {
                  // Gérer les erreurs éventuelles
                  print('Erreur lors de l\'enregistrement des données : $e');
                }
              },
              child: Text('Add Question'),
            ),
          ],
        ),
      ),
    );
  }
}
