import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_1/constant/lecon.dart';

class FrenchUnities extends StatefulWidget {
  @override
  _FrenchUnitiesState createState() => _FrenchUnitiesState();
}

class _FrenchUnitiesState extends State<FrenchUnities> {
  bool isExpanded = false;
  bool isExpanded1 = false;
  bool isExpanded2 = false;

  Future<bool> checkLecon1BonjourExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon1Bonjour') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon2BonjourExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon2Bonjour') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon3BonjourExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon3Bonjour') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon4BonjourExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon4Bonjour') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon5BonjourExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon5Bonjour') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon6BonjourExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon6Bonjour') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon7BonjourExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon7Bonjour') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon8BonjourExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon8Bonjour') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon1ParleExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon1Parle') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon2ParleExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon2Parle') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon3ParleExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon3Parle') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon4ParleExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon4Parle') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon5ParleExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon5Parle') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon6ParleExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon6Parle') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon7ParleExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon7Parle') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon8ParleExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon8Parle') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon9ParleExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon9Parle') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon10ParleExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon10Parle') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon11ParleExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon11Parle') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon12ParleExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon12Parle') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  Future<bool> checkLecon13ParleExistence() async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon13Parle') ?? false;

        return lecon1BonjourExists;
      } else {
        return false;
      }
    } catch (error) {
      print(
          'Erreur lors de la vérification de l\'existence du champ lecon1Bonjour: $error');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Cours",
            style: GoogleFonts.poppins(),
          ),
        ),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF3DB2FF),
                ),
                duration: const Duration(milliseconds: 0),
                height: isExpanded ? 630 : 70,
                width: screenWidth,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: Image.asset(
                            "assets/agitant-la-main.png",
                            width: 50,
                            height: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 140),
                          child: Text(
                            "Bonjour",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                          size: 40,
                        )
                      ],
                    ),
                    if (isExpanded)
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                          left: 20,
                          bottom: 20,
                          top: 5,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 1",
                                    navigator: "lecon1",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon1BonjourExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                          color: Colors.white);
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 2",
                                    navigator: "lecon2",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon2BonjourExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                          color: Colors.white);
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 3",
                                    navigator: "lecon3",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon3BonjourExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                          color: Colors.white);
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 4",
                                    navigator: "lecon4",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon4BonjourExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                          color: Colors.white);
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 5",
                                    navigator: "lecon5",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon5BonjourExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                          color: Colors.white);
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 6",
                                    navigator: "lecon6",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon6BonjourExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 7",
                                    navigator: "lecon7",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon7BonjourExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 8",
                                    navigator: "lecon8",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon8BonjourExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 9",
                                    navigator: "lecon9",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon8BonjourExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded1 = !isExpanded1;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF3DB2FF),
                ),
                duration: const Duration(milliseconds: 0),
                height: isExpanded1 ? 880 : 70,
                width: screenWidth,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: Image.asset(
                            "assets/parlant.png",
                            width: 50,
                            height: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 140),
                          child: Text(
                            "Je parle",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                          size: 40,
                        )
                      ],
                    ),
                    if (isExpanded1)
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                          left: 20,
                          bottom: 20,
                          top: 5,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 1",
                                    navigator: "leconParle1",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon1ParleExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 2",
                                    navigator: "leconParle2",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon2ParleExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 3",
                                    navigator: "leconParle3",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon3ParleExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 4",
                                    navigator: "leconParle4",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon4ParleExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 5",
                                    navigator: "leconParle5",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon5ParleExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 6",
                                    navigator: "leconParle6",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon6ParleExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 7",
                                    navigator: "leconParle7",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon7ParleExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 8",
                                    navigator: "leconParle8",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon8ParleExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 9",
                                    navigator: "leconParle9",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon9ParleExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 10",
                                    navigator: "leconParle10",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon10ParleExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      // Affiche l'image seulement si lecon1Bonjour existe
                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 11",
                                    navigator: "leconParle11",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon11ParleExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 12",
                                    navigator: "leconParle12",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon12ParleExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Lecon(
                                    imagePath: "assets/tableau-a-feuilles.png",
                                    leconTitle: "Lecon 13",
                                    navigator: "leconParle13",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                FutureBuilder<bool>(
                                  future: checkLecon13ParleExistence(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator(
                                        color: Colors.white,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur : ${snapshot.error}');
                                    } else {
                                      bool lecon1BonjourExists =
                                          snapshot.data ?? false;

                                      return lecon1BonjourExists
                                          ? Image.asset(
                                              'assets/cocher.png',
                                              width: 40,
                                              height: 40,
                                            )
                                          : const SizedBox(); // or any other widget you want to return when the condition is false
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded2 = !isExpanded2;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF3DB2FF),
                ),
                duration: const Duration(milliseconds: 0),
                height: isExpanded2 ? 700 : 70,
                width: screenWidth,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: Image.asset(
                            "assets/parlant.png",
                            width: 50,
                            height: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 140),
                          child: Text(
                            "Je parle",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                          size: 40,
                        )
                      ],
                    ),
                    if (isExpanded1)
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                          left: 20,
                          bottom: 20,
                          top: 5,
                        ),
                        child: Column(
                          children: [],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
