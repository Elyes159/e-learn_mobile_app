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
      correctSentence: 'My granddaughter is very pretty',
      questionText: "Ma petite-fille est trés jolie",
      additionalWords: ["we", "eleven"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/filee.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'She is studying her lessons at home',
      questionText: "Elle apprend ses leçons à la maison",
      additionalWords: ["with", "am"],
      selectedWordOrder: [],
      questionLanguage: 'fr', //
      ImagePath: 'assets/maison-work.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'You become sad when you look at these photos',
      questionText: "Vous devenez tristes quand vous regardez ces photos",
      additionalWords: ["grandpa", "Germany"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'assets/pleurer.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'My uncle',
      questionText: "mon oncle",
      additionalWords: ["how", "many", "chemistry"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'your_image_path_here',
    ),
    //
    TextQuestion("Grâce à ce professeur, les ____ vont tout comprendre.", [
      Option1("étudiants", "assets/bijou.png"),
      Option1("escaliers", "assets/tv.png"),
      Option1("poissons", "assets/vache.png"),
    ], [
      false,
      false,
      false
    ], [
      true,
      false,
      false,
    ]),
    TextQuestion("Ils viennent ___ partir.", [
      Option1("à", "assets/bijou.png"),
      Option1("vers", "assets/tv.png"),
      Option1("de", "assets/vache.png"),
    ], [
      false,
      false,
      false
    ], [
      false,
      false,
      true,
    ]),
    // TranslationQuestion(
    //     originalText: "je le connais",
    //     correctTranslation: "i know him",
    //     userTranslationn: ""),
    TextQuestion("J'ai deux ___", [
      Option1("frére", "assets/bijou.png"),
      Option1("pére", "assets/tv.png"),
      Option1("oncles", "assets/vache.png"),
    ], [
      false,
      false,
      false
    ], [
      false,
      false,
      true,
    ]),
    //
    ScrambledWordsQuestion(
      correctSentence: 'C\'est le début de l\'année',
      questionText: "It's the beginning pf the year",
      additionalWords: ["des dîner", "les professeurs"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'assets/annee.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'Les adolescents sont sympas',
      questionText: "The teenagers are nice",
      additionalWords: ["mangent", "filles"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'assets/amis.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'Nous venons dimanche',
      questionText: "We are coming on Sunday",
      additionalWords: ["bijoux", "soir"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'assets/amis.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'prenez',
      questionText: "take",
      additionalWords: ["immédiatement", "oui"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'assets/vieux.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'petits-enfants',
      questionText: "grandchildren",
      additionalWords: ["papi", "pâtes"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'your_image_path_here',
    ),
    TextQuestion("Ils ____ de vacnaces", [
      Option1("revenir", "assets/colisee.png"),
      Option1("reviennent", "assets/geo.png"),
      Option1("revenez", "assets/atome.png"),
    ], [
      false,
      false,
      false,
    ], [
      false,
      true,
      false
    ]),

    ScrambledWordsQuestion(
      correctSentence: 'They have just left',
      questionText: "Ils viennent de partir",
      additionalWords: ["adults", "remember"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'your_image_path_here',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // addQuestionsToFirestore('cours', 'je_parle_un_peu_avec_des_gens', '7');
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
