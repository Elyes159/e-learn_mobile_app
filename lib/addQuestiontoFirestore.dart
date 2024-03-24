import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pfe_1/constant/question.dart';

class SampleQuestionsWidget extends StatefulWidget {
  @override
  _SampleQuestionsWidgetState createState() => _SampleQuestionsWidgetState();
}

class _SampleQuestionsWidgetState extends State<SampleQuestionsWidget> {
  final List<dynamic> questions = [
    ScrambledWordsQuestion(
      correctSentence: 'We don\'t wake up before eight o \'clock',
      questionText: 'Nous ne nous réveillons pas avant huit heures',
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'fr',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'We have to get ready to go to work',
      questionText: 'Nous devons nous préparer pour aller au travail',
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'fr',
    ),
    TranslationQuestion(
        originalText: "réveillez",
        correctTranslation: "to wake up",
        userTranslationn: ""),
    TextQuestion(
      "Les enfants doivent se _____ tôt",
      [
        Option1("couchent", "assets/paris.jpg"),
        Option1("couchez", "assets/paris.jpg"),
        Option1("coucher", "assets/paris.jpg"),
        Option1("couchons", "assets/paris.jpg"),
      ], // Liste d'options avec leurs images
      [false, false, false, false], // Liste d'options sélectionnées
      [false, false, true, false], // Liste d'options correctes
    ),
    ScrambledWordsQuestion(
      correctSentence: "We read always before sleeping",
      questionText: "Nous lisons toujours avant de dormir",
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'fr',
    ),
    Question(
      "Quelle est la capitale de la France?",
      [
        Option1("la soleil", "assets/soleil.png"),
        Option1("les dents", "assets/dentier.png"),
        Option1("l'alarme", "assets/alarme.png"),
        Option1("Le train", "assets/train.png"),
      ], // Liste d'options avec leurs images
      [false, false, false, false], // Liste d'options sélectionnées
      [false, true, false, false], // Liste d'options correctes
    ),
    ScrambledWordsQuestion(
      correctSentence: "Do you always get up at six o'clock in the morning?",
      questionText: "Vous vous levez toujours à six heures du matin?",
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'fr',
    ),
    ScrambledWordsQuestion(
      correctSentence: "Do they read a lot?",
      questionText: "Est-ce qu'ils lisent beaucoup ?",
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'fr',
    ),
    ScrambledWordsQuestion(
      correctSentence: "What is she doing today?",
      questionText: "Qu'est-ce qu'elle fait ajourd'hui?",
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'fr',
    ),
    ScrambledWordsQuestion(
      correctSentence: "What do they read",
      questionText: "Qu'est-ce qu'ils lisent?",
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'fr',
    ),
    ScrambledWordsQuestion(
      correctSentence: "We take a walk together every day",
      questionText: "Nous nous promenons ensemble tous les jours",
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'fr',
    ),
    ScrambledWordsQuestion(
      correctSentence: "Do you always take walks here?",
      questionText: "Vous vous promenez toujours ici ?",
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'fr',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'Do you often take walks in this park',
      questionText: "Vous vous promenez souvent dans ce parc ?",
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'fr',
    ),

    // SoundQuestion(
    //   questionText: 'What is the sound of a cat?',
    //   options: [
    //     Option1('Meow', 'assets/cat_sound.png'),
    //     Option1('Woof', 'assets/dog_sound.png'),
    //     Option1('Moo', 'assets/cow_sound.png'),
    //     Option1('Oink', 'assets/pig_sound.png'),
    //   ],
    //   spokenWord: 'Meow',
    //   selectedWord: '',
    // ),
    // TextQuestion(
    //   "Quelle est la capitale de la France?",
    //   [
    //     Option1("Paris", "assets/paris.jpg"),
    //     Option1("Paris", "assets/paris.jpg"),
    //     Option1("Paris", "assets/paris.jpg"),
    //     Option1("Paris", "assets/paris.jpg"),
    //   ], // Liste d'options avec leurs images
    //   [false, false, false, false], // Liste d'options sélectionnées
    //   [true, false, false, false], // Liste d'options correctes
    // ),
  ];

  @override
  void initState() {
    super.initState();
    addQuestionsToFirestore('cours', 'je_connais', '6');
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
            'questionLanguage': question.questionLanguage,
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
            'question${numberOfQuestions + 1}'; // Met à jour le nom de la prochaine question
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
