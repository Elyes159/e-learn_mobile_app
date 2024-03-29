import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pfe_1/constant/question.dart';

class SampleQuestionsWidget extends StatefulWidget {
  @override
  _SampleQuestionsWidgetState createState() => _SampleQuestionsWidgetState();
}

//your_image_path_here
class _SampleQuestionsWidgetState extends State<SampleQuestionsWidget> {
  final List<dynamic> questions = [
    TextQuestion(
        "_'ai densé avec mon ami",
        [Option1("il", "assets/gateau.png"), Option1("j", "assets/gateau.png")],
        [false, false],
        [false, true]),
    TextQuestion("Tu ___ avec Paul et Marie?", [
      Option1("as joué", "assets/gateau.png"),
      Option1("a joué", "assets/gateau.png")
    ], [
      false,
      false
    ], [
      true,
      false
    ]),
    TextQuestion("il/elle ____", [
      Option1("a parlé", "assets/gateau.png"),
      Option1("ai parlé", "assets/gateau.png")
    ], [
      false,
      false
    ], [
      true,
      false
    ]),
    // houni wsolt
    ScrambledWordsQuestion(
      correctSentence: 'I had a good time with you',
      questionText: "J'ai passé un bon moment avec vous",
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/attend.png',
    ),
    // TranslationQuestion(
    //     originalText: "je le connais",
    //     correctTranslation: "i know him",
    //     userTranslationn: ""),
    ScrambledWordsQuestion(
      correctSentence: 'I am here',
      questionText: "Je suis là",
      additionalWords: ["something", "these"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'your_image_path_here',
    ),
    //
    ScrambledWordsQuestion(
      correctSentence: 'We are waiting for plane',
      questionText: "Nous attendons l'avion",
      additionalWords: ["Can", "your"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/aeroport.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'I had a very quiet day',
      questionText: "j'ai passé une jounée trés tranquille",
      additionalWords: ["her", "study", "cartoon"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/pensees.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'Mon fils a étudié pendant tout le week-end.',
      questionText: "My son studied all weekend",
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'assets/etude.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'Vous avez marché autour de grand lac?',
      questionText: "Did you walk around the big lake?",
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/lacg.png',
    ),
    Question("the bridge", [
      Option1("lac", "assets/lac.png"),
      Option1("les montagnes", "assets/montagne.png"),
      Option1("le pont", "assets/pont.png"),
      Option1("banane", "assets/banane.png")
    ], [
      false,
      false,
      false,
      false
    ], [
      false,
      false,
      true,
      false
    ]),
    ScrambledWordsQuestion(
      correctSentence: 'Nous avons marché le long de la mer.',
      questionText: "We walked along the sea",
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'assets/chatt.png',
    ),
    Question("the beach", [
      Option1("lac", "assets/lac.png"),
      Option1("les montagnes", "assets/montagne.png"),
      Option1("la plage", "assets/chatt.png"),
      Option1("une femme", "assets/mere.png")
    ], [
      false,
      false,
      false,
      false
    ], [
      false,
      true,
      false,
      false
    ]),
    //

    Question("the stairs", [
      Option1("pizza", "assets/pizza.png"),
      Option1("les escaliers", "assets/escaliers.png"),
      Option1("les montagnes", "assets/montagne.png"),
      Option1("la gare", "assets/gare.png")
    ], [
      false,
      false,
      false,
      false
    ], [
      false,
      true,
      false,
      false
    ]),
  ];

  @override
  void initState() {
    super.initState();
    // addQuestionsToFirestore('cours', 'je_parle_un_peu_avec_des_gens', '2');
    // importAndTranslateQuestions();
    // sortDocuments();
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
            'ImagePath': question.ImagePath,
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
