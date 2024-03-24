import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pfe_1/constant/question.dart';

class SampleQuestionsWidget extends StatefulWidget {
  @override
  _SampleQuestionsWidgetState createState() => _SampleQuestionsWidgetState();
}

class _SampleQuestionsWidgetState extends State<SampleQuestionsWidget> {
  final List<dynamic> questions = [
    // ScrambledWordsQuestion(
    //   correctSentence: 'We don\'t wake up before eight o \'clock',
    //   questionText: 'Nous ne nous réveillons pas avant huit heures',
    //   additionalWords: [],
    //   selectedWordOrder: [],
    //   questionLanguage: 'fr',
    // ),
    // ScrambledWordsQuestion(
    //   correctSentence: 'We have to get ready to go to work',
    //   questionText: 'Nous devons nous préparer pour aller au travail',
    //   additionalWords: [],
    //   selectedWordOrder: [],
    //   questionLanguage: 'fr',
    // ),
    // TranslationQuestion(
    //     originalText: "réveillez",
    //     correctTranslation: "to wake up",
    //     userTranslationn: ""),
    // TextQuestion(
    //   "Les enfants doivent se _____ tôt",
    //   [
    //     Option1("couchent", "assets/paris.jpg"),
    //     Option1("couchez", "assets/paris.jpg"),
    //     Option1("coucher", "assets/paris.jpg"),
    //     Option1("couchons", "assets/paris.jpg"),
    //   ], // Liste d'options avec leurs images
    //   [false, false, false, false], // Liste d'options sélectionnées
    //   [false, false, true, false], // Liste d'options correctes
    // ),
    // ScrambledWordsQuestion(
    //   correctSentence: "We read always before sleeping",
    //   questionText: "Nous lisons toujours avant de dormir",
    //   additionalWords: [],
    //   selectedWordOrder: [],
    //   questionLanguage: 'fr',
    // ),
    // Question(
    //   "Quelle est la capitale de la France?",
    //   [
    //     Option1("la soleil", "assets/soleil.png"),
    //     Option1("les dents", "assets/dentier.png"),
    //     Option1("l'alarme", "assets/alarme.png"),
    //     Option1("Le train", "assets/train.png"),
    //   ], // Liste d'options avec leurs images
    //   [false, false, false, false], // Liste d'options sélectionnées
    //   [false, true, false, false], // Liste d'options correctes
    // ),
    // TextQuestion(
    //   "Les enfants doivent se _____ les dents",
    //   [
    //     Option1("brosse", "assets/paris.jpg"),
    //     Option1("brossent", "assets/paris.jpg"),
    //     Option1("brosser", "assets/paris.jpg"),
    //   ], // Liste d'options avec leurs images
    //   [false, false, false], // Liste d'options sélectionnées
    //   [false, false, true], // Liste d'options correctes
    // ),
    // ScrambledWordsQuestion(
    //   correctSentence: "it's two o'clock",
    //   questionText: "Il est deux heures",
    //   additionalWords: ["hello"],
    //   selectedWordOrder: [],
    //   questionLanguage: 'fr',
    // ),
    // ScrambledWordsQuestion(
    //   correctSentence: "Je ne me léve pas aprés dix heures",
    //   questionText: "I don't get up after ten o'clock",
    //   additionalWords: [],
    //   selectedWordOrder: [],
    //   questionLanguage: 'en',
    // ),
    // ScrambledWordsQuestion(
    //   correctSentence: "I wake up at a quarter to nine.",
    //   questionText: "je me réveille à neuf heures moins le quart",
    //   additionalWords: [],
    //   selectedWordOrder: [],
    //   questionLanguage: 'fr',
    // ),
    // ScrambledWordsQuestion(
    //   correctSentence: "He does n't wake up before eleven o 'clock",
    //   questionText: "il ne se révéille pas avant onze heures",
    //   additionalWords: [],
    //   selectedWordOrder: [],
    //   questionLanguage: 'fr',
    // ),
    // ScrambledWordsQuestion(
    //   correctSentence: "brosser",
    //   questionText: "to brush",
    //   additionalWords: ["qu'est-ce que", "les courses"],
    //   selectedWordOrder: [],
    //   questionLanguage: 'fr',
    // ),
    // ScrambledWordsQuestion(
    //   correctSentence: "You 're not getting up",
    //   questionText: "Tu ne te lèves pas",
    //   additionalWords: [],
    //   selectedWordOrder: [],
    //   questionLanguage: 'fr',
    // ),

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
    // addQuestionsToFirestore('cours', 'je_connais', '7');
    // importAndTranslateQuestions();
  }

  Future<void> importAndTranslateQuestions() async {
    try {
      QuerySnapshot chapters =
          await FirebaseFirestore.instance.collection('cours').get();

      for (QueryDocumentSnapshot chapterDoc in chapters.docs) {
        String chapterId = chapterDoc.id;

        // Accéder à la sous-collection "lecons" pour chaque document dans "cours"
        QuerySnapshot lecons = await FirebaseFirestore.instance
            .collection('cours')
            .doc(chapterId)
            .collection('lecons')
            .get();

        // Parcourir les documents de la sous-collection "lecons"
        for (QueryDocumentSnapshot leconDoc in lecons.docs) {
          String leconId = leconDoc.id; // Obtenez l'ID du document "lecon"

          // Accéder à la collection "questions" pour chaque document dans "lecons"
          QuerySnapshot questions = await FirebaseFirestore.instance
              .collection('cours')
              .doc(chapterId)
              .collection('lecons')
              .doc(leconId)
              .collection('questions')
              .get();

          // Parcourir les documents de la collection "questions"
          for (QueryDocumentSnapshot questionDoc in questions.docs) {
            Map<String, dynamic>? questionData =
                questionDoc.data() as Map<String, dynamic>?;

            // Vérifier si le type de question est "ScrambledWordsQuestion"
            if (questionData != null &&
                questionData['type'] == 'ScrambledWordsQuestion') {
              // Ajouter le champ "ImagePath" au document
              print('Updating image path for ScrambledWordsQuestion...');
              await FirebaseFirestore.instance
                  .collection('cours')
                  .doc(chapterId)
                  .collection('lecons')
                  .doc(leconId)
                  .collection('questions')
                  .doc(questionDoc.id)
                  .update({'ImagePath': 'your_image_path_here'}).then((_) {
                print('Image path updated successfully!');
              }).catchError((error) {
                print('Error updating image path: $error');
              });
            }
          }
        }
      }
    } catch (e) {
      print('Error retrieving lessons: $e');
    }
  }

  void addQuestionsToFirestore(
      String cours, String chapter, String leconId) async {
    CollectionReference questionsCollection = FirebaseFirestore.instance
        .collection('cours')
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
