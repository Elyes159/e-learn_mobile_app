import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pfe_1/ML/image_picker.dart';
import 'package:pfe_1/chatt/chatt.dart';
import 'package:pfe_1/constant/textformfield.dart';
import 'package:pfe_1/profile/profile.dart';

class Privacy extends StatefulWidget {
  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> with WidgetsBindingObserver {
  final ImagePicker _picker = ImagePicker();
  TextEditingController age = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  XFile? _image;
  File? imageFile;
  DateTime? _startTime;

  Future<void> FetchUserData() async {
    email.text = (await getUserEmail())!;
    username.text = (await getUserName())!;
    age.text = (await getUserAge())!;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print('Privacy screen initialized');
    _startTime = DateTime.now();
    FetchUserData();
    username.addListener(updateUsernameInFirestore);
    email.addListener(updateEmailInFirestore);
    age.addListener(updateAgeInFirestore);
  }

  void updateUsernameInFirestore() {
    String newUsername = username.text;
    updateFieldInFirestore('username', newUsername);
  }

  // Méthode pour mettre à jour l'email dans Firestore
  void updateEmailInFirestore() {
    String newEmail = email.text;
    updateFieldInFirestore('email', newEmail);
  }

  // Méthode pour mettre à jour l'âge dans Firestore
  void updateAgeInFirestore() {
    String newAge = age.text;
    updateFieldInFirestore('age', newAge);
  }

  // Méthode générique pour mettre à jour un champ dans Firestore
  void updateFieldInFirestore(String fieldName, String newValue) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({fieldName: newValue});
        print('$fieldName updated successfully');
      } catch (e) {
        print('Error updating $fieldName: $e');
      }
    }
  }

  @override
  void dispose() {
    username.removeListener(updateUsernameInFirestore);
    email.removeListener(updateEmailInFirestore);
    age.removeListener(updateAgeInFirestore);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print('App resumed');
      _startTime = DateTime.now();
    } else if (state == AppLifecycleState.paused) {
      print('App paused');
      if (_startTime != null) {
        final endTime = DateTime.now();
        final duration = endTime.difference(_startTime!).inSeconds;
        print('Duration: $duration seconds');
        _updateUserTime(duration);
      }
    }
  }

  Future<void> _updateUserTime(int seconds) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(userRef);
        if (!snapshot.exists) {
          print('User document does not exist, creating new document');
          transaction.set(userRef, {'time_spent': seconds});
        } else {
          final currentTimeSpent = snapshot.data()?['time_spent'] ?? 0;
          print(
              'Updating time spent, current: $currentTimeSpent, adding: $seconds');
          transaction
              .update(userRef, {'time_spent': currentTimeSpent + seconds});
        }
      });
      print('Time updated successfully');
    } else {
      print('No user signed in');
    }
  }

  Future<int?> getNumberOfCourses() async {
    try {
      QuerySnapshot coursesSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .get();
      return coursesSnapshot.size;
    } catch (e) {
      print('Error fetching number of courses: $e');
      return 0;
    }
  }

  Future<int?> getTimeSpent() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        int timeSpent = snapshot.data()?['time_spent'] ?? 0;
        return (timeSpent / 3600).toInt();
      }
    }
    return null;
  }

  Future<void> uploadImage() async {
    if (imageFile != null) {
      try {
        String extension = imageFile!.path.split('.').last;
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          String filePath = 'images/${user.uid}.$extension';
          Reference ref = FirebaseStorage.instance.ref().child(filePath);
          UploadTask uploadTask = ref.putFile(imageFile!);
          TaskSnapshot storageTaskSnapshot =
              await uploadTask.whenComplete(() => null);
          String imageURL = await storageTaskSnapshot.ref.getDownloadURL();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({'imageURL': imageURL}, SetOptions(merge: true));
          print('Image uploaded successfully');
        }
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
        convertXFileToFile(_image);
      });
      uploadImage();
    } catch (e) {
      print('Error taking photo: $e');
    }
  }

  void convertXFileToFile(XFile? xFile) async {
    if (xFile != null) {
      imageFile = File(xFile.path);
    } else {
      imageFile = null;
    }
  }

  Future<String?> getImageURL() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        return snapshot.data()?['imageURL'];
      }
    }
    return null;
  }

  Future<String?> getUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        return snapshot.data()?['username'];
      }
    }
    return null;
  }

  Future<String?> getUserAge() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        return snapshot.data()?['age'];
      }
    }
    return null;
  }

  Future<String?> getUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        return snapshot.data()?['email'];
      }
    }
    return null;
  }

  void _showPasswordUpdateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Update Password',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Champs de texte pour le mot de passe actuel, le nouveau mot de passe et la confirmation
              TextFormField(
                controller: currentPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Current Password',
                    labelStyle: GoogleFonts.poppins(color: Color(0xFF3DB2FF)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(
                          color: Colors
                              .grey), // Bordure lorsqu'il n'est pas focalisé
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(
                          color: Colors.blue), // Bordure lorsqu'il est focalisé
                    ),
                    hintText: 'Enter current password',
                    hintStyle: GoogleFonts.poppins(color: Color(0xFF3DB2FF))),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  hintText: 'Enter new password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(
                        color: Colors
                            .grey), // Bordure lorsqu'il n'est pas focalisé
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(
                        color: Color(
                            0xFF3DB2FF)), // Bordure lorsqu'il est focalisé
                  ),
                  labelStyle: GoogleFonts.poppins(color: Color(0xFF3DB2FF)),
                  hintStyle: GoogleFonts.poppins(color: Color(0xFF3DB2FF)),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(color: Color(0xFF3DB2FF)),
                  ),
                  hintText: 'Confirm new password',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(
                        color: Colors
                            .grey), // Bordure lorsqu'il n'est pas focalisé
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(
                        color: Colors.blue), // Bordure lorsqu'il est focalisé
                  ),
                  labelStyle: GoogleFonts.poppins(color: Color(0xFF3DB2FF)),
                  hintStyle: GoogleFonts.poppins(color: Color(0xFF3DB2FF)),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _updatePassword,
              child: Text('Update'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF3DB2FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  int _currentIndex = 0;
  void navigateToLearn() {
    Navigator.of(context).pushReplacementNamed("arabicCourse");
  }

  void navigateToObjectTranslation() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ImagePickerDemo()),
    );
  }

  void navigateToAchievement() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatScreen()),
    );
  }

  void navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Profile()),
    );
  }

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void _updatePassword() async {
    try {
      String currentPassword = currentPasswordController.text;
      String newPassword = newPasswordController.text;
      String confirmPassword = confirmPasswordController.text;

      // Vérifie si les champs ne sont pas vides et si le nouveau mot de passe correspond à la confirmation
      if (currentPassword.isNotEmpty &&
          newPassword.isNotEmpty &&
          confirmPassword.isNotEmpty &&
          newPassword == confirmPassword) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.updatePassword(newPassword);
          print('Password updated successfully');
          // Ferme la boîte de dialogue
          Navigator.pop(context);
        }
      } else {
        print('Passwords do not match or some fields are empty');
      }
    } catch (e) {
      print('Error updating password: $e');
    }
  }

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF3DB2FF),
          toolbarHeight: 100,
          leading: IconButton(
            icon: Image.asset(
              "assets/Back_Button.png",
              height: 80.0,
              width: 80.0,
              fit: BoxFit.cover,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
            iconSize: 100.0,
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 50.0, right: 30),
            child: Center(
              child: Text(
                "My Privacy",
                style: GoogleFonts.poppins(
                  color: Color.fromARGB(255, 245, 243, 243),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/Vector.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 600,
            ),
            SizedBox(height: 50),
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: SizedBox(
                    height: 115,
                    width: 115,
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        FutureBuilder<String?>(
                          future: getImageURL(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              String? imageURL = snapshot.data;
                              if (imageURL != null) {
                                return CircleAvatar(
                                  backgroundImage: NetworkImage(imageURL),
                                );
                              } else {
                                return const Icon(Icons.person);
                              }
                            }
                          },
                        ),
                        Positioned(
                          right: -16,
                          bottom: 0,
                          child: SizedBox(
                            height: 46,
                            width: 46,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                backgroundColor: const Color(0xFFF5F6F9),
                                shape: CircleBorder(),
                              ),
                              onPressed: _takePhoto,
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 255, 254, 254)),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Column(
                        children: [
                          CustomTextForm(
                            hinttext: "username",
                            mycontroller: username,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          CustomTextForm(
                            hinttext: "email",
                            mycontroller: email,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          CustomTextForm(
                            hinttext: "age",
                            mycontroller: age,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: ElevatedButton(
                              onPressed: _showPasswordUpdateDialog,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Color(
                                    0xFF3DB2FF), // Couleur du texte du bouton
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical:
                                        12), // Espacement intérieur du bouton
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8), // Bord arrondi du bouton
                                ),
                              ),
                              child: Text(
                                'Update Password',
                                style: TextStyle(
                                  fontSize:
                                      16, // Taille de la police du texte du bouton
                                ),
                              ),
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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            switch (index) {
              case 0:
                navigateToLearn();
                break;
              case 1:
                navigateToObjectTranslation();
                break;
              case 2:
                navigateToAchievement();
                break;
              case 3:
                navigateToProfile();
                break;
              default:
                break;
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/BookOpenText.png', // Replace with your image path
                width: 24.0,
                height: 24.0,
                color: _currentIndex == 0 ? Color(0xFF3DB2FF) : null,
              ),
              label: "Learn",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/model1.png', // Replace with your image path
                width: 35.0,
                height: 35.0,
                color: _currentIndex == 1 ? Color(0xFF3DB2FF) : null,
              ),
              label: 'Object-Translation',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/Chat1.png',
                width: 24.0,
                height: 24.0,
                color: _currentIndex == 2 ? Color(0xFF3DB2FF) : null,
              ),
              label: 'chat',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/UserCircle.png', // Replace with your image path
                width: 24.0,
                height: 24.0,
                color: _currentIndex == 3 ? Color(0xFF3DB2FF) : null,
              ),
              label: 'Profile',
            ),
          ],
          selectedLabelStyle: GoogleFonts.poppins(),
          unselectedLabelStyle: GoogleFonts.poppins(),
          selectedItemColor: Color(0xFF3DB2FF),
        ));
  }
}
