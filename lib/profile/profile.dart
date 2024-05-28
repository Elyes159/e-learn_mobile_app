import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pfe_1/profile/privacy/privacy.dart';
import 'package:pfe_1/profile/settings/settings.dart';
import 'package:pfe_1/starting/signin.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with WidgetsBindingObserver {
  final ImagePicker _picker = ImagePicker();

  XFile? _image;
  File? imageFile;
  DateTime? _startTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print('Profile screen initialized');
    _startTime = DateTime
        .now(); // Initialise _startTime lors de l'initialisation de l'écran
  }

  @override
  void dispose() {
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

  Future<int> getNumberOfCourses() async {
    try {
      // Fetch the number of documents in the 'courses' collection
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

  void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Après la déconnexion réussie, vous pouvez naviguer vers une autre page ou effectuer d'autres actions si nécessaire
      // Par exemple, naviguer vers la page d'accueil :
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print("Erreur lors de la déconnexion: $e");
      // Gérer les erreurs de déconnexion ici, si nécessaire
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
        return (timeSpent / 3600)
            .toInt(); // Convertir les secondes en heures et retourner en tant qu'entier
      }
    }
    return null;
  }

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
            Navigator.of(context).pushReplacementNamed("home");
          },
          iconSize: 100.0,
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 50.0, right: 30),
          child: Center(
            child: Text(
              "My Profile",
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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Image.asset(
            'assets/Vector.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 600,
          ),
          SizedBox(height: 50),
          Column(
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
                child: Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).size.height - 601,
                  child: Container(
                    height: 1.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        FutureBuilder<int?>(
                          future: getTimeSpent(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              int? hoursSpent = snapshot.data;
                              if (hoursSpent != null) {
                                return Text(
                                  '$hoursSpent+ hours',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              } else {
                                return Text(
                                  'Time spent in app: 0 hours',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }
                            }
                          },
                        ),
                        Text(
                          "Total learn",
                          style: GoogleFonts.poppins(),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        FutureBuilder<int?>(
                          future: getNumberOfCourses(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              int? hoursSpent = snapshot.data;
                              if (hoursSpent != null) {
                                return Text(
                                  '$hoursSpent',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              } else {
                                return Text(
                                  '0',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }
                            }
                          },
                        ),
                        Text(
                          "Language",
                          style: GoogleFonts.poppins(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // Autres enfants de la colonne
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 0.0, top: 30, left: 30),
                              child: Row(
                                children: [
                                  Container(
                                    child: Image.asset("assets/settings.png"),
                                  ),
                                  Text(
                                    "     Settings",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(), // Ajouter un espace flexible pour pousser les éléments à droite
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Settingss()),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          right:
                                              10.0), // Ajouter un padding à droite pour l'image
                                      child:
                                          Image.asset("assets/CaretRight.png"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 0.0, top: 20, left: 30),
                              child: Row(
                                children: [
                                  Container(
                                    child: Image.asset("assets/achievment.png"),
                                  ),
                                  Text(
                                    "     Achievements",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 0.0, top: 20, left: 30),
                              child: Row(
                                children: [
                                  Container(
                                    child: Image.asset("assets/privacy.png"),
                                  ),
                                  Text(
                                    "     privacy",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(), // Ajouter un espace flexible pour pousser les éléments à droite
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Privacy()),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          right:
                                              10.0), // Ajouter un padding à droite pour l'image
                                      child:
                                          Image.asset("assets/CaretRight.png"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 110,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 120.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(right: 60.0),
                                child: Text(
                                  "My Account",
                                  style: GoogleFonts.poppins(),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Row(
                                  children: [
                                    // IconButton(
                                    //   onPressed: () {},
                                    //   icon: Icon(Icons.logout_outlined),
                                    // ),
                                    InkWell(
                                      onTap: () {
                                        _signOut(context);
                                      },
                                      child: Text(
                                        "     Logout Account",
                                        style: GoogleFonts.poppins(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
