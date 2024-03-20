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

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String originalCourseId = 'francais'; // ID du cours de français
      String newCourseName = _courseNameController.text;
      String selectedLanguage = _selectedLanguage;

      // Importez les questions du cours de français
      await importAndTranslateQuestions(
          originalCourseId, newCourseName, selectedLanguage);

      // Réinitialiser le formulaire après soumission
      _formKey.currentState!.reset();

      // Affichez un message de succès ou effectuez d'autres actions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nouveau cours créé avec succès !'),
        ),
      );
    }
  }

  Future<void> importAndTranslateQuestions(String originalCourseId,
      String newCourseName, String selectedLanguage) async {
    try {
      // Obtenez une référence au document "chapter" dans Firestore
      DocumentSnapshot chapterSnapshot =
          await coursesCollection.doc(originalCourseId).get();
      Map<String, dynamic> chapterData =
          chapterSnapshot.data() as Map<String, dynamic>;

      // Obtenez les IDs de toutes les leçons sous le document "chapter"
      List<dynamic> leconIds = chapterData['lecons'];

      // Parcourez chaque leçon pour importer et traduire les questions
      await Future.forEach(leconIds, (leconId) async {
        // Importez les questions de la leçon actuelle
        List<dynamic> frenchQuestions =
            await importQuestionsFromFirestore(originalCourseId, leconId);

        // Traduisez les questions en fonction de la nouvelle langue
        List<dynamic> translatedQuestions =
            await translateQuestions(frenchQuestions, selectedLanguage);

        // Enregistrez les questions traduites dans une nouvelle collection
        await saveTranslatedCourse(newCourseName, translatedQuestions,
            _selectedLanguage, originalCourseId, leconId);
      });

      print('Questions importées et traduites avec succès depuis Firestore');
    } catch (e) {
      print(
          'Erreur lors de l\'importation et traduction des questions depuis Firestore : $e');
    }
  }

  Future<List<dynamic>> importQuestionsFromFirestore(
      String chapter, int leconId) async {
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
      return [];
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

  Future<void> saveTranslatedCourse(
      String newCourseName,
      List<dynamic> translatedQuestions,
      String newLanguage,
      String chapter,
      int leconId) async {
    try {
      // Créez un nouveau document pour le nouveau cours dans la collection "cours"
      DocumentReference newCourseDoc = await coursesCollection
          .doc(
              'cours$newLanguage') // Utiliser la nouvelle langue pour le nom de la collection
          .collection(chapter)
          .doc('$leconId')
          .collection('questions')
          .add({
        'name': newCourseName,
      });

      // Enregistrez les questions traduites dans la nouvelle collection de cours
      CollectionReference newCourseQuestionsCollection =
          newCourseDoc.collection('questions');
      await Future.forEach(translatedQuestions, (question) async {
        await newCourseQuestionsCollection.add(question);
      });

      print('Nouveau cours enregistré avec succès dans Firestore');
    } catch (e) {
      print('Erreur lors de l\'enregistrement du nouveau cours : $e');
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
