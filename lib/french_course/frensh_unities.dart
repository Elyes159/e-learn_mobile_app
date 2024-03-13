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
                height: isExpanded ? 600 : 70,
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
                                      return CircularProgressIndicator();
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
                                      return CircularProgressIndicator();
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
                            Lecon(
                              imagePath: "assets/tableau-a-feuilles.png",
                              leconTitle: "Lecon 3",
                              navigator: "lecon2",
                            ),
                            Lecon(
                              imagePath: "assets/tableau-a-feuilles.png",
                              leconTitle: "Lecon 4",
                              navigator: "lecon2",
                            ),
                            Lecon(
                              imagePath: "assets/tableau-a-feuilles.png",
                              leconTitle: "Lecon 5",
                              navigator: "lecon2",
                            ),
                            Lecon(
                              imagePath: "assets/tableau-a-feuilles.png",
                              leconTitle: "Lecon 6",
                              navigator: "lecon2",
                            ),
                            Lecon(
                              imagePath: "assets/tableau-a-feuilles.png",
                              leconTitle: "Lecon 7",
                              navigator: "lecon2",
                            ),
                            Lecon(
                              imagePath: "assets/tableau-a-feuilles.png",
                              leconTitle: "Lecon 8",
                              navigator: "lecon2",
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
              padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF3DB2FF),
                ),
                duration: const Duration(milliseconds: 300),
                height: isExpanded1 ? 200 : 70,
                width: screenWidth,
                child: Column(
                  children: [
                    Text(
                      "Bonjour",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    if (isExpanded1)
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: screenWidth,
                            child: Row(
                              children: [
                                Image.asset("assets/tableau-a-feuilles.png"),
                              ],
                            ),
                          )
                        ],
                      )
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
