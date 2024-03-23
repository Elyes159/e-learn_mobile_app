import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AddQuestionForm extends StatefulWidget {
  @override
  _AddQuestionFormState createState() => _AddQuestionFormState();
}

class _AddQuestionFormState extends State<AddQuestionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _questionTextController = TextEditingController();
  TextEditingController _option1Controller = TextEditingController();
  TextEditingController _option2Controller = TextEditingController();
  TextEditingController _option3Controller = TextEditingController();
  TextEditingController _option4Controller = TextEditingController();
  TextEditingController _chapterController =
      TextEditingController(); // Ajout du contrôleur pour le chapitre
  TextEditingController _lessonController =
      TextEditingController(); // Ajout du contrôleur pour la leçon
  List<bool> _correctOptions = [
    false,
    false,
    false,
    false
  ]; // Initialisation à false
  List<bool> _selectedOptions = [
    false,
    false,
    false,
    false
  ]; // Initialisation à false pour chaque option
  int _selectedOptionIndex = -1; // Index de l'option sélectionnée
  Future<String> _moveImageToAssets(XFile imageFile) async {
    Uint8List imageData = await imageFile.readAsBytes();
    String imageName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    String documentsDir = (await getApplicationDocumentsDirectory())
        .path; // Récupérer le répertoire de documents de l'application
    String imagePath =
        '$documentsDir/$imageName'; // Chemin d'accès pour l'image dans le répertoire de documents
    await File(imagePath).writeAsBytes(
        imageData); // Écrire l'image dans le répertoire de documents

    return imagePath;
  }

  List<Map<String, String>> _options = [
    {'text': 'Option 1', 'imagePath': ''},
    {'text': 'Option 2', 'imagePath': ''},
    {'text': 'Option 3', 'imagePath': ''},
    {'text': 'Option 4', 'imagePath': ''},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _chapterController,
                decoration: InputDecoration(labelText: 'Chapitre'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le chapitre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _lessonController,
                decoration: InputDecoration(labelText: 'Leçon'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer la leçon';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _questionTextController,
                decoration: InputDecoration(labelText: 'Texte de la question'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le texte de la question';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              _buildOptionTextField(_option1Controller, 'Option 1', 0),
              SizedBox(height: 10),
              _buildOptionTextField(_option2Controller, 'Option 2', 1),
              SizedBox(height: 10),
              _buildOptionTextField(_option3Controller, 'Option 3', 2),
              SizedBox(height: 10),
              _buildOptionTextField(_option4Controller, 'Option 4', 3),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Sélectionnez une option (de 1 à 4)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty ||
                      int.tryParse(value) == null ||
                      int.parse(value) < 1 ||
                      int.parse(value) > 4) {
                    return 'Veuillez entrer un nombre valide de 1 à 4';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _selectedOptionIndex = int.parse(value) - 1;
                    _correctOptions = [
                      false,
                      false,
                      false,
                      false
                    ]; // Réinitialiser correctOptions
                    if (_selectedOptionIndex >= 0 &&
                        _selectedOptionIndex <= 3) {
                      _correctOptions[_selectedOptionIndex] =
                          true; // Mettre à jour correctOptions
                    }
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Construire le chemin d'accès pour la question
                    String chapter = _chapterController.text;
                    String lesson = _lessonController.text;
                    CollectionReference questionCollection = FirebaseFirestore
                        .instance
                        .collection('cours')
                        .doc(chapter)
                        .collection('lecons')
                        .doc(lesson)
                        .collection('questions');
                    QuerySnapshot questionSnapshot =
                        await questionCollection.get();
                    int numberOfQuestions = questionSnapshot.docs.length;

                    // Enregistrer la question dans la base de données
                    try {
                      await questionCollection.add({
                        'questionText': _questionTextController.text,
                        'options': _options,
                        'correctOptions': _correctOptions,
                        'selectedOptions': _selectedOptions,
                      });

                      // Réinitialiser les contrôleurs après l'enregistrement réussi
                      _formKey.currentState!.reset();
                      _correctOptions = [false, false, false, false];
                      _selectedOptions = [false, false, false, false];
                      _selectedOptionIndex = -1;

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Question ajoutée avec succès'),
                      ));
                    } catch (error) {
                      print('Erreur lors de l\'ajout de la question : $error');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Erreur lors de l\'ajout de la question'),
                      ));
                    }
                  }
                },
                child: Text('Ajouter la question'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTextField(
      TextEditingController controller, String labelText, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(labelText: labelText),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Veuillez entrer une option';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              // Mettre à jour correctOptions lorsque l'option est modifiée
              _correctOptions[index] = value
                  .isNotEmpty; // true si l'option n'est pas vide, sinon false
              // Marquer l'option comme sélectionnée
              _selectedOptions[index] = true;
            });
          },
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            final ImagePicker _picker = ImagePicker();
            final XFile? image =
                await _picker.pickImage(source: ImageSource.gallery);

            if (image != null) {
              // L'image a été sélectionnée, maintenant vous pouvez la déplacer vers le dossier assets
              // et obtenir son chemin d'accès
              String imagePath = await _moveImageToAssets(image);
              if (imagePath.isNotEmpty) {
                // L'image a été déplacée avec succès, vous pouvez l'ajouter à la liste d'options
                setState(() {
                  _options[index]['imagePath'] = imagePath;
                });
              }
            }
          },
          child: Text('Sélectionner une image'),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  void dispose() {
    _questionTextController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    _option4Controller.dispose();
    _chapterController.dispose(); // Disposer du contrôleur du chapitre
    _lessonController.dispose(); // Disposer du contrôleur de la leçon
    super.dispose();
  }
}
