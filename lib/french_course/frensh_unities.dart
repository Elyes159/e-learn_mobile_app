import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_1/constant/lecon.dart';

class FrenshUnities extends StatefulWidget {
  @override
  _FrenshUnitiesState createState() => _FrenshUnitiesState();
}

class _FrenshUnitiesState extends State<FrenshUnities> {
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
        // Le document existe avec le code 'fr'
        // Vous pouvez accéder aux données du premier document trouvé (courseSnapshot.docs[0])
        // et vérifier la valeur actuelle du champ 'lecon1Bonjour'

        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon1Bonjour') ?? false;

        return lecon1BonjourExists;
      } else {
        // Le document avec le code 'fr' n'existe pas
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
        )),
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
                  color: Color(0xFF3DB2FF),
                ),
                duration: Duration(milliseconds: 0),
                height: isExpanded ? 400 : 70,
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
                                fontWeight: FontWeight.w500),
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
                            right: 20, left: 20, bottom: 20, top: 5),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                if (checkLecon1BonjourExistence() == true) ...[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 50.0),
                                    child: Image.asset("assets/cocher.png"),
                                  ),
                                ],
                                Lecon(
                                  imagePath: "assets/tableau-a-feuilles.png",
                                  leconTitle: "Lecon 1",
                                ),
                              ],
                            ),
                            Lecon(
                                imagePath: "assets/tableau-a-feuilles.png",
                                leconTitle: "Lecon 2"),
                            Lecon(
                                imagePath: "assets/tableau-a-feuilles.png",
                                leconTitle: "Lecon 3"),
                            Lecon(
                                imagePath: "assets/tableau-a-feuilles.png",
                                leconTitle: "Lecon 4"),
                            Lecon(
                                imagePath: "assets/tableau-a-feuilles.png",
                                leconTitle: "Lecon 5"),
                            Lecon(
                                imagePath: "assets/tableau-a-feuilles.png",
                                leconTitle: "Lecon 6"),
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
                  color: Color(0xFF3DB2FF),
                ),
                duration: Duration(milliseconds: 300),
                height: isExpanded1 ? 200 : 70,
                width: screenWidth,
                child: Column(
                  children: [
                    Text(
                      "Bonjour",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 20),
                    ),
                    if (isExpanded1)
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: screenWidth,
                            child: Row(
                              children: [
                                Image.asset("assets/tableau-a-feuilles.png")
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
