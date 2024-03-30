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
    ScrambledWordsQuestion(
      correctSentence: 'ils sont des ingenieurs français',
      questionText: "They are Frensh engineers",
      additionalWords: ["Ce", "c'est un"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'assets/ingenieur.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'There are opera houses in New York',
      questionText: "Il y a des opéras à New York",
      additionalWords: ["work", "cooks"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/hommes.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'Il est fantastique',
      questionText: "He is fantastic",
      additionalWords: ["non", "pour"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/super-heros.png',
    ),
    ////////houni iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
    ScrambledWordsQuestion(
      correctSentence: 'he is shy',
      questionText: "il est timide",
      additionalWords: ["arround", "stairs"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/timide.png',
    ),
    // TranslationQuestion(
    //     originalText: "je le connais",
    //     correctTranslation: "i know him",
    //     userTranslationn: ""),
    TextQuestion("Ils sont ____", [
      Option1("répond", "assets/gateau.png"),
      Option1("ai ", "assets/gateau.png"),
      Option1("tunisiens ", "assets/gateau.png"),
      Option1("sont ", "assets/gateau.png")
    ], [
      false,
      false,
      false,
      false,
    ], [
      false,
      false,
      true,
      false,
    ]),
    //
    TextQuestion("Ce sont des collègues ____", [
      Option1("responsable ", "assets/gateau.png"),
      Option1("responsables ", "assets/gateau.png"),
    ], [
      false,
      false,
    ], [
      false,
      true,
    ]),
    ScrambledWordsQuestion(
      correctSentence: 'They are lazy students',
      questionText: "Ce sont des étudiantes paresseuses",
      additionalWords: ["and", "teachers", 'friends'],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/la-paresse.png',
    ),
    TextQuestion("C'est ma _____ amie", [
      Option1("meilleur", "assets/gateau.png"),
      Option1("meilleure ", "assets/gateau.png"),
      Option1("tunisiens ", "assets/gateau.png"),
      Option1("sont ", "assets/gateau.png")
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
    TextQuestion("Il est ___ et il parle le français", [
      Option1("tunisienne", "assets/gateau.png"),
      Option1("tunisien ", "assets/gateau.png"),
      Option1("sérieuse ", "assets/gateau.png"),
    ], [
      false,
      false,
      false,
    ], [
      false,
      true,
      false,
    ]),
    Question("newspaper", [
      Option1("livre", "assets/livre.png"),
      Option1("journal ", "assets/un-journal.png"),
      Option1("indiennne ", "assets/indien.png"),
      Option1("pomme ", "assets/pomme.png")
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
    TextQuestion("Elles sont ____", [
      Option1("timides ", "assets/gateau.png"),
      Option1("timide ", "assets/gateau.png"),
    ], [
      false,
      false,
    ], [
      true,
      false,
    ]),

    ScrambledWordsQuestion(
      correctSentence: 'Il est sérieux et agréable',
      questionText: "He is serious and pleasant",
      additionalWords: ["grand"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'your_image_path_here',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'C\'est un grand chanteur',
      questionText: "He is a singer",
      additionalWords: ["paresseuse"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'your_image_path_here',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // addQuestionsToFirestore('cours', 'je_parle_un_peu_avec_des_gens', '4');
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
