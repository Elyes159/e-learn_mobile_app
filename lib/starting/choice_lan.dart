import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pfe_1/ML/image_picker.dart';
import 'package:pfe_1/constant/language_const.dart';
import 'package:pfe_1/constant/languages.dart';
import 'package:pfe_1/main.dart';

class ChoiceL extends StatefulWidget {
  @override
  _ChoiceLState createState() => _ChoiceLState();
}

class _ChoiceLState extends State<ChoiceL> {
  Language? selectedLanguage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choisissez une langue'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: Language.languageList().map((language) {
            return ElevatedButton(
              onPressed: () async {
                final User? user1 = FirebaseAuth.instance.currentUser;
                String? _uid = user1!.uid;
                selectedLanguage = language;
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(_uid)
                    .update({
                  'selectedLanguage': language.languageCode,
                });
                Locale _locale = await setLocale(language.languageCode);

                Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ImagePickerDemo()));
                print('Langue sélectionnée : ${language.languageCode}');
                if (selectedLanguage?.languageCode == "ar") {
                  MyApp.setLocale(context, const Locale('ar'));
                } else if (selectedLanguage?.languageCode == 'fr') {
                  MyApp.setLocale(context, const Locale('fr'));
                } else if (selectedLanguage?.languageCode == 'en') {
                  MyApp.setLocale(context, const Locale('en'));
                } else if (selectedLanguage?.languageCode == 'hi') {
                  MyApp.setLocale(context, const Locale('hi'));
                }
                ;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(language.flag, style: TextStyle(fontSize: 20)),
                  SizedBox(width: 8),
                  Text(language.name),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
