import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:pfe_1/constant/custombutton.dart';
import 'package:pfe_1/constant/customlogo.dart';
import 'package:pfe_1/constant/textformfield.dart';
import 'package:pfe_1/constant/language_const.dart';
import 'package:pfe_1/constant/languages.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  File? _imageFile;

  Future<String?> uploadImage() async {
    try {
      if (_imageFile != null) {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

        await ref.putFile(_imageFile!);

        String imageUrl = await ref.getDownloadURL();
        return imageUrl;
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future<void> _chooseImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Customlogo(),
                const SizedBox(height: 20),
                const Text(
                  "Register",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Enter your personal Information",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Username",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                CustomTextForm(
                  hinttext: "Enter Your Username",
                  mycontroller: username,
                ),
                const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                CustomTextForm(
                  hinttext: "Enter Your Email",
                  mycontroller: email,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: "Poppins-Black",
                  ),
                ),
                SizedBox(height: 15),
                CustomTextForm(
                  hinttext: "Enter Your Password",
                  mycontroller: password,
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: _chooseImage,
                  child: Center(
                    child: _imageFile == null
                        ? const Text(
                            'Select Profile Image',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        : Image.file(
                            _imageFile!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: CustomButton(
                    title: "Signup",
                    onPressed: () async {
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(credential.user!.uid)
                            .set({
                          'username': username.text,
                          'email': email.text,
                          'progressValue': 0.0,
                          'xp': 0,
                          'xpProgress': 0.0,
                          'xpLevel': 1,
                          // Ajoutez d'autres champs que vous souhaitez enregistrer
                        });

                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushReplacementNamed("login");
                        FirebaseAuth.instance.currentUser!
                            .sendEmailVerification();
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("login");
                  },
                  child: Center(
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "Have An Account ? ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
