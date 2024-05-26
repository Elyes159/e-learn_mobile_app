// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FrenchCourse extends StatefulWidget {
  @override
  _FrenchCourseState createState() => _FrenchCourseState();
}

class _FrenchCourseState extends State<FrenchCourse> {
  String? selectedCourseCode;

  void _loadCourseCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedCourseCode = prefs.getString('courseCode');
    });
  }

  Future<List<Map<String, dynamic>>> getCourseData() async {
    try {
      // Initialize variables to store document counts
      int totalBonjourDocs = 0;
      int totalJeParleDocs = 0;
      int totalJeConnaisDocs = 0;

      int totalBonjourFields = 0;
      int totalJeParleFields = 0;
      int totalJeConnaisFields = 0;

      if (selectedCourseCode == "fr") {
        QuerySnapshot<Map<String, dynamic>> bonjourSnapshot =
            await FirebaseFirestore.instance
                .collection('cours')
                .doc(selectedCourseCode)
                .collection('bonjour')
                .get();
        totalBonjourDocs = bonjourSnapshot.size;

        // Count documents in the 'cours<selectedCourseCode>' collection under 'je_parle' doc
        QuerySnapshot<Map<String, dynamic>> jeParleSnapshot =
            await FirebaseFirestore.instance
                .collection('cours')
                .doc("je_parle")
                .collection('lecons')
                .get();
        totalJeParleDocs = jeParleSnapshot.size;

        // Count documents in the 'cours<selectedCourseCode>' collection under 'je_connais' doc
        QuerySnapshot<Map<String, dynamic>> jeConnaisSnapshot =
            await FirebaseFirestore.instance
                .collection('cours')
                .doc("je_connais")
                .collection('lecons')
                .get();
        totalJeConnaisDocs = jeConnaisSnapshot.size;
      } else {
        QuerySnapshot<Map<String, dynamic>> bonjourSnapshot =
            await FirebaseFirestore.instance
                .collection('cours$selectedCourseCode')
                .doc('bonjour')
                .collection('lecons')
                .get();
        totalBonjourDocs = bonjourSnapshot.size;
        print("eseebiii $totalBonjourDocs");

        // Count documents in the 'cours<selectedCourseCode>' collection under 'je_parle' doc
        QuerySnapshot<Map<String, dynamic>> jeParleSnapshot =
            await FirebaseFirestore.instance
                .collection('cours$selectedCourseCode')
                .doc("je_parle")
                .collection('lecons')
                .get();
        totalJeParleDocs = jeParleSnapshot.size;

        // Count documents in the 'cours<selectedCourseCode>' collection under 'je_connais' doc
        QuerySnapshot<Map<String, dynamic>> jeConnaisSnapshot =
            await FirebaseFirestore.instance
                .collection('cours$selectedCourseCode')
                .doc("je_connais")
                .collection('lecons')
                .get();
        totalJeConnaisDocs = jeConnaisSnapshot.size;
      }

      // Fetch course data from Firestore
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('user_levels')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('courses')
              .where('code', isEqualTo: selectedCourseCode)
              .get();

      querySnapshot.docs
          .forEach((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        doc.data().forEach((key, value) {
          if (key.contains('bonjour')) {
            totalBonjourFields++;
          }
          if (key.contains('je_parle')) {
            totalJeParleFields++;
          }
          if (key.contains('je_connais')) {
            totalJeConnaisFields++;
          }
        });
      });

      // Calculate percentages
      double progressIntro = (totalBonjourDocs > 0)
          ? (totalBonjourFields / totalBonjourDocs) * 100
          : 0;
      double progressVocabulary = (totalJeParleDocs > 0)
          ? (totalJeParleFields / totalJeParleDocs) * 100
          : 0;
      double progressGrammar = (totalJeConnaisDocs > 0)
          ? (totalJeConnaisFields / totalJeConnaisDocs) * 100
          : 0;

      List<Map<String, dynamic>> courseDataList = querySnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        return {
          'code': doc['code'],
          'progressIntro': progressIntro,
          'progressVocabulary': progressVocabulary,
          'progressGrammar': progressGrammar,
        };
      }).toList();

      return courseDataList;
    } catch (error) {
      print('Error fetching course data: $error');
      // Handle errors based on your use case
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCourseCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
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
          iconSize: 80.0,
        ),
      ),
      body: ListView(
        children: [
          Center(
            child: Image.asset(
              selectedCourseCode == "fr"
                  ? "assets/eiffel.png"
                  : selectedCourseCode == "en"
                      ? "assets/liberte.png"
                      : selectedCourseCode == "ar"
                          ? "assets/kaaba.png"
                          : selectedCourseCode == "es"
                              ? "assets/sagrada-familia.png"
                              : selectedCourseCode == "hi"
                                  ? "assets/taj-mahal.png"
                                  : "images/logo.png",
              width: 150,
              height: 150,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              selectedCourseCode == "fr"
                  ? "Learn French"
                  : selectedCourseCode == "en"
                      ? "Learn English"
                      : selectedCourseCode == "ar"
                          ? "Learn Arabic"
                          : selectedCourseCode == "es"
                              ? "Learn Spanish"
                              : selectedCourseCode == "hi"
                                  ? "Learn Hindi"
                                  : "",
              style: GoogleFonts.poppins(
                fontSize: 25,
                color: Color(0xFF43463F),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Column(
            children: [
              FutureBuilder<List<Map<String, dynamic>>>(
                future: getCourseData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Map<String, dynamic>> courseDataList =
                        snapshot.data ?? [];

                    // Recherchez les données pour le code 'fr'
                    Map<String, dynamic>? courseFrData;
                    for (var courseData in courseDataList) {
                      if (courseData['code'] == selectedCourseCode) {
                        courseFrData = courseData;
                        break;
                      }
                    }

                    if (courseFrData != null) {
                      double progressIntro = courseFrData['progressIntro'] ?? 0;
                      String formattedProgressIntro =
                          progressIntro.toStringAsFixed(1);
                      return InkWell(
                        onTap: () {
                          print("behi");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 310,
                            height: 77,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    height: 56,
                                    width: 50.13,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF8BC34A),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset("assets/Handshake.png"),
                                        Text(
                                          "LEVEL 1",
                                          style: GoogleFonts.robotoMono(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Introduction",
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          width: 200,
                                          child: LinearProgressIndicator(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Color(0xFF8BC34A),
                                            backgroundColor: Color(0xFFE5E5E5),
                                            value:
                                                progressIntro.toDouble() / 100,
                                            minHeight: 8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8, top: 25),
                                  child: Container(
                                      child: Text("$formattedProgressIntro%")),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      // Gérer le cas où le code 'fr' n'est pas trouvé
                      return Text('Course data for code "fr" not found.');
                    }
                  }
                },
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: getCourseData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Map<String, dynamic>> courseDataList =
                        snapshot.data ?? [];

                    // Recherchez les données pour le code 'fr'
                    Map<String, dynamic>? courseFrData;
                    for (var courseData in courseDataList) {
                      if (courseData['code'] == selectedCourseCode) {
                        courseFrData = courseData;
                        break;
                      }
                    }

                    if (courseFrData != null) {
                      double progressGrammar =
                          courseFrData['progressGrammar'] ?? 0;
                      String formattedProgressIntro =
                          progressGrammar.toStringAsFixed(1);

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 310,
                          height: 77,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  height: 56,
                                  width: 50.13,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFBB237),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/BookBookmark.png"),
                                      Text(
                                        "LEVEL 2",
                                        style: GoogleFonts.robotoMono(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Grammar",
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        width: 200,
                                        child: LinearProgressIndicator(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Color(0xFFFFA000),
                                          backgroundColor: Color(0xFFE5E5E5),
                                          value:
                                              progressGrammar.toDouble() / 100,
                                          minHeight: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8, top: 25),
                                child: Container(
                                    child: Text("$formattedProgressIntro%")),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      // Gérer le cas où le code 'fr' n'est pas trouvé
                      return Text('Course data for code "fr" not found.');
                    }
                  }
                },
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: getCourseData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<Map<String, dynamic>> courseDataList =
                        snapshot.data ?? [];

                    // Recherchez les données pour le code 'fr'
                    Map<String, dynamic>? courseFrData;
                    for (var courseData in courseDataList) {
                      if (courseData['code'] == selectedCourseCode) {
                        courseFrData = courseData;
                        break;
                      }
                    }

                    if (courseFrData != null) {
                      double progressVocabulary =
                          courseFrData['progressVocabulary'] ?? 0;
                      String formattedProgressIntro =
                          progressVocabulary.toStringAsFixed(1);

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 310,
                          height: 77,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  height: 56,
                                  width: 50.13,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFF4B4C),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/Fire.png"),
                                      Text(
                                        "LEVEL 3",
                                        style: GoogleFonts.robotoMono(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Vocabulary",
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        width: 200,
                                        child: LinearProgressIndicator(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Color(0xFFD72714),
                                          backgroundColor: Color(0xFFE5E5E5),
                                          value: progressVocabulary / 100,
                                          minHeight: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8, top: 25),
                                child: Container(
                                    child: Text("$formattedProgressIntro%")),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      // Gérer le cas où le code 'fr' n'est pas trouvé
                      return Text('Course data for code "fr" not found.');
                    }
                  }
                },
              ),
              SizedBox(
                height: 45,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed("frenshunities");
                },
                child: Container(
                  height: 70,
                  width: 236,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFF3DB2FF)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 60.0),
                          child: Text(
                            "Learn Now",
                            style: GoogleFonts.poppins(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 15.0),
                      //   child: InkWell(
                      //       onTap: () {
                      //         Navigator.of(context)
                      //             .pushReplacementNamed("frenshunities");
                      //       },
                      //       child: Image.asset("assets/Button - Next.png")),
                      // )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
