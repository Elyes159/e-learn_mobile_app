import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FrenchCourse extends StatefulWidget {
  @override
  _FrenchCourseState createState() => _FrenchCourseState();
}

class _FrenchCourseState extends State<FrenchCourse> {
  String selectedCourseCode = 'fr';

  Future<List<Map<String, dynamic>>> getCourseData() async {
    try {
      // Fetch course data from Firestore
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('user_levels')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('courses')
              .get();

      // Process the query snapshot and convert it to a list of maps
      List<Map<String, dynamic>> courseDataList = querySnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        return {
          'code': doc['code'],
          'progressIntro': doc['progressIntro'],
          'progressVocabulary': doc['progressVocabulary'],
          'progressGrammar': doc['progressGrammar'],
        };
      }).toList();

      return courseDataList;
    } catch (error) {
      print('Error fetching course data: $error');
      // You might want to handle errors more gracefully based on your use case
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Column(
        children: [
          Center(
            child: Image.asset(
              "assets/les_francais.png",
              width: 150,
              height: 150,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "Learn Frensh",
              style:
                  GoogleFonts.poppins(fontSize: 25, color: Color(0xFF43463F)),
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
                      if (courseData['code'] == 'fr') {
                        courseFrData = courseData;
                        break;
                      }
                    }

                    if (courseFrData != null) {
                      int progressIntro = courseFrData['progressIntro'] ?? 0.0;

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
                                  child:
                                      Container(child: Text("$progressIntro%")),
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
                      if (courseData['code'] == 'fr') {
                        courseFrData = courseData;
                        break;
                      }
                    }

                    if (courseFrData != null) {
                      int progressGrammar =
                          courseFrData['progressGrammar'] ?? 0;

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
                                child:
                                    Container(child: Text("$progressGrammar%")),
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
                      if (courseData['code'] == 'fr') {
                        courseFrData = courseData;
                        break;
                      }
                    }

                    if (courseFrData != null) {
                      int progressVocabulary =
                          courseFrData['progressVocabulary'] ?? 0;

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
                                    child: Text("$progressVocabulary%")),
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
              Container(
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
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed("frenshunities");
                          },
                          child: Image.asset("assets/Button - Next.png")),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
