import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pfe_1/constant/question.dart';
import 'package:translator/translator.dart';

class NewCourseForm extends StatefulWidget {
  @override
  _NewCourseFormState createState() => _NewCourseFormState();
}

class _NewCourseFormState extends State<NewCourseForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _courseNameController = TextEditingController();
  String? _selectedLanguageCode;
  // Langue par défaut
  CollectionReference coursesCollection =
      FirebaseFirestore.instance.collection('cours');

  @override
  void dispose() {
    _courseNameController.dispose();
    super.dispose();
  }

  Future<List<dynamic>> importQuestionsFromFirestore(
      String chapter, String leconId) async {
    try {
      // Obtenez une référence à la collection "questions" dans Firestore
      CollectionReference questionsCollection = FirebaseFirestore.instance
          .collection('cours')
          .doc(chapter)
          .collection('lecons')
          .doc('$leconId')
          .collection('questions');

      // Récupérez tous les documents de la collection "questions"
      QuerySnapshot querySnapshot = await questionsCollection.get();

      List<dynamic> importedQuestions = [];

      // Créez une liste pour stocker les documents triés
      List<DocumentSnapshot> sortedDocs = [];

      // Parcourez les documents récupérés pour les trier en fonction du nombre après le mot "question" dans leur nom
      querySnapshot.docs.forEach((doc) {
        sortedDocs.add(doc);
      });

      // Triez les documents en fonction du nombre après le mot "question" dans leur nom
      sortedDocs.sort((a, b) {
        int aNum = int.parse(a.id.replaceFirst('question', ''));
        int bNum = int.parse(b.id.replaceFirst('question', ''));
        return aNum.compareTo(bNum);
      });

      // Parcourez les documents triés pour ajouter les questions dans l'ordre
      sortedDocs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Ajoutez les questions dans l'ordre trié
        switch (data['type']) {
          case 'Question':
            importedQuestions.add(Question(
              data['questionText'],
              List<Option1>.from(data['options'].map(
                  (option) => Option1(option['text'], option['imagePath']))),
              List<bool>.from(data['selectedOptions'] ?? []),
              List<bool>.from(data['correctOptions'] ?? []),
            ));
            break;
          case 'SoundQuestion':
            importedQuestions.add(SoundQuestion(
              questionText: data['questionText'],
              options: List<Option1>.from(data['options'].map(
                  (option) => Option1(option['text'], option['imagePath']))),
              spokenWord: data['spokenWord'] ?? '',
              selectedWord: data['selectedWord'] ?? '',
            ));
            break;
          case 'ScrambledWordsQuestion':
            importedQuestions.add(ScrambledWordsQuestion(
              correctSentence: data['correctSentence'] ?? '',
              questionText: data['questionText'] ?? '',
              additionalWords: List<String>.from(data['additionalWords'] ?? []),
              questionLanguage: data['questionLanguage'] ?? '',
              selectedWordOrder:
                  List<String>.from(data['selectedWordOrder'] ?? []),
              ImagePath: '',
            ));
            break;
          case 'TranslationQuestion':
            importedQuestions.add(TranslationQuestion(
              originalText: data['originalText'] ?? '',
              correctTranslation: data['correctTranslation'] ?? '',
              userTranslationn: data['userTranslationn'] ?? '',
            ));
            break;
          case 'TextQuestion':
            importedQuestions.add(TextQuestion(
              data['questionText'],
              List<Option1>.from(data['options'].map(
                  (option) => Option1(option['text'], option['imagePath']))),
              List<bool>.from(data['selectedOptions'] ?? []),
              List<bool>.from(data['correctOptions'] ?? []),
            ));
            break;
          default:
            print('Type de question non pris en charge : ${data['type']}');
            break;
        }
      });

      return importedQuestions;
    } catch (e) {
      print(
          'Erreur lors de l\'importation des questions depuis Firestore : $e');
      return []; // Retournez une liste vide en cas d'erreur
    }
  }

  Future<void> importAndTranslateQuestions(String originalCourseId,
      String newCourseName, String selectedLanguage) async {
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
          List<dynamic> frenchQuestions =
              await importQuestionsFromFirestore(chapterId, leconId);

          // Traduire les questions en fonction de la nouvelle langue
          List<dynamic> translatedQuestions =
              await translateQuestions(frenchQuestions, selectedLanguage);

          // Enregistrer les questions traduites dans une nouvelle collection
          await saveTranslatedQuestions(newCourseName, selectedLanguage,
              chapterId, leconId, translatedQuestions);
          print(frenchQuestions);
        }
      }
    } catch (e) {
      print('Erreur lors de la récupération des leçons : $e');
    }
  }

  Future<void> saveTranslatedQuestions(
    String newCourseName,
    String selectedLanguage,
    String chapterId,
    String leconId,
    List<dynamic> translatedQuestions,
  ) async {
    try {
      // Collection de questions sous le document de leçon
      CollectionReference newCourseQuestionsCollection = FirebaseFirestore
          .instance
          .collection('cours$selectedLanguage')
          .doc(chapterId)
          .collection('lecons')
          .doc(leconId)
          .collection('questions');

      // Ajouter chaque question traduite à la collection
      for (int i = 0; i < translatedQuestions.length; i++) {
        final question = translatedQuestions[i];
        final questionI = i + 1;
        if (question is Question) {
          await newCourseQuestionsCollection.doc('question$questionI').set({
            'type': 'Question',
            'questionText': question.questionText,
            'options':
                question.options.map((option) => option.toMap()).toList(),
            'selectedOptions': question.selectedOptions,
            'correctOptions': question.correctOptions,
          });
        } else if (question is SoundQuestion) {
          await newCourseQuestionsCollection.doc('question$questionI').set({
            'type': 'SoundQuestion',
            'questionText': question.questionText,
            'options':
                question.options.map((option) => option.toMap()).toList(),
            'spokenWord': question.spokenWord,
            'selectedWord': question.selectedWord,
          });
        } else if (question is ScrambledWordsQuestion) {
          await newCourseQuestionsCollection.doc('question$questionI').set({
            'type': 'ScrambledWordsQuestion',
            'questionText': question.questionText,
            'correctSentence': question.correctSentence,
            'selectedWords': question.selectedWords,
            'selectedWordOrder': question.selectedWordOrder,
            'additionalWords': question.additionalWords,
          });
        } else if (question is TranslationQuestion) {
          await newCourseQuestionsCollection.doc('question$questionI').set({
            'type': 'TranslationQuestion',
            'originalText': question.originalText,
            'correctTranslation': question.correctTranslation,
            'userTranslationn': question.userTranslationn,
          });
        } else if (question is TextQuestion) {
          await newCourseQuestionsCollection.doc('question$questionI').set({
            'type': 'TextQuestion',
            'questionText': question.questionText,
            'options':
                question.options.map((option) => option.toMap()).toList(),
            'selectedOptions': question.selectedOptions,
            'correctOptions': question.correctOptions,
          });
        }
      }

      print('Questions traduites enregistrées avec succès dans Firestore');
    } catch (e) {
      print('Erreur lors de l\'enregistrement des questions traduites : $e');
    }
  }

  Future<List<dynamic>> translateQuestions(
      List<dynamic> questions, String targetLanguage) async {
    List<dynamic> translatedQuestions = [];
    var currentQuestion;
    try {
      for (var question in questions) {
        currentQuestion = question;
        if (question is Question) {
          Translation translatedQuestionText =
              await GoogleTranslator().translate(
            question.questionText,
            to: targetLanguage,
          );
          List<Option1> translatedOptions = [];
          for (var option in question.options) {
            Translation translatedOptionText =
                await GoogleTranslator().translate(
              option.text,
              to: targetLanguage,
            );
            translatedOptions
                .add(Option1(translatedOptionText.text, option.imagePath));
          }
          Question translatedQuestion = Question(
            translatedQuestionText.text,
            translatedOptions,
            question.selectedOptions,
            question.correctOptions,
          );
          translatedQuestions.add(translatedQuestion);
        } else if (question is SoundQuestion) {
          Translation translatedQuestionText =
              await GoogleTranslator().translate(
            question.questionText,
            to: targetLanguage,
          );
          SoundQuestion translatedQuestion = SoundQuestion(
            questionText: translatedQuestionText.text,
            options: question.options,
            spokenWord: question.spokenWord,
            selectedWord: question.selectedWord,
          );
          translatedQuestions.add(translatedQuestion);
        } else if (question is ScrambledWordsQuestion) {
          Translation translatedQuestionText =
              await GoogleTranslator().translate(
            question.questionText,
            to: targetLanguage,
          );

          ScrambledWordsQuestion translatedQuestion = ScrambledWordsQuestion(
            correctSentence: question
                .correctSentence, // Conservez la phrase correcte sans traduction
            questionText: translatedQuestionText
                .text, // Utilisez le texte traduit pour la question
            selectedWordOrder: question
                .selectedWordOrder, // Vous pouvez conserver la liste vide pour l'ordre des mots sélectionnés
            additionalWords: question
                .additionalWords, // Conservez les mots supplémentaires sans traduction
            questionLanguage: '',
            ImagePath: question
                .ImagePath, // Vous pouvez conserver la langue vide ou définir une valeur par défaut
          );

          translatedQuestions.add(translatedQuestion);
        } else if (question is TranslationQuestion) {
          Translation translatedQuestionText =
              await GoogleTranslator().translate(
            question.originalText,
            to: targetLanguage,
          );
          TranslationQuestion translatedQuestion = TranslationQuestion(
            originalText: translatedQuestionText.text,
            correctTranslation: question.correctTranslation,
            userTranslationn: question.userTranslationn,
          );
          translatedQuestions.add(translatedQuestion);
        } else if (question is TextQuestion) {
          Translation translatedQuestionText =
              await GoogleTranslator().translate(
            question.questionText,
            to: targetLanguage,
          );
          TextQuestion translatedQuestion = TextQuestion(
            translatedQuestionText.text,
            question.options,
            question.selectedOptions,
            question.correctOptions,
          );
          translatedQuestions.add(translatedQuestion);
        } else {
          translatedQuestions.add(question);
        }
      }
    } catch (e) {
      print(
          'Une erreur s\'est produite lors de la traduction des questions: $e');
      // Ajoutez ici le code pour afficher les attributs de la question qui a causé le problème
      if (e.runtimeType.toString() == "NoSuchMethodError") {
        print('Question causant l\'erreur: $e');
        if (currentQuestion is ScrambledWordsQuestion) {
          print('Attributs de la question:');
          print('QuestionText: ${currentQuestion.questionText}');
          print('CorrectSentence: ${currentQuestion.correctSentence}');
          print('AdditionalWords: ${currentQuestion.additionalWords}');
          // Ajoutez ici d'autres attributs spécifiques de la question ScrambledWordsQuestion
        }
      }
    }
    return translatedQuestions;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String newCourseName = _courseNameController.text;
      String selectedLanguage = _selectedLanguageCode!;

      // Récupérer tous les documents sous la collection "cours"
      QuerySnapshot querySnapshot = await coursesCollection.get();

      // Parcourir tous les documents
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        String originalCourseId = doc.id;

        // Importez et traduisez les questions pour chaque cours
        await importAndTranslateQuestions(
            originalCourseId, newCourseName, selectedLanguage);
      }

      // Réinitialiser le formulaire après soumission
      _formKey.currentState!.reset();

      // Affichez un message de succès ou effectuez d'autres actions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nouveaux cours créés avec succès !'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un nouveau cours'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _courseNameController,
                decoration: InputDecoration(
                  labelText: 'Nom du cours',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom du cours';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedLanguageCode,
                onChanged: (newValue) {
                  setState(() {
                    _selectedLanguageCode = newValue!;
                  });
                },
                items: <String, String>{
                  'Anglais': 'en',
                  'Allemand': 'de',
                  'Espagnol': 'es',
                  'Italien': 'it',
                }.entries.map<DropdownMenuItem<String>>((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.value,
                    child: Text(entry.key),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Langue',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Créer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
