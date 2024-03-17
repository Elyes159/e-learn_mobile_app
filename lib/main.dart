import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pfe_1/ML/image_picker.dart';
import 'package:pfe_1/admin/Login_admin.dart';
import 'package:pfe_1/admin/add_questions.dart';
import 'package:pfe_1/arabic_course/arabic_main.dart';
import 'package:pfe_1/chatt/chatt.dart';
import 'package:pfe_1/constant/LanguageProvider.dart';
import 'package:pfe_1/constant/language_const.dart';
import 'package:pfe_1/english_course/english_main.dart';
import 'package:pfe_1/french_course/bonjour/lecons/lecon2/lecon2.dart';
import 'package:pfe_1/french_course/bonjour/lecons/lecon3/lecon3.dart';
import 'package:pfe_1/french_course/bonjour/lecons/lecon4/lecon4.dart';
import 'package:pfe_1/french_course/bonjour/lecons/lecon5/lecon5.dart';
import 'package:pfe_1/french_course/bonjour/lecons/lecon6/lecon6.dart';
import 'package:pfe_1/french_course/bonjour/lecons/lecon7/lecon7.dart';
import 'package:pfe_1/french_course/bonjour/lecons/lecon8/lecon8.dart';
import 'package:pfe_1/french_course/bonjour/lecons/lecon9/lecon9.dart';
import 'package:pfe_1/french_course/frensh_main.dart';
import 'package:pfe_1/french_course/frensh_unities.dart';
import 'package:pfe_1/french_course/bonjour/lecons/lecon1/lecon1.dart';
import 'package:pfe_1/french_course/je_connais/lecons/lecon1/lecon1.dart';
import 'package:pfe_1/french_course/je_connais/lecons/lecon10/lecon10.dart';
import 'package:pfe_1/french_course/je_connais/lecons/lecon2/lecon2.dart';
import 'package:pfe_1/french_course/je_connais/lecons/lecon3/lecon3.dart';
import 'package:pfe_1/french_course/je_connais/lecons/lecon4/lecon4.dart';
import 'package:pfe_1/french_course/je_connais/lecons/lecon5/lecon5.dart';
import 'package:pfe_1/french_course/je_connais/lecons/lecon6/lecon6.dart';
import 'package:pfe_1/french_course/je_connais/lecons/lecon7/lecon7.dart';
import 'package:pfe_1/french_course/je_connais/lecons/lecon8/lecon8.dart';
import 'package:pfe_1/french_course/je_connais/lecons/lecon9/lecon9.dart';
import 'package:pfe_1/french_course/je_parle/lecons/lecon1/lecon1.dart';
import 'package:pfe_1/french_course/je_parle/lecons/lecon10/lecon10.dart';
import 'package:pfe_1/french_course/je_parle/lecons/lecon11/lecon11.dart';
import 'package:pfe_1/french_course/je_parle/lecons/lecon12/lecon12.dart';
import 'package:pfe_1/french_course/je_parle/lecons/lecon13/lecon13.dart';
import 'package:pfe_1/french_course/je_parle/lecons/lecon2/lecon2.dart';
import 'package:pfe_1/french_course/je_parle/lecons/lecon3/lecon3.dart';
import 'package:pfe_1/french_course/je_parle/lecons/lecon4/lecon4.dart';
import 'package:pfe_1/french_course/je_parle/lecons/lecon5/lecon5.dart';
import 'package:pfe_1/french_course/je_parle/lecons/lecon6/lecon6.dart';
import 'package:pfe_1/french_course/je_parle/lecons/lecon7/lecon7.dart';
import 'package:pfe_1/french_course/je_parle/lecons/lecon8/lecon8.dart';
import 'package:pfe_1/french_course/je_parle/lecons/lecon9/lecon9.dart';
import 'package:pfe_1/home/home.dart';
import 'package:pfe_1/services/firebase_options.dart';
import 'package:pfe_1/starting/signin.dart';
import 'package:pfe_1/starting/signup.dart';
import 'package:pfe_1/stages/stages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pfe_1/starting/welcome_signup.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: MaterialApp(
        home: MyApp(), // Replace with the actual widget you want to start with
      ),
    ),
  );
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
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('fr'),
        Locale('hi'), // Ajoutez la nouvelle langue (hindi)
        // autres langues supportées
      ],
      locale: _locale,
      home: _getStartScreen(),
      routes: {
        'stages': (context) => StagesPage(),
        'lecon1': (context) => ExLeconOne(),
        'lecon2': (context) => ExLecontwo(),
        'lecon3': (context) => ExLeconthree(),
        'lecon4': (context) => ExLeconfour(),
        'lecon5': (context) => ExLeconfive(),
        'lecon6': (context) => ExLeconSix(),
        'lecon7': (context) => ExLeconSeven(),
        'lecon8': (context) => ExLeconEight(),
        'lecon9': (context) => ExLeconNine(),
        'leconParle1': (context) => ExParleLeconOne(),
        'leconParle2': (context) => ExParleLecontwo(),
        'leconParle3': (context) => ExParleLeconthree(),
        'leconParle4': (context) => ExParleLeconfour(),
        'leconParle5': (context) => ExParleLeconfive(),
        'leconParle6': (context) => ExParleLeconSix(),
        'leconParle7': (context) => ExParleLeconSeven(),
        'leconParle8': (context) => ExParleLeconEight(),
        'leconParle9': (context) => ExParleLeconNine(),
        'leconParle10': (context) => ExParleLeconTen(),
        'leconParle11': (context) => ExParleLeconTwelve(),
        'leconParle12': (context) => ExParleLeconEleven(),
        'leconParle13': (context) => ExParleLeconThirteen(),
        'leconConnais1': (context) => ExConnaisLeconOne(),
        'leconConnais2': (context) => ExConnaisLecontwo(),
        'leconConnais3': (context) => ExConnaisLeconthree(),
        'leconConnais4': (context) => ExConnaisLeconfour(),
        'leconConnais5': (context) => ExConnaisLeconfive(),
        'leconConnais6': (context) => ExConnaisLeconSix(),
        'leconConnais7': (context) => ExConnaisLeconSeven(),
        'leconConnais8': (context) => ExConnaisLeconEight(),
        'leconConnais9': (context) => ExConnaisLeconNine(),
        'leconConnais10': (context) => ExConnaisLeconTen(),
        'frenshunities': (context) => FrenchUnities(),
        'home': (context) => HomeScreen(),
        'arabicCourse': (context) => ArabicCourse(),
        'frenchCourse': (context) => FrenchCourse(),
        'englishCourse': (context) => EnglishCourse(),
        "signup": (context) => const Signup(),
        "login": (context) => Login(),
        "chatt": (context) => ChatScreen(),
        "signup1": (context) => Signup1(),
        "loginadmin": (context) => LoginPageAdmin(),
        "addQuestionPage": (context) => AddSoundQuestionForm(),
      },
    );
  }

  Widget _getStartScreen() {
    if (FirebaseAuth.instance.currentUser == null) {
      return Login();
    } else {
      return ImagePickerDemo();
    }
  }
}
