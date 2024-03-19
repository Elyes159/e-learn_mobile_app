import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FrenchUnities extends StatefulWidget {
  @override
  _FrenchUnitiesState createState() => _FrenchUnitiesState();
}

class _FrenchUnitiesState extends State<FrenchUnities> {
  late List<DocumentSnapshot> courses = [];

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    final snapshot = await FirebaseFirestore.instance.collection('cours').get();
    setState(() {
      courses = snapshot.docs;
    });
  }

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
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return LessonListPage(course: course);
              }));
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF3DB2FF),
                ),
                duration: const Duration(milliseconds: 0),
                height: 70,
                width: screenWidth,
                child: Center(
                  child: Text(
                    course.id,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LessonListPage extends StatelessWidget {
  final DocumentSnapshot course;

  const LessonListPage({Key? key, required this.course}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.id),
      ),
      body: FutureBuilder<List<int>>(
        future: getLessonIDs(course.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else {
            List<int> lessonIDs = snapshot.data ?? [];
            return ListView.builder(
              itemCount: lessonIDs.length,
              itemBuilder: (context, index) {
                int lessonNumber = lessonIDs[index];
                return ListTile(
                  title: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                        course.id == 'bonjour'
                            ? "lecon1"
                            : course.id == 'je_parle'
                                ? "leconParle1"
                                : course.id == 'je_connais'
                                    ? "leconConnais1"
                                    : "lecon1",
                        arguments: {
                          'leconId': lessonNumber,
                          'chapter': course.id,
                        },
                      );
                    },
                    child: Text('Leçon $lessonNumber'),
                  ),
                  // Ajoutez le code pour vérifier si la leçon existe ici
                  trailing: FutureBuilder<bool>(
                    future: checkLeconExistence(lessonNumber, course.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
    );
  }

  Future<List<int>> getLessonIDs(String courseId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('cours')
        .doc(courseId)
        .collection('lecons')
        .get();
    final lessonCount = snapshot.docs.length;
    return List<int>.generate(lessonCount, (index) => index + 1);
  }
}
