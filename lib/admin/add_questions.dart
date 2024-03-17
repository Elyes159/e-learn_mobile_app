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

  @override
  void dispose() {
    // Libérer les contrôleurs de texte lorsqu'ils ne sont plus utilisés
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
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Récupérer les données du formulaire et ajouter la question
                String questionText = questionTextController.text;
                List<Option1> options = [
                  Option1(option1TextController.text, ''),
                  Option1(option2TextController.text, ''),
                  Option1(option3TextController.text, ''),
                  Option1(option4TextController.text, ''),
                ];
                String spokenWord = spokenWordController.text;

                // Ajouter la question en utilisant une fonction de rappel fournie par le parent
                // Par exemple, vous pouvez appeler une fonction de rappel fournie par ExConnaisLeconfive pour ajouter la question
                // exConnaisLeconfive.addSoundQuestion(questionText, options, spokenWord);
              },
              child: Text('Add Question'),
            ),
          ],
        ),
      ),
    );
  }
}
