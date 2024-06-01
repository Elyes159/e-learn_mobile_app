import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SoundQuestionForm extends StatefulWidget {
  @override
  _SoundQuestionFormState createState() => _SoundQuestionFormState();
}

class _SoundQuestionFormState extends State<SoundQuestionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _questionTextController = TextEditingController();
  TextEditingController _spokenWordController = TextEditingController();
  TextEditingController _option1Controller = TextEditingController();
  TextEditingController _option2Controller = TextEditingController();
  TextEditingController _option3Controller = TextEditingController();
  TextEditingController _option4Controller = TextEditingController();
  TextEditingController _chapterController = TextEditingController();
  TextEditingController _lessonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('question sonore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _chapterController,
                decoration: InputDecoration(labelText: 'Chapitre'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le chapitre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _lessonController,
                decoration: InputDecoration(labelText: 'Leçon'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer la leçon';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _questionTextController,
                decoration: InputDecoration(labelText: 'Texte de la question'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le texte de la question';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _spokenWordController,
                decoration: InputDecoration(labelText: 'Mot prononcé'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le mot prononcé';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              _buildOptionTextField(_option1Controller, 'Option 1'),
              SizedBox(height: 10),
              _buildOptionTextField(_option2Controller, 'Option 2'),
              SizedBox(height: 10),
              _buildOptionTextField(_option3Controller, 'Option 3'),
              SizedBox(height: 10),
              _buildOptionTextField(_option4Controller, 'Option 4'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Enregistrer la question dans la base de données
                    // Utilisez les valeurs des contrôleurs _questionTextController, _spokenWordController, _option1Controller, _option2Controller, ...
                    // Réinitialisez les contrôleurs après l'enregistrement réussi
                    final String chapter = _chapterController.text;
                    final String lesson = _lessonController.text;
                    final String questionText = _questionTextController.text;
                    final String spokenWord = _spokenWordController.text;
                    final List<String> options = [
                      _option1Controller.text,
                      _option2Controller.text,
                      _option3Controller.text,
                      _option4Controller.text,
                    ];
                    CollectionReference questionCollection = FirebaseFirestore
                        .instance
                        .collection('cours')
                        .doc(chapter)
                        .collection('lecons')
                        .doc(lesson)
                        .collection('questions');
                    QuerySnapshot questionSnapshot =
                        await questionCollection.get();
                    int numberOfQuestions = questionSnapshot.docs.length;
                    String nextQuestionName =
                        'question${numberOfQuestions + 1}';

                    FirebaseFirestore.instance
                        .collection('cours')
                        .doc(chapter)
                        .collection('lecons')
                        .doc(lesson)
                        .collection('questions')
                        .doc(nextQuestionName)
                        .set({
                      'questionText': questionText,
                      'spokenWord': spokenWord,
                      'options': options,
                    }).then((_) {
                      _formKey.currentState!.reset();
                      _chapterController.clear();
                      _lessonController.clear();
                      _questionTextController.clear();
                      _spokenWordController.clear();
                      _option1Controller.clear();
                      _option2Controller.clear();
                      _option3Controller.clear();
                      _option4Controller.clear();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Question sonore ajoutée avec succès'),
                      ));
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Erreur lors de l\'ajout de la question: $error'),
                      ));
                    });
                  }
                },
                child: Text('Ajouter la question'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTextField(
      TextEditingController controller, String labelText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Veuillez entrer une option';
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    _questionTextController.dispose();
    _spokenWordController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    _option4Controller.dispose();
    _chapterController.dispose();
    _lessonController.dispose();
    super.dispose();
  }
}
