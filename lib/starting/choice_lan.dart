import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  void initState() {
    super.initState();
    checkLanguageSelection();
  }

  Future<void> checkLanguageSelection() async {
    final User? user = FirebaseAuth.instance.currentUser;
    String? _uid = user!.uid;

    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();

    final data = doc.data() as Map<String,
        dynamic>?; // Spécifiez le type de data comme Map<String, dynamic>

    if (doc.exists && data != null && data.containsKey('selectedLanguage')) {
      // L'utilisateur a déjà sélectionné une langue, naviguez vers l'écran d'accueil
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quelle langue parles-tu?",
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
                  color: Color(0xFF3DB2FF),
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

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );

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
