import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TranslationQuestionForm extends StatefulWidget {
  @override
  _TranslationQuestionFormState createState() =>
      _TranslationQuestionFormState();
}

class _TranslationQuestionFormState extends State<TranslationQuestionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _originalTextController = TextEditingController();
  TextEditingController _correctTranslationController = TextEditingController();
  TextEditingController _chapterController = TextEditingController();
  TextEditingController _lessonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une question de traduction'),
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
                controller: _originalTextController,
                decoration: InputDecoration(labelText: 'Texte original'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le texte original';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _correctTranslationController,
                decoration: InputDecoration(labelText: 'Traduction correcte'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer la traduction correcte';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Enregistrer la question dans la base de données
                    // Ici, vous devrez envoyer les données au backend ou à Firestore
                    // Utilisez les valeurs des contrôleurs _originalTextController, _correctTranslationController
                    // Réinitialisez les contrôleurs après l'enregistrement réussi
                    final String chapter = _chapterController.text;
                    final String lesson = _lessonController.text;
                    final String originalText = _originalTextController.text;
                    final String correctTranslation =
                        _correctTranslationController.text;
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

                    // Envoyer les données à Firestore
                    FirebaseFirestore.instance
                        .collection('cours')
                        .doc(chapter)
                        .collection('lecons')
                        .doc(lesson)
                        .collection('questions')
                        .doc(nextQuestionName)
                        .set({
                      'originalText': originalText,
                      'correctTranslation': correctTranslation,
                      'userTranslation':
                          '', // Champ userTranslation initialisé à une chaîne vide
                    }).then((_) {
                      _formKey.currentState!.reset();
                      _originalTextController.clear();
                      _correctTranslationController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Question de traduction ajoutée avec succès'),
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
    _originalTextController.dispose();
    _correctTranslationController.dispose();
    _chapterController.dispose();
    _lessonController.dispose();
    super.dispose();
  }
}
