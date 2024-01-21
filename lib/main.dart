import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pfe_1/chapitre1/chapitre1.dart';
import 'package:pfe_1/services/firebase_options.dart';
import 'package:pfe_1/signin&signup/signin.dart';
import 'package:pfe_1/signin&signup/signup.dart';
import 'package:pfe_1/stages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseAuth.instance.currentUser == null ? Login() : StagesPage(),
      routes: {
        'stages': (context) => StagesPage(),
        'chapitre1': (context) => Chapitre1(),
        "signup": (context) => const Signup(),
        "login": (context) => Login(),
      },
    );
  }
}
