import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pfe_1/constant/custombutton.dart';
import 'package:pfe_1/constant/customlogo.dart';
import 'package:pfe_1/constant/textformfield.dart';
import 'package:pfe_1/home/home.dart';
import 'package:pfe_1/starting/choice_lan.dart';
import 'package:pfe_1/starting/welcome_signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credesaveUserState();ntial
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Customlogo(),
                SizedBox(height: 20),
                // Text(
                //   translation(context).loginn,
                //   style: GoogleFonts.poppins(
                //       fontSize: 30, fontWeight: FontWeight.bold),
                // ),
                SizedBox(height: 10),
                // Text(
                //   "Login to continue using the app",
                //   style: TextStyle(color: Colors.grey),
                // ),
                SizedBox(height: 20),
                Text(
                  "Input Your Email",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, fontSize: 18),
                ),
                SizedBox(height: 10),
                CustomTextForm(
                  hinttext: "",
                  mycontroller: email,
                ),
                SizedBox(height: 10),
                Text(
                  "Input Your Password",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                CustomTextForm(
                  hinttext: "",
                  mycontroller: password,
                  isPassword: true,
                ),
                InkWell(
                  onTap: () async {
                    if (email.text == "") {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('email not found'),
                            content: Text('please insert an exesting email'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Ferme la boîte de dialogue
                                },
                                child: Text('Fermer'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email.text);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Reset password'),
                          content: Text(
                              'if your email exist , we sended a reset password link'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Ferme la boîte de dialogue
                              },
                              child: Text('Fermer'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                      "Forgot password?",
                      textAlign: TextAlign.right,
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.grey[900]),
                    ),
                  ),
                ),
                SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: CustomButton(
                      title: "Login",
                      onPressed: () async {
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email.text,
                            password: password.text,
                          );
                          if (credential.user!.emailVerified) {
                            final User? user =
                                FirebaseAuth.instance.currentUser;
                            String? _uid = user!.uid;

                            DocumentSnapshot doc = await FirebaseFirestore
                                .instance
                                .collection('users')
                                .doc(_uid)
                                .get();

                            final data = doc.data() as Map<String,
                                dynamic>?; //  Spécifiez le type de data comme Map<String, dynamic>

                            if (doc.exists &&
                                data != null &&
                                data.containsKey('selectedLanguage')) {
                              // L'utilisateur a déjà sélectionné une langue, naviguez vers l'écran d'accueil
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                            } else {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => ChoiceL()),
                              );
                            }
                          } else {
                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Email not verified"),
                                  content: const Text(
                                      "Please verify your email to login."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Ferme la boîte de dialogue
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    SizedBox(
                      height: 80,
                      width: 160,
                      child: MaterialButton(
                        onPressed: () {
                          signInWithGoogle();
                        },
                        child: Text(
                          "Login With Google",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.grey[900]),
                        ),
                      ),
                    ),
                    SizedBox(width: 0),
                    Container(
                        height: 20,
                        width: 20,
                        child: Image.asset("assets/social.png"))
                  ],
                ),

                InkWell(
                  onLongPress: () {
                    Navigator.of(context).pushReplacementNamed("loginadmin");
                  },
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        transitionDuration: Duration.zero,
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Signup1()));
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Doesn't have account? ",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey)),
                          TextSpan(
                            text: " Register",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3DB2FF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
