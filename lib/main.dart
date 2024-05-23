import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pfe_1/addQuestiontoFirestore.dart';
import 'package:pfe_1/admin/Login_admin.dart';
import 'package:pfe_1/admin/add_course.dart';
import 'package:pfe_1/admin/add_lecon.dart';
import 'package:pfe_1/admin/Add_Questions/add_questions.dart';
import 'package:pfe_1/admin/admin_page_main.dart';
import 'package:pfe_1/admin/users.dart';
import 'package:pfe_1/arabic_course/arabic_main.dart';
import 'package:pfe_1/chatt/chatt.dart';
import 'package:pfe_1/constant/LanguageProvider.dart';
import 'package:pfe_1/constant/language_const.dart';
import 'package:pfe_1/french_course/frensh_main.dart';
import 'package:pfe_1/french_course/frensh_unities.dart';
import 'package:pfe_1/french_course/lecons/lecons.dart';
import 'package:pfe_1/home/home.dart';
import 'package:pfe_1/services/firebase_options.dart';
import 'package:pfe_1/starting/signin.dart';
import 'package:pfe_1/starting/signup.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pfe_1/starting/welcome_signup.dart';
import 'package:pfe_1/theme/apptheme.dart';
import 'package:pfe_1/theme/themeNotifier.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: MyApp(),
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
  ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.light);
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => setLocale(locale));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeNotifier(
      themeModeNotifier: _themeMode,
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: _themeMode,
        builder: (context, currentMode, child) {
          return MaterialApp(
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
              Locale('fr'),
              Locale('hi'),
            ],
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: currentMode,
            locale: _locale,
            home: _getStartScreen(),
            routes: {
              'lecons': (context) => ExLeconOne(),
              'frenshunities': (context) => FrenchUnities(),
              'home': (context) => HomeScreen(),
              'Course': (context) => FrenchCourse(),
              "signup": (context) => const Signup(),
              "login": (context) => Login(),
              "chatt": (context) => ChatScreen(),
              "signup1": (context) => Signup1(),
              "loginadmin": (context) => LoginPageAdmin(),
              "addQuestionPage": (context) => AddQuestionForm(),
              "mainAdminPage": (context) => Admin_main(),
              "usersPage": (context) => UserListPage(),
              "AddLeconFromAdmin": (context) => AddLessonForm(),
              'AddCourseAdmin': (context) => NewCourseForm(),
              "addQuestiontofirestore": (context) => SampleQuestionsWidget(),
            },
          );
        },
      ),
    );
  }

  Widget _getStartScreen() {
    if (FirebaseAuth.instance.currentUser == null) {
      return Login();
    } else {
      return HomeScreen();
    }
  }
}
