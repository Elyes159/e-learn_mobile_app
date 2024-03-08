import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pfe_1/constant/LanguageProvider.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfe_1/constant/language_const.dart';
import 'package:tflite_v2/tflite_v2.dart';

class LanguageSelectionDialog extends StatefulWidget {
  final Function(String) onLanguageSelected;

  const LanguageSelectionDialog({required this.onLanguageSelected});

  @override
  _LanguageSelectionDialogState createState() =>
      _LanguageSelectionDialogState();
}

class _LanguageSelectionDialogState extends State<LanguageSelectionDialog> {
  String selectedLanguage = 'fr'; // Default language

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return AlertDialog(
      title: Text('Choose Language'),
      content: Column(
        children: [
          Text('Select the language for label translation:'),
          DropdownButton<String>(
            value: selectedLanguage,
            onChanged: (String? newValue) {
              setState(() {
                selectedLanguage = newValue!;
              });
            },
            items: <String>['en', 'fr', 'es', 'de', 'it', 'pt', 'ru']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            languageProvider.setLanguage(selectedLanguage);
            await updateSelectedLanguageInFirebase(selectedLanguage);
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }

  Future<void> updateSelectedLanguageInFirebase(String language) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDocRef =
          FirebaseFirestore.instance.collection("model").doc(user.uid);
      final modelLanguageRef = userDocRef.collection('model_language');

      // Check if a document exists
      final snapshot = await modelLanguageRef.get();
      if (snapshot.docs.isNotEmpty) {
        // Update the existing document
        await modelLanguageRef.doc(snapshot.docs.first.id).update({
          "modelLanguage": language,
        });
      } else {
        // Create a new document
        await modelLanguageRef.add({
          "modelLanguage": language,
        });
      }
    }
  }
}

class ImagePickerDemo extends StatefulWidget {
  @override
  _ImagePickerDemoState createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<ImagePickerDemo> {
  final ImagePicker _picker = ImagePicker();
  final translator = GoogleTranslator();
  String selectedLanguage = 'fr'; // Default language

  XFile? _image;
  File? file;
  var _recognitions;
  var v = "";

  @override
  void initState() {
    super.initState();
    // Utilize WidgetsBinding.instance?.addPostFrameCallback to ensure it runs after the build
    Future.delayed(Duration.zero, () {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        showLanguageDialog();
        loadModel();
      });
    });
  }

  Future<void> showLanguageDialog() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return LanguageSelectionDialog(
          onLanguageSelected: (selectedLanguage) {
            setState(() {
              this.selectedLanguage = selectedLanguage;
            });
          },
        );
      },
    );
  }

  Future<void> translateLabels(List<String> labels, String toLanguage) async {
    // La langue source est détectée automatiquement
    String fromLanguage = 'auto';

    List<String> translatedLabels = [];
    for (String label in labels) {
      String translatedLabel = await translate(label, fromLanguage, toLanguage);
      translatedLabels.add(translatedLabel);
    }

    setState(() {
      v = translatedLabels.join(", ");
    });
  }

  Future<String> translate(
      String sourceText, String fromLanguage, String toLanguage) async {
    var translation = await translator.translate(sourceText,
        from: fromLanguage, to: toLanguage);
    return translation.text;
  }

  Future<void> loadModel() async {
    // Charger le modèle une seule fois lors de l'initialisation
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
        file = File(image!.path);
      });
      detectimage(file!);
    } catch (e) {
      print('Error taking photo: $e');
    }
  }

  Future<String?> getModelLanguage() async {
    try {
      // Fetch model language from Firestore
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('model')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('model_language')
              .get();

      // Check if a document exists
      if (querySnapshot.docs.isNotEmpty) {
        // Return the model language directly
        return querySnapshot.docs.first['modelLanguage'] as String?;
      } else {
        // No document found
        return null;
      }
    } catch (error) {
      print('Error fetching model language: $error');
      return null;
    }
  }

  //String selectedLanguage = 'en'; // Default language
  bool _isInterpreterBusy = false;
  Future detectimage(File image) async {
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    while (_isInterpreterBusy) {
      await Future.delayed(Duration(milliseconds: 100));
    }

    // Définir l'état de l'interpréteur sur occupé
    setState(() {
      _isInterpreterBusy = true;
    });

    // Fetch the model language from Firestore
    String? modelLanguage = await getModelLanguage();

    // Default to 'en' if modelLanguage is null
    selectedLanguage = modelLanguage ?? 'en';

    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    List<String> labels = [];
    for (var recognition in recognitions!) {
      labels.add(recognition["label"]);
    }

    // Translate labels using the fetched model language
    await translateLabels(labels, selectedLanguage);

    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter TFlite'),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: const Icon(Icons.exit_to_app_rounded),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_image != null)
              Image.file(
                File(_image!.path),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              )
            else
              Text('No'),
            Text(
              translation(context).imagee,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _takePhoto,
              child: Text('Pick Image from Gallery'),
            ),
            SizedBox(height: 20),
            Text(v),
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, "stages");
              },
              child: Text("cliquer ici pour aller au stage "),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, "chatt");
              },
              child: Text("cliquer ici pour aller au chatt"),
            )
          ],
        ),
      ),
    );
  }
}
