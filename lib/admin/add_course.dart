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
  String _selectedLanguage = 'Anglais'; // Langue par défaut
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
      DocumentReference newCourseDoc = await FirebaseFirestore.instance
          .collection('cours$selectedLanguage')
          .doc(chapterId)
          .collection('lecons')
          .doc(leconId)
          .collection('questions')
          .add({'name': newCourseName});

      // Collection de questions sous le document de leçon
      CollectionReference newCourseQuestionsCollection =
          newCourseDoc.collection('questions');
      // Ajouter chaque question traduite à la collection
      for (dynamic question in translatedQuestions) {
        await newCourseQuestionsCollection.add(question);
      }

      print('Questions traduites enregistrées avec succès dans Firestore');
    } catch (e) {
      print('Erreur lors de l\'enregistrement des questions traduites : $e');
    }
  }

  Future<List<dynamic>> translateQuestions(
      List<dynamic> questions, String targetLanguage) async {
    List<dynamic> translatedQuestions = [];
    await Future.forEach(questions, (question) async {
      // Vérifiez le type de question avant la traduction
      if (question is String) {
        // Utilisez le service de traduction pour traduire la question dans la nouvelle langue
        Translation translatedText = await GoogleTranslator().translate(
          question,
          to: targetLanguage,
        );
        translatedQuestions.add(translatedText);
      } else {
        // Si la question n'est pas une chaîne de caractères, conservez-la telle quelle
        translatedQuestions.add(question);
      }
    });
    return translatedQuestions;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String newCourseName = _courseNameController.text;
      String selectedLanguage = _selectedLanguage;

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
                value: _selectedLanguage,
                onChanged: (newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                  });
                },
                items: <String>['Anglais', 'Allemand', 'Espagnol', 'Italien']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
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
