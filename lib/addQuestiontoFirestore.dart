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
      correctSentence: 'timbre',
      questionText: "stamp",
      additionalWords: ["nord", "bijoux"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'assets/timbre.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'This store is on Marie Curie Avenue',
      questionText: "Ce magasin est sur l'avenue de Marie Curie",
      additionalWords: ["de", "it's"],
      selectedWordOrder: [],
      questionLanguage: 'fr', //
      ImagePath: 'assets/avenue.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'en_promotion',
      questionText: "on sale",
      additionalWords: ["malheureusement", "en promotion"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'assets/promotion.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'My skirts are blue',
      questionText: "Mes jupes sont bleu",
      additionalWords: ["pants", "have", "What"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'your_image_path_here',
    ),
    //
    ScrambledWordsQuestion(
      correctSentence: 'argent',
      questionText: "silver",
      additionalWords: ["devenir", "comprennent"],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'your_image_path_here',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'Where is my swimsuit',
      questionText: "Où est mon maillot de bain ?",
      additionalWords: ["devenir", "comprennent"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/maillots-de-bain.png',
    ),

    Question("guidebook", [
      Option1("place", "assets/place.png"),
      Option1("chanteur", "assets/chanteur.png"),
      Option1("guide", "assets/guide.png"),
      Option1("danseur", "assets/danseur.png"),
    ], [
      false,
      false,
      false,
      false
    ], [
      false,
      false,
      true,
      false,
    ]),
    Question("Shoes", [
      Option1("sweat-shirt", "assets/sweat-shirt.png"),
      Option1("Chaussures", "assets/chaussures.png"),
      Option1("alarme", "assets/alarme.png"),
      Option1("danseur", "assets/danseur.png"),
    ], [
      false,
      false,
      false,
      false
    ], [
      false,
      true,
      false,
      false,
    ]),
    ScrambledWordsQuestion(
      correctSentence: 'THis sweatshirt is too expensive',
      questionText: "Ce sweat-shirt est trop cher",
      additionalWords: ["a lot of", "French"],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/trop-cher.png',
    ),

    TextQuestion("Le ____ de chaussures est sur place de la République", [
      Option1("manuel", "assets/place.png"),
      Option1("tunisien", "assets/chanteur.png"),
      Option1("magasin", "assets/guide.png"),
    ], [
      false,
      false,
      false,
    ], [
      false,
      false,
      true,
    ]),
    TextQuestion("C'est un ____ célèbre.", [
      Option1("monuments", "assets/place.png"),
      Option1("monument", "assets/chanteur.png"),
    ], [
      false,
      false,
    ], [
      false,
      true,
    ]),
    TextQuestion("Ce sont des chaussures ____.", [
      Option1("neuve", "assets/place.png"),
      Option1("neuves", "assets/chanteur.png"),
      Option1("nouveau", "assets/chanteur.png"),
    ], [
      false,
      false,
      false
    ], [
      false,
      true,
      false
    ]),
    TextQuestion(
        "Excusez-moi, pouvez-vous me dire ______ est le musée du Louvre ?", [
      Option1("quand", "assets/place.png"),
      Option1("où", "assets/chanteur.png"),
      Option1("qui", "assets/chanteur.png"),
    ], [
      false,
      false,
      false
    ], [
      false,
      true,
      false
    ]),
    ScrambledWordsQuestion(
      correctSentence: 'I\'m not wearing a gold ring',
      questionText: "Je ne porte pas de bague en or",
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/bague.png',
    ),

    Question("wardrobe", [
      Option1("chaussures", "assets/chaussures.png"),
      Option1("armoire", "assets/armoire.png"),
      Option1("timbre", "assets/timbre.png"),
      Option1("visage", "assets/visage.png"),
    ], [
      false,
      false,
      false
    ], [
      false,
      true,
      false
    ]),
    ScrambledWordsQuestion(
      correctSentence: 'C\'est l\'été et je peux porter un short',
      questionText: "it's summer, and i can wear shorts",
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'en',
      ImagePath: 'assets/short.png',
    ),
    ScrambledWordsQuestion(
      correctSentence: 'There are how many districts in Paris',
      questionText: "Il y a combien d'arrondissements à Paris ?",
      additionalWords: [],
      selectedWordOrder: [],
      questionLanguage: 'fr',
      ImagePath: 'assets/rond-point.png',
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
