import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_1/ML/image_picker.dart';
import 'package:pfe_1/chatt/chatt.dart';
import 'package:pfe_1/constant/courses.dart';
import 'package:pfe_1/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? currentUser;
  String? username;
  int _currentIndex = 0;
  void saveFCMToken() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({'fcmToken': token}, SetOptions(merge: true));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    saveFCMToken();
  }

  void navigateToObjectTranslation() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ImagePickerDemo()),
    );
  }

  void navigateToAchievement() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ChatScreen()),
    );
  }

  void navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Profile()),
    );
  }

  getToken() async {
    String? mytoken = await FirebaseMessaging.instance.getToken();
    print("#####################################");
    print(mytoken);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getCourseDataByIndex(
      int index) async {
    try {
      // Fetch course data for a specific course from Firestore
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('user_levels')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('courses')
              .get();

      if (querySnapshot.docs.length > index) {
        // Check if the index is within the bounds of the available courses
        DocumentSnapshot<Map<String, dynamic>> courseDocument =
            querySnapshot.docs[index];
        return courseDocument;
      } else {
        // Return an empty document if the index is out of bounds
        return FirebaseFirestore.instance.doc('user_levels/empty_doc').get();
      }
    } catch (error) {
      print('Error fetching course data: $error');
      // Handle errors according to your needs
      throw error;
    }
  }

  Future<bool> doesUserHaveCourses(String userId) async {
    try {
      final coursesDocSnapshot = await FirebaseFirestore.instance
          .collection('user_levels')
          .doc(userId)
          .collection('courses')
          .get();

      return coursesDocSnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Erreur lors de la vérification des cours de l\'utilisateur : $e');
      return false;
    }
  }

// Dans votre widget _buildAge() ou tout autre endroit approprié :
// Dans votre widget _buildAge() ou tout autre endroit approprié :
  Widget _buildAge() {
    return FutureBuilder<bool>(
      future: doesUserHaveCourses(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Afficher un indicateur de chargement si nécessaire
          return Center(child: Text("Loading ..."));
        } else if (snapshot.hasError) {
          // Afficher un message d'erreur si la vérification échoue
          return Text('Erreur : ${snapshot.error}');
        } else {
          // L'utilisateur a des cours, affichez le Row
          return _buildRowWithCourses();
        }
      },
    );
  }

  Widget _buildRowWithCourses() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future:
          getCourseData(), // Assuming getCourseData returns a list of maps with course data including userLevel
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while fetching data
          return Center(child: Text("Loading ..."));
        } else if (snapshot.hasError) {
          // Display an error message if fetching data fails
          return Text('Error: ${snapshot.error}');
        } else {
          // Build the row with green containers based on the course data
          List<Map<String, dynamic>> courseDataList = snapshot.data ?? [];
          List<Widget> greenContainers = courseDataList.map((courseData) {
            String courseName = courseData['name'];
            int userLevel = courseData['userLevel'];
            String courseCode = courseData['code'];

            return Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green,
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                ),
                width: 165,
                height: 93,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            courseName,
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '$userLevel Level ',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: InkWell(
                        onTap: () async {
                          // Store courseCode in SharedPreferences
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString('courseCode', courseCode);

                          Navigator.of(context).pushReplacementNamed("Course");
                        },
                        child: Image.asset("assets/Icon.png"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList();

          return Container(
            height: 93,
            width: 165,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildContainerWithoutCourses(),
                SizedBox(width: 8),
                // Add the green containers to the row
                ...greenContainers,
                // Add the container without courses
              ],
            ),
          );
        }
      },
    );
  }

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
          'name': doc['name'] as String,
          'userLevel': doc['userLevel'] as int,
          'code': doc['code'] as String,
        };
      }).toList();

      return courseDataList;
    } catch (error) {
      print('Error fetching course data: $error');
      // You might want to handle errors more gracefully based on your use case
      throw error;
    }
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

  Widget _buildContainerWithoutCourses() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.transparent,
            border: Border.all(
              color: Colors.grey, // Couleur de la bordure
              width: 2.0, // Épaisseur de la bordure
            ),
          ),
          width: 175,
          height: 93,
          child: InkWell(
            onTap: () {
              // Show the dropdown menu when the user taps on the container
              _showCoursesDropdownMenu();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "Add a course",
                    style: GoogleFonts.poppins(),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.grey, width: 0.5)),
                      child: Icon(
                        Icons.add,
                        color: Color(0xFF3DB2FF),
                        size: 40,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCoursesDropdownMenu() async {
    // Get the list of courses from the CoursesManager
    List<Courses> coursesList = CoursesManager().coursess;

    // Build the list of DropdownMenuItem from the coursesList
    List<DropdownMenuItem<Courses>> dropdownMenuItems =
        coursesList.map((Courses course) {
      return DropdownMenuItem<Courses>(
        value: course,
        child: Row(
          children: [
            Text(course.name),
          ],
        ),
      );
    }).toList();

    // Show the dropdown menu
    Courses? selectedCourse;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a Course'),
          content: DropdownButton<Courses>(
            value: selectedCourse,
            items: dropdownMenuItems,
            onChanged: (Courses? newValue) {
              setState(() {
                selectedCourse = newValue;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                if (selectedCourse != null) {
                  // Vérifier si le cours existe déjà dans Firestore
                  var courseSnapshot = await FirebaseFirestore.instance
                      .collection('user_levels')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('courses')
                      .where('code', isEqualTo: selectedCourse!.code)
                      .get();

                  // Si le cours n'existe pas, l'ajouter à Firestore
                  if (courseSnapshot.docs.isEmpty) {
                    await FirebaseFirestore.instance
                        .collection('user_levels')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('courses')
                        .add({
                      'name': selectedCourse!.name,
                      'code': selectedCourse!.code,
                      'imageUrl': selectedCourse!.imageUrl,
                      'userLevel': 0,
                      'progressValue': 0,
                      'progressIntro': 0,
                      'progressGrammar': 0,
                      'progressVocabulary': 0,
                    });

                    print('Selected course added to Firestore');
                  } else {
                    print('Selected course already exists in Firestore');
                  }
                  setState(() {});
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Récupérer l'ID de l'utilisateur actuel
      String uid = user.uid;
      print(uid);
      // Utiliser l'ID pour récupérer les données de l'utilisateur depuis Firestore
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      // Extraire le champ "username" du snapshot
      if (userSnapshot.exists) {
        username = userSnapshot['username'];
      } else {
        print("not exsit");
      }
    }

    setState(() {
      currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF3DB2FF),
              ),
              height: 250, // Ajustez la hauteur comme nécessaire
              // Couleur bleue
              child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 100, left: 0),
                        child: Text(
                          'Hi, ${username ?? "Nom inconnu"}',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "What language",
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "would you like to learn?",
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, left: 30),
                    child: Image.asset(
                      "assets/home.png",
                      height: 140,
                      width: 140,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                  child: ListView(
                children: [
                  Center(
                      child: Text(
                    "Language Being Learned",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w600),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  _buildAge()
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8, bottom: 0),
              child: Container(
                height: 300,
                color: Colors.transparent,
                child: FutureBuilder<int>(
                  future: getNumberOfCourses(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      int numberOfCourses = snapshot.data ?? 0;

                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: numberOfCourses,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              height: 84,
                              width: 349,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: FutureBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                                future: getCourseDataByIndex(index),
                                builder: (context, courseSnapshot) {
                                  if (courseSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (courseSnapshot.hasError) {
                                    return Text(
                                        'Error: ${courseSnapshot.error}');
                                  } else if (!courseSnapshot.hasData ||
                                      courseSnapshot.data!.data() == null) {
                                    return Center(
                                        child: Text('No data available.'));
                                  } else {
                                    Map<String, dynamic> courseData =
                                        courseSnapshot.data!.data()!;
                                    String courseName =
                                        courseData['name'] ?? '';
                                    double progressValue = (courseData[
                                                    'progressIntro'] +
                                                courseData['progressGrammar'] +
                                                courseData[
                                                    'progressVocabulary']) /
                                            3 ??
                                        0;
                                    String formattedProgressValue =
                                        progressValue.toStringAsFixed(1);
                                    String image = courseData['imageUrl'];

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              shape: BoxShape
                                                  .circle, // Pour rendre l'image circulaire
                                            ),
                                            child: ClipOval(
                                              child: Image.asset(
                                                image,
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 8),
                                              Text(
                                                courseName,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100)),
                                                    width: 200,
                                                    child:
                                                        LinearProgressIndicator(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: Color(0xFF2FDB81),
                                                      backgroundColor:
                                                          Color(0xFFFFF5EE),
                                                      value:
                                                          progressValue / 100,
                                                      minHeight: 8,
                                                    ),
                                                  ),
                                                  Text(
                                                    "$formattedProgressValue%",
                                                    style:
                                                        GoogleFonts.poppins(),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            )
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
                'assets/Chat1.png', // Replace with your image path
                width: 24.0,
                height: 24.0,
                color: _currentIndex == 2 ? Color(0xFF3DB2FF) : null,
              ),
              label: 'Chat',
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
