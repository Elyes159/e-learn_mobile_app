import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_1/constant/language_const.dart';
import 'package:pfe_1/constant/languages.dart';
import 'package:pfe_1/home/home.dart';
import 'package:pfe_1/main.dart';

class ChoiceL extends StatefulWidget {
  @override
  _ChoiceLState createState() => _ChoiceLState();
}

class _ChoiceLState extends State<ChoiceL> {
  List<Language> languageList = Language.languageList();
  Language? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Language?",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 20), // Add spacing between text and dropdown
            Container(
              width: 200, // Set the width of the dropdown container
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF7885ff),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: DropdownButton<Language>(
                value: selectedLanguage,
                onChanged: (Language? language) async {
                  final User? user1 = FirebaseAuth.instance.currentUser;
                  String? _uid = user1!.uid;
                  selectedLanguage = language;
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(_uid)
                      .update({
                    'selectedLanguage': language!.languageCode,
                  });
                  Locale _locale = await setLocale(language.languageCode);

                  Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        HomeScreen(),
                  ));

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
                },
                items: languageList.map((Language language) {
                  return DropdownMenuItem<Language>(
                    value: language,
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
          ],
        ),
      ),
    );
  }
}
