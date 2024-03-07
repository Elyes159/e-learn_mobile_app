import 'package:flutter/material.dart';

import '../../../../constant/question.dart';

class TranslationExercisePage extends StatefulWidget {
  final TranslationQuestion question;
  final VoidCallback onCorrectAnswer;

  TranslationExercisePage({
    required this.question,
    required this.onCorrectAnswer,
  });

  @override
  _TranslationExercisePageState createState() =>
      _TranslationExercisePageState();
}

class _TranslationExercisePageState extends State<TranslationExercisePage> {
  TextEditingController _translationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String correctTranslation = widget.question.correctTranslation;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.question.originalText,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _translationController,
            decoration: InputDecoration(
              hintText: 'Traduisez ici...',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              String userTranslation = _translationController.text.trim();
              bool isCorrect = userTranslation.toLowerCase() ==
                  correctTranslation.toLowerCase();

              if (isCorrect) {
                widget.onCorrectAnswer();
              } else {
                // Gérer la logique pour une réponse incorrecte si nécessaire
              }
            },
            child: Text('Vérifier la traduction'),
          ),
        ],
      ),
    );
  }
}
