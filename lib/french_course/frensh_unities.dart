import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FrenchUnities extends StatefulWidget {
  @override
  _FrenchUnitiesState createState() => _FrenchUnitiesState();
}

class _FrenchUnitiesState extends State<FrenchUnities> {
  bool isExpanded = false;
  bool isExpanded1 = false;
  bool isExpanded2 = false;

  Future<bool> checkLeconExistence(int leconNumber, String chapter) async {
    try {
      var courseSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('courses')
          .where('code', isEqualTo: 'fr')
          .get();

      if (courseSnapshot.docs.isNotEmpty) {
        bool lecon1BonjourExists =
            courseSnapshot.docs[0].get('lecon${leconNumber}${chapter}') ??
                false;

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

  Future<List<String>> getLeconsIDs(String chapter) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cours')
          .doc(chapter)
          .collection('lecons')
          .get();

      List<String> leconIDs = querySnapshot.docs.map((doc) => doc.id).toList();
      return leconIDs;
    } catch (e) {
      print('Erreur lors de la récupération des IDs des leçons : $e');
      return [];
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
                child: FutureBuilder<List<String>>(
                  future: getLeconsIDs("bonjour"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox();
                    } else if (snapshot.hasError) {
                      return Text('Erreur : ${snapshot.error}');
                    } else {
                      List<String> leconIDs = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: leconIDs.length,
                        itemBuilder: (context, index) {
                          int leconNumber = index + 1;
                          return ListTile(
                            title: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed("lecon$leconNumber");
                              },
                              child: Text(
                                'Leçon $leconNumber',
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                            ),
                            trailing: FutureBuilder<bool>(
                              future:
                                  checkLeconExistence(leconNumber, "Bonjour"),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox();
                                } else if (snapshot.hasError) {
                                  return Text('Erreur : ${snapshot.error}');
                                } else {
                                  bool leconExists = snapshot.data ?? false;
                                  return leconExists
                                      ? Image.asset(
                                          "assets/verifie.png",
                                          width: 30,
                                        )
                                      : SizedBox();
                                }
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
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
                height: isExpanded1 ? 630 : 70,
                width: screenWidth,
                child: FutureBuilder<List<String>>(
                  future: getLeconsIDs("je_parle"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox();
                    } else if (snapshot.hasError) {
                      return Text('Erreur : ${snapshot.error}');
                    } else {
                      List<String> leconIDs = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: leconIDs.length,
                        itemBuilder: (context, index) {
                          int leconNumber = index + 1;
                          return ListTile(
                            title: InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacementNamed(
                                    "leconParle$leconNumber");
                              },
                              child: Text(
                                'Leçon $leconNumber',
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                            ),
                            trailing: FutureBuilder<bool>(
                              future: checkLeconExistence(leconNumber, "Parle"),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox();
                                } else if (snapshot.hasError) {
                                  return Text('Erreur : ${snapshot.error}');
                                } else {
                                  bool leconExists = snapshot.data ?? false;
                                  return leconExists
                                      ? Image.asset(
                                          "assets/verifie.png",
                                          width: 30,
                                        )
                                      : SizedBox();
                                }
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
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
                height: isExpanded2 ? 800 : 70,
                width: screenWidth,
                child: FutureBuilder<List<String>>(
                  future: getLeconsIDs("je_connais"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox();
                    } else if (snapshot.hasError) {
                      return Text('Erreur : ${snapshot.error}');
                    } else {
                      List<String> leconIDs = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: leconIDs.length,
                        itemBuilder: (context, index) {
                          int leconNumber = index + 1;
                          return ListTile(
                            title: InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacementNamed(
                                    "leconConnais$leconNumber");
                              },
                              child: Text(
                                'Leçon $leconNumber',
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                            ),
                            trailing: FutureBuilder<bool>(
                              future:
                                  checkLeconExistence(leconNumber, "Connais"),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox();
                                } else if (snapshot.hasError) {
                                  return Text('Erreur : ${snapshot.error}');
                                } else {
                                  bool leconExists = snapshot.data ?? false;
                                  return leconExists
                                      ? Image.asset(
                                          "assets/verifie.png",
                                          width: 30,
                                        )
                                      : SizedBox();
                                }
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
