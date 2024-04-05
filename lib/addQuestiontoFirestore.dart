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
      correctSentence: 'sortir',
      questionText: "to go out",
      additionalWords: ["personnel", "gui"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'assets/sort.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'We take a lot of breaks',
      questionText: "Nous faisons beaucoup de pauses",
      additionalWords: ["meeting", "on"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/pause-cafe.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'montrer',
      questionText: "to show",
      additionalWords: ["dossier", "deux fois"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'your_image_path_here',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'These customers are leaving tomorrow',
      questionText: "Ces clientes partent demain",
      additionalWords: ["rich", "year"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'your_image_path_here',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'partir',
      questionText: "to leave",
      additionalWords: ["pendant", "partir"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'your_image_path_here',
    ),
    ScrambledWordsQuestion(
      correctSentence: "We' re explaining to them how the printer works",
      questionText: "Nous leur expliquons comment marche l'imprimante",
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/impr.png',
    ),
    TextQuestion("Le mercredi, nous allons ____ pour emprunter des ____ .", [
      Option1("à la bibliothéque ... livres", "assets/bijou.png"),
      Option1("au marché ... légumes", "assets/tv.png"),
      Option1("à la gare ... trains", "assets/vache.png"),
    ], [
      false,
      false,
      false
    ], [
      true,
      false,
      false,
    ]),
    ScrambledWordsQuestion(
      correctSentence: "He loves reading because his book is funny",
      questionText: "Il adore lire parce que son livre est amusant",
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/lire.png',
    ),
    TextQuestion("Elle n'a jamais lu ce livre", [
      Option1("lu", "assets/bijou.png"),
      Option1("grandi", "assets/tv.png"),
      Option1("attendu", "assets/vache.png"),
    ], [
      false,
      false,
      false
    ], [
      true,
      false,
      false,
    ]),
    ScrambledWordsQuestion(
      correctSentence: "populaire",
      questionText: "Tout le monde adore cette chanteuse : elle est trés ____",
      additionalWords: ["en retard", "méchante"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/popularite.png',
    ),
    TextQuestion("J'ai vraiment ____ ce film", [
      Option1("détestée", "assets/bijou.png"),
      Option1("détesté", "assets/tv.png"),
      Option1("déteste", "assets/vache.png"),
    ], [
      false,
      false,
      false
    ], [
      false,
      true,
      false,
    ]),
    ScrambledWordsQuestion(
      correctSentence: 'film cinéma',
      questionText: "Linda va voir un ____ au ___ ce soir",
      additionalWords: ["livre", "magasin"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/film.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'She doesn\'t like order books online',
      questionText: "Elle n'aime pas commander des livres sur internet",
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'your_image_path_here',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'Those decorations are beautiful',
      questionText: "Ces décorations sont belles",
      additionalWords: ["légumes", "ils"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'your_image_path_here',
    ),
    ScrambledWordsQuestion(
      correctSentence: "Je l'ai lu une fois",
      questionText: "I've read it once",
      additionalWords: ["épisodes", "auteur"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'your_image_path_here',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // addQuestionsToFirestore('cours', 'je_parle_un_peu_avec_des_gens', '10');
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
