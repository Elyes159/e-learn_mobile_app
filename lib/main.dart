import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pfe_1/ML/image_picker.dart';
import 'package:pfe_1/chapitre1/chapitre1.dart';
import 'package:pfe_1/chatt/chatt.dart';
import 'package:pfe_1/constant/language_const.dart';
import 'package:pfe_1/services/firebase_options.dart';
import 'package:pfe_1/starting/choice_lan.dart';
import 'package:pfe_1/starting/signin.dart';
import 'package:pfe_1/starting/signup.dart';
import 'package:pfe_1/stages/stages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((Locale) => setLocale(Locale));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: _getStartScreen(),
      routes: {
        'stages': (context) => StagesPage(),
        'chapitre1': (context) => Chapitre1(),
        "signup": (context) => const Signup(),
        "login": (context) => Login(),
        "chatt": (context) => ChatScreen(),
      },
    );
  }

  Widget _getStartScreen() {
    if (FirebaseAuth.instance.currentUser == null) {
      return ChoiceL();
    } else {
      return ImagePickerDemo();
    }
  }
}
