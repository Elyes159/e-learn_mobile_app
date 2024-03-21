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

      // Récupérez tous les documents de la collection "questions" dans l'ordre croissant par leur nom
      QuerySnapshot querySnapshot =
          await questionsCollection.orderBy(FieldPath.documentId).get();

      List<dynamic> importedQuestions = [];

      // Parcourez les documents récupérés
      querySnapshot.docs.forEach((doc) {
        // Récupérez les données du document Firestore
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Vérifiez le type de question et ajoutez-la à la liste "questions" en conséquence
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
      List<dynamic> translatedQuestions) async {
    try {
      // Créer un nouveau document pour chaque leçon dans la nouvelle collection
      await FirebaseFirestore.instance
          .collection('cours$selectedLanguage')
          .doc(chapterId)
          .collection('lecons')
          .doc(leconId) // Utilisez l'ID de la leçon comme ID du document
          .set({
        'name': newCourseName
      }); // Utilisez set() pour définir le document

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
        final questionIndex = i + 1;

        if (question is Question) {
          // Si la question est de type Question
          await newCourseQuestionsCollection.doc('question$questionIndex').set({
            'type': 'Question',
            'questionText': question.questionText,
            'options':
                question.options.map((option) => option.toMap()).toList(),
            'selectedOptions': question.selectedOptions,
            'correctOptions': question.correctOptions,
          });
        } else if (question is SoundQuestion) {
          // Si la question est de type SoundQuestion
          await newCourseQuestionsCollection.doc('question$questionIndex').set({
            'type': 'SoundQuestion',
            'questionText': question.questionText,
            'options':
                question.options.map((option) => option.toMap()).toList(),
            'spokenWord': question.spokenWord,
            'selectedWord': question.selectedWord,
          });
        } else if (question is ScrambledWordsQuestion) {
          // Si la question est de type ScrambledWordsQuestion
          await newCourseQuestionsCollection.doc('question$questionIndex').set({
            'type': 'ScrambledWordsQuestion',
            'questionText': question.questionText,
            'correctSentence': question.correctSentence,
            'selectedWords': question.selectedWords,
            'selectedWordOrder': question.selectedWordOrder,
            'additionalWords': question.additionalWords,
          });
        } else if (question is TranslationQuestion) {
          // Si la question est de type TranslationQuestion
          await newCourseQuestionsCollection.doc('question$questionIndex').set({
            'type': 'TranslationQuestion',
            'originalText': question.originalText,
            'correctTranslation': question.correctTranslation,
            'userTranslationn': question.userTranslationn,
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
    for (var question in questions) {
      // Vérifiez le type de la question
      if (question is String) {
        // Si la question est une chaîne de caractères, traduisez-la
        Translation translatedText = await GoogleTranslator().translate(
          question,
          to: targetLanguage,
        );
        translatedQuestions.add(translatedText);
      } else if (question is Question) {
        // Si la question est de type Question, traduisez le texte de la question
        Translation translatedQuestionText = await GoogleTranslator().translate(
          question.questionText,
          to: targetLanguage,
        );

        // Traduisez les textes des options
        List<Option1> translatedOptions = [];
        for (var option in question.options) {
          Translation translatedOptionText = await GoogleTranslator().translate(
            option.text,
            to: targetLanguage,
          );
          translatedOptions
              .add(Option1(translatedOptionText.text, option.imagePath));
        }

        // Créez une nouvelle question traduite avec le texte traduit et les autres propriétés inchangées
        Question translatedQuestion = Question(
          translatedQuestionText.text,
          translatedOptions,
          question.selectedOptions,
          question.correctOptions,
        );

        // Ajoutez la nouvelle question traduite à la liste des questions traduites
        translatedQuestions.add(translatedQuestion);
      } else if (question is SoundQuestion) {
        // Traitez de la même manière pour les autres types de questions
        // Traduisez le texte de la question
        Translation translatedQuestionText = await GoogleTranslator().translate(
          question.questionText,
          to: targetLanguage,
        );
        // Créez une nouvelle question traduite avec le texte traduit et les autres propriétés inchangées
        SoundQuestion translatedQuestion = SoundQuestion(
          questionText: translatedQuestionText.text,
          options: question.options,
          spokenWord: question.spokenWord,
          selectedWord: question.selectedWord,
        );
        translatedQuestions.add(translatedQuestion);
      } else if (question is ScrambledWordsQuestion) {
        Translation translatedQuestionText;
        if (question.questionTextLanguage == 'fr') {
          // Si la langue de la question est le français, traduisez le texte de la question
          translatedQuestionText = await GoogleTranslator().translate(
            question.questionText,
            to: targetLanguage,
          );
        } else {
          // Sinon, traduisez les mots supplémentaires
          translatedQuestionText = await GoogleTranslator().translate(
            question.additionalWords.join(' '),
            to: targetLanguage,
          );
        }

        // Créez une nouvelle question traduite avec le texte traduit et les autres propriétés inchangées
        ScrambledWordsQuestion translatedQuestion = ScrambledWordsQuestion(
          correctSentence: question.correctSentence,
          questionText: translatedQuestionText.text,
          additionalWords: question.additionalWords,
        );
        translatedQuestions.add(translatedQuestion);
      } else if (question is TranslationQuestion) {
        // Traitez de la même manière pour les autres types de questions
        // Traduisez le texte de la question
        Translation translatedQuestionText = await GoogleTranslator().translate(
          question.originalText,
          to: targetLanguage,
        );
        // Créez une nouvelle question traduite avec le texte traduit et les autres propriétés inchangées
        TranslationQuestion translatedQuestion = TranslationQuestion(
          originalText: translatedQuestionText.text,
          correctTranslation: question.correctTranslation,
          userTranslationn: question.userTranslationn,
        );
        translatedQuestions.add(translatedQuestion);
      } else if (question is TextQuestion) {
        // Traitez de la même manière pour les autres types de questions
        // Traduisez le texte de la question
        Translation translatedQuestionText = await GoogleTranslator().translate(
          question.questionText,
          to: targetLanguage,
        );
        // Créez une nouvelle question traduite avec le texte traduit et les autres propriétés inchangées
        TextQuestion translatedQuestion = TextQuestion(
          translatedQuestionText.text,
          question.options,
          question.selectedOptions,
          question.correctOptions,
        );
        translatedQuestions.add(translatedQuestion);
      } else {
        // Si le type de question n'est pas pris en charge, conservez-la telle quelle
        translatedQuestions.add(question);
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
