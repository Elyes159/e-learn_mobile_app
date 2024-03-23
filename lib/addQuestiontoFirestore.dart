import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pfe_1/constant/question.dart';

class SampleQuestionsWidget extends StatefulWidget {
  @override
  _SampleQuestionsWidgetState createState() => _SampleQuestionsWidgetState();
}

class _SampleQuestionsWidgetState extends State<SampleQuestionsWidget> {
  final List<dynamic> questions = [
    Question(
      "Quelle est la capitale de la France?",
      [
        Option1("Paris", "assets/paris.jpg"),
        Option1("Londres", "assets/londres.jpg"),
        Option1("Londres", "assets/londres.jpg"),
        Option1("Londres", "assets/londres.jpg"),
      ], // Liste d'options avec leurs images
      [false, false, false, false], // Liste d'options sélectionnées
      [true, false, false, false], // Liste d'options correctes
    ),
    TranslationQuestion(
      originalText: 'Bonjour',
      correctTranslation: 'Hello',
      userTranslationn: '',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'The quick brown fox jumps over the lazy dog',
      questionText: 'Arrange the words to form a sentence:',
      additionalWords: [
        'The',
        'quick',
        'brown',
        'jumps',
      ],
      selectedWordOrder: [],
      questionLanguage: 'English',
    ),
    SoundQuestion(
      questionText: 'What is the sound of a cat?',
      options: [
        Option1('Meow', 'assets/cat_sound.png'),
        Option1('Woof', 'assets/dog_sound.png'),
        Option1('Moo', 'assets/cow_sound.png'),
        Option1('Oink', 'assets/pig_sound.png'),
      ],
      spokenWord: 'Meow',
      selectedWord: '',
    ),
    TextQuestion(
      "Quelle est la capitale de la France?",
      [
        Option1("Paris", "assets/paris.jpg"),
        Option1("Paris", "assets/paris.jpg"),
        Option1("Paris", "assets/paris.jpg"),
        Option1("Paris", "assets/paris.jpg"),
      ], // Liste d'options avec leurs images
      [false, false, false, false], // Liste d'options sélectionnées
      [true, false, false, false], // Liste d'options correctes
    ),
  ];

  @override
  void initState() {
    super.initState();
    addQuestionsToFirestore('cours', 'bonjour', '1');
  }

  void addQuestionsToFirestore(
      String cours, String chapter, String leconId) async {
    CollectionReference questionsCollection = FirebaseFirestore.instance
        .collection(cours)
        .doc(chapter)
        .collection('lecons')
        .doc('lecon$leconId') // Utilisation de l'argument leconId
        .collection('questions');

    QuerySnapshot questionSnapshot = await questionsCollection.get();
    int numberOfQuestions = questionSnapshot.docs.length;
    String nextQuestionName = 'question${numberOfQuestions + 1}';
    try {
      // Obtenez une référence à la collection "questions" dans Firestore
      CollectionReference questionsCollection = FirebaseFirestore.instance
          .collection(cours)
          .doc(chapter)
          .collection('lecons')
          .doc('lecon$leconId') // Utilisation de l'argument leconId
          .collection('questions');

      // Parcourez chaque question dans la liste et ajoutez-la à Firestore
      for (var question in questions) {
        if (question is Question) {
          // Si la question est de type Question
          await questionsCollection.doc(nextQuestionName).set({
            'type': 'Question',
            'questionText': question.questionText,
            'options': question.options
                .map((option) => {
                      'text': option.text,
                      'imagePath': option.imagePath,
                    })
                .toList(),
            'selectedOptions': question.selectedOptions,
            'correctOptions': question.correctOptions,
          });
        } else if (question is SoundQuestion) {
          // Si la question est de type SoundQuestion
          await questionsCollection.doc(nextQuestionName).set({
            'type': 'SoundQuestion',
            'questionText': question.questionText,
            'options': question.options
                .map((option) => {
                      'text': option.text,
                      'imagePath': option.imagePath,
                    })
                .toList(),
            'spokenWord': question.spokenWord,
            'selectedWord': question.selectedWord,
          });
        } else if (question is ScrambledWordsQuestion) {
          // Si la question est de type ScrambledWordsQuestion
          await questionsCollection.doc(nextQuestionName).set({
            'type': 'ScrambledWordsQuestion',
            'questionText': question.questionText,
            'correctSentence': question.correctSentence,
            'selectedWords': question.selectedWords,
            'selectedWordOrder': question.selectedWordOrder,
            'additionalWords': question.additionalWords,
          });
        } else if (question is TranslationQuestion) {
          // Si la question est de type TranslationQuestion
          await questionsCollection.doc(nextQuestionName).set({
            'type': 'TranslationQuestion',
            'originalText': question.originalText,
            'correctTranslation': question.correctTranslation,
            'userTranslationn': question.userTranslationn,
          });
        } else if (question is TextQuestion) {
          // Si la question est de type TextQuestion
          await questionsCollection.doc(nextQuestionName).set({
            'type': 'TextQuestion',
            'questionText': question.questionText,
            'options': question.options
                .map((option) => {
                      'text': option.text,
                      'imagePath': option.imagePath,
                    })
                .toList(),
            'selectedOptions': question.selectedOptions,
            'correctOptions': question.correctOptions,
          });
        }
        numberOfQuestions++; // Incrémente le nombre de questions ajoutées
        nextQuestionName =
            'question${numberOfQuestions}'; // Met à jour le nom de la prochaine question
      }

      print('Toutes les questions ont été ajoutées à Firestore avec succès');
    } catch (e) {
      print('Erreur lors de l\'ajout des questions à Firestore : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sample Questions'),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          if (question is TranslationQuestion) {
            return ListTile(
              title: Text('Translation Question: ${question.originalText}'),
              subtitle:
                  Text('Correct Translation: ${question.correctTranslation}'),
            );
          } else if (question is ScrambledWordsQuestion) {
            return ListTile(
              title: Text('Scrambled Words Question: ${question.questionText}'),
              subtitle: Text('Correct Sentence: ${question.correctSentence}'),
            );
          } else if (question is SoundQuestion) {
            return ListTile(
              title: Text('Sound Question: ${question.questionText}'),
              subtitle: Text('Spoken Word: ${question.spokenWord}'),
            );
          } else if (question is TextQuestion) {
            return ListTile(
              title: Text('Text Question: ${question.questionText}'),
              subtitle: Text(
                  'Options: ${question.options.map((option) => option.text).join(', ')}'),
            );
          } else {
            return Container(); // Placeholder for other question types
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed("login");
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
