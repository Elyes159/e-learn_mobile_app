import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pfe_1/constant/question.dart';

class SampleQuestionsWidget extends StatefulWidget {
  @override
  _SampleQuestionsWidgetState createState() => _SampleQuestionsWidgetState();
}

// TextQuestion("Ils viennent ___ partir.", [
//   Option1("à", "assets/bijou.png"),
//   Option1("vers", "assets/tv.png"),
//   Option1("de", "assets/vache.png"),
// ], [
//   false,
//   false,
//   false
// ], [
//   false,
//   false,
//   true,
// ]),
// TranslationQuestion(
//     originalText: "je le connais",
//     correctTranslation: "i know him",
//     userTranslationn: ""),
//your_image_path_here
class _SampleQuestionsWidgetState extends State<SampleQuestionsWidget> {
  final List<dynamic> questions = [
    ScrambledWordsQuestion(
      correctSentence: 'correcte',
      questionText: "Vous devrez donner la réponse ___",
      additionalWords: [
        "correct",
        "corrects",
      ],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'your_image_path_here',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'indiennes',
      questionText: "Elles sont ____",
      additionalWords: ["indiens", "indienne"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'your_image_path_here',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'diplômée',
      questionText: "Nous espérons qu'elle sera bientôt ____",
      additionalWords: ["diplôme", "diplômés"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/diplome.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'She is great actress',
      questionText: "C'est une bonne actrice",
      additionalWords: ["he", "good"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/actrice.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'They are sorry',
      questionText: "Elles sont désolées",
      additionalWords: ["ok", "year"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/desole.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'Notre-Dame est un monument français',
      questionText: "Notre-Dame is a French monument",
      additionalWords: ["anglais", "américain"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'assets/notredame.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'a Spanish girl',
      questionText: "une fille espagnole",
      additionalWords: ["boy", "French"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/fillees.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'Je préfère le pain français',
      questionText: "I prefer the French bread",
      additionalWords: ["de sucre", "restaurant"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'assets/painf.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'Elle est étudiante',
      questionText: "She is a student",
      additionalWords: ["espagnole", "travailles", "américain", "m'apelle"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'assets/painf.png',
    ),
    TextQuestion("Tu devras être sûre que ta réponse est ____", [
      Option1("correcte", "assets/bijou.png"),
      Option1("correct", "assets/tv.png"),
    ], [
      false,
      false,
    ], [
      true,
      false,
    ]),
    TextQuestion("C'est une ____ actrice", [
      Option1("grande", "assets/bijou.png"),
      Option1("grands", "assets/tv.png"),
      Option1("grandes", "assets/tv.png"),
    ], [
      false,
      false,
      false,
    ], [
      true,
      false,
      false,
    ]),
  ];

  @override
  void initState() {
    super.initState();
    // addQuestionsToFirestore('cours', 'adventurer', '1');
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

      print(
          'Toutes les https://www.upwork.com/nx/find-work/most-recentquestions ont été ajoutées à Firestore avec succès');
    } catch (e) {
      print(
          'Erreur lorshttps://www.upwork.com/nx/find-work/most-recent de l\'ajout des questions à Firestore : $e');
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
