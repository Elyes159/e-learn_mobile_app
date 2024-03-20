import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pfe_1/ML/image_picker.dart';
import 'package:pfe_1/admin/Login_admin.dart';
import 'package:pfe_1/admin/add_course.dart';
import 'package:pfe_1/admin/add_lecon.dart';
import 'package:pfe_1/admin/add_questions.dart';
import 'package:pfe_1/admin/admin_page_main.dart';
import 'package:pfe_1/admin/users.dart';
import 'package:pfe_1/arabic_course/arabic_main.dart';
import 'package:pfe_1/chatt/chatt.dart';
import 'package:pfe_1/constant/LanguageProvider.dart';
import 'package:pfe_1/constant/language_const.dart';
import 'package:pfe_1/english_course/english_main.dart';

import 'package:pfe_1/french_course/frensh_main.dart';
import 'package:pfe_1/french_course/frensh_unities.dart';
import 'package:pfe_1/french_course/lecons/lecons.dart';

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
        Locale('hi'),

        // autres langues supportées
      ],
      locale: _locale,
      home: _getStartScreen(),
      routes: {
        'stages': (context) => StagesPage(),
        'lecons': (context) => ExLeconOne(),
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
        "mainAdminPage": (context) => Admin_main(),
        "usersPage": (context) => UserListPage(),
        "AddLeconFromAdmin": (context) => AddLessonForm(),
        'AddCourseAdmin': (context) => NewCourseForm()
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
