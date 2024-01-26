import 'package:flutter/material.dart';
import 'package:pfe_1/constant/language_const.dart';
import 'package:pfe_1/constant/languages.dart';
import 'package:pfe_1/main.dart';
import 'package:pfe_1/starting/signin.dart';

class ChoiceL extends StatefulWidget {
  @override
  _ChoiceLState createState() => _ChoiceLState();
}

class _ChoiceLState extends State<ChoiceL> {
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
                Navigator.of(context).push(PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Login()));
                print('Langue sélectionnée : ${language.languageCode}');
                Locale _locale = await setLocale(language.languageCode);
                MyApp.setLocale(context, _locale);
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
