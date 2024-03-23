import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScrambledWordsQuestionForm extends StatefulWidget {
  @override
  _ScrambledWordsQuestionFormState createState() =>
      _ScrambledWordsQuestionFormState();
}

class _ScrambledWordsQuestionFormState
    extends State<ScrambledWordsQuestionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _questionTextController = TextEditingController();
  TextEditingController _correctSentenceController = TextEditingController();
  TextEditingController _additionalWordsController = TextEditingController();
  TextEditingController _selectedWordOrderController = TextEditingController();
  TextEditingController _chapterController = TextEditingController();
  TextEditingController _lessonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une question de mots mélangés'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
                controller: _correctSentenceController,
                decoration: InputDecoration(labelText: 'Phrase correcte'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer la phrase correcte';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _additionalWordsController,
                decoration: InputDecoration(
                    labelText:
                        'Mots supplémentaires (séparés par des virgules)'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _selectedWordOrderController,
                decoration: InputDecoration(
                    labelText:
                        'Ordre des mots sélectionnés (séparés par des espaces)'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer l\'ordre des mots sélectionnés';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final String questionText = _questionTextController.text;
                    final String correctSentence =
                        _correctSentenceController.text;
                    final List<String> additionalWords =
                        _additionalWordsController.text.split(',');
                    final List<String> selectedWordOrder =
                        _selectedWordOrderController.text.split(' ');
                    final String chapter = _chapterController.text;
                    final String lesson = _lessonController.text;
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
                      'correctSentence': correctSentence,
                      'additionalWords': additionalWords,
                      'selectedWordOrder': selectedWordOrder,
                    }).then((_) {
                      _formKey.currentState!.reset();
                      _questionTextController.clear();
                      _correctSentenceController.clear();
                      _additionalWordsController.clear();
                      _selectedWordOrderController.clear();
                      _chapterController.clear();
                      _lessonController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Question de mots mélangés ajoutée avec succès'),
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

  @override
  void dispose() {
    _questionTextController.dispose();
    _correctSentenceController.dispose();
    _additionalWordsController.dispose();
    _selectedWordOrderController.dispose();
    _chapterController.dispose();
    _lessonController.dispose();
    super.dispose();
  }
}
