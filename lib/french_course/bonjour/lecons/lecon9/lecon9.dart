// ignore_for_file: library_private_types_in_public_api, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_1/french_course/bonjour/lecons/lecon1/lecon1.dart';
import '../../../../constant/question.dart';

class ExLeconNine extends StatefulWidget {
  const ExLeconNine({super.key});

  @override
  _ExLeconNineState createState() => _ExLeconNineState();
}

class _ExLeconNineState extends State<ExLeconNine> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  double _progress = 0.0;

  List<dynamic> questions = [
    TextQuestion(
      '_____ habitons à paris',
      [
        Option1('Nous', 'assets/chat.png'),
        Option1('vous', 'assets/fille.png'),
        Option1("ils", 'assets/mere.png'),
        Option1('il', 'assets/main.png'),
      ],
      [false, false, false, false],
      [true, false, false, false],
    ),
    TextQuestion(
      'Ils ______ ici ',
      [
        Option1('habitent', 'assets/chat.png'),
        Option1('habitons', 'assets/fille.png'),
        Option1("habit", 'assets/mere.png'),
        Option1('habite', 'assets/main.png'),
      ],
      [false, false, false, false],
      [true, false, false, false],
    ),

    TextQuestion(
      'Elles ______ les croissants ',
      [
        Option1('mangeons', 'assets/chat.png'),
        Option1('mangent', 'assets/fille.png'),
        Option1("manges", 'assets/mere.png'),
        Option1('mange', 'assets/main.png'),
      ],
      [false, false, false, false],
      [false, true, false, false],
    ),

    TextQuestion(
      'Nous aim___ le chocolat ',
      [
        Option1('ent', 'assets/chat.png'),
        Option1('ez', 'assets/fille.png'),
        Option1("e", 'assets/mere.png'),
        Option1('ons', 'assets/main.png'),
      ],
      [false, false, false, false],
      [false, false, false, true],
    ),
    TextQuestion(
      'Nous ___ lire ',
      [
        Option1('aimons', 'assets/chat.png'),
        Option1('aime', 'assets/fille.png'),
        Option1("aimez", 'assets/mere.png'),
        Option1('aimes', 'assets/main.png'),
      ],
      [false, false, false, false],
      [true, false, false, false],
    ),
    TextQuestion(
      'Elles mang___ une pizza ',
      [
        Option1('ez', 'assets/chat.png'),
        Option1('eons', 'assets/fille.png'),
        Option1("ent", 'assets/mere.png'),
        Option1('es', 'assets/main.png'),
      ],
      [false, false, false, false],
      [false, false, true, false],
    ),
    TextQuestion(
      'Nous ____ une pizza ',
      [
        Option1('manges', 'assets/chat.png'),
        Option1('mangeons', 'assets/fille.png'),
        Option1("mangez", 'assets/mere.png'),
        Option1('mange', 'assets/main.png'),
      ],
      [false, false, false, false],
      [false, true, false, false],
    ),
    TranslationQuestion(
      originalText: "Ils",
      correctTranslation: "They",
      userTranslationn: '',
    ),
    TextQuestion(
      'Nous habit___ à Montréal. ',
      [
        Option1('ez', 'assets/chat.png'),
        Option1('e', 'assets/fille.png'),
        Option1("es", 'assets/mere.png'),
        Option1('ons', 'assets/main.png'),
      ],
      [false, false, false, false],
      [false, false, false, true],
    ),
    TextQuestion(
      'Elles _____ le français. ',
      [
        Option1('étudient', 'assets/chat.png'),
        Option1('étudies', 'assets/fille.png'),
        Option1("étudie", 'assets/mere.png'),
        Option1('étudiez', 'assets/main.png'),
      ],
      [false, false, false, false],
      [true, false, false, false],
    ),
    TextQuestion(
      'Nous _____, vous aimez , ils/elles aiment ',
      [
        Option1('aimons', 'assets/chat.png'),
        Option1('aimez', 'assets/fille.png'),
        Option1("aiment", 'assets/mere.png'),
        Option1('aime', 'assets/main.png'),
      ],
      [false, false, false, false],
      [true, false, false, false],
    ),
    TextQuestion(
      'Ils _____ les croissants',
      [
        Option1('mangeons', 'assets/chat.png'),
        Option1('mangent', 'assets/fille.png'),
        Option1("mangez", 'assets/mere.png'),
        Option1('manges', 'assets/main.png'),
      ],
      [false, false, false, false],
      [false, true, false, false],
    ),
    TranslationQuestion(
      originalText: "Ce sont des chiens",
      correctTranslation: "they are dogs",
      userTranslationn: '',
    ),
    Question(
      'the strawberries',
      [
        Option1('le croissant', 'assets/croissant.png'),
        Option1('la pizza', 'assets/pizza.png'),
        Option1("le fraises", 'assets/fraise.png'),
        Option1("pomme", 'assets/pomme.png'),
      ],
      [false, false, false, false],
      [true, false, false, false],
    ),
    Question(
      'a bee',
      [
        Option1("l'homme", 'assets/homme.png'),
        Option1('le chien', 'assets/chien.png'),
        Option1('une abeille', 'assets/abeille.png'),
        Option1('le cheval', 'assets/cheval.png'),
      ],
      [false, false, false, false],
      [false, false, false, true],
    ),

    // Add more questions as needed
  ];
  void _showBottomSheetTranslation(
      bool isCorrect, TranslationQuestion question) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: isCorrect ? Color(0xFFF5FFD8) : Color(0xFFFFDDD8),
              borderRadius: BorderRadius.circular(20)),
          height: 230.0,
          width: 350,
          // Adjust the height here
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      isCorrect
                          ? "That's right"
                          : "Ups.. That's not quite right \n",
                      style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: isCorrect ? Colors.green : Color(0xFFFF2442),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      isCorrect
                          ? "Amazing!....."
                          : "Answer : \n ${question.correctTranslation}",
                      style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                        color: isCorrect ? Colors.green : Color(0xFFFF2442),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                      onPressed: () {
                        // Add the code you want to execute when the button is pressed
                        Navigator.pop(context); // Close the BottomSheet
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            isCorrect ? Color(0xFF99CC29) : Colors.red,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              100.0), // Adjust the borderRadius value
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal:
                                120.0), // Adjust padding for height and width
                        minimumSize: const Size(200.0,
                            40.0), // Set minimum size for height and width
                      ),
                      child: isCorrect
                          ? const Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const Text(
                              'Try Again',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheet(bool isCorrect, Question question) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: isCorrect ? Color(0xFFF5FFD8) : Color(0xFFFFDDD8),
              borderRadius: BorderRadius.circular(20)),
          height: 200.0,
          width: 350,
          // Adjust the height here
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isCorrect
                        ? "That's right"
                        : "Ups.. That's not quite right \n",
                    style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: isCorrect ? Colors.green : Color(0xFFFF2442),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isCorrect ? "Amazing!" : "don't worry",
                    style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                      color: isCorrect ? Colors.green : Color(0xFFFF2442),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: () {
                      // Add the code you want to execute when the button is pressed
                      Navigator.pop(context); // Close the BottomSheet
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          isCorrect ? Color(0xFF99CC29) : Colors.red,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            100.0), // Adjust the borderRadius value
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal:
                              120.0), // Adjust padding for height and width
                      minimumSize: const Size(
                          200.0, 40.0), // Set minimum size for height and width
                    ),
                    child: isCorrect
                        ? const Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const Text(
                            'Try Again',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheetForTextQuestion(bool isCorrect, TextQuestion question) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: isCorrect ? Color(0xFFF5FFD8) : Color(0xFFFFDDD8),
              borderRadius: BorderRadius.circular(20)),
          height: 200.0,
          width: 350,
          // Adjust the height here
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isCorrect
                        ? "That's right"
                        : "Ups.. That's not quite right \n",
                    style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: isCorrect ? Colors.green : Color(0xFFFF2442),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isCorrect ? "Amazing!" : "don't worry",
                    style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                      color: isCorrect ? Colors.green : Color(0xFFFF2442),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: () {
                      // Add the code you want to execute when the button is pressed
                      Navigator.pop(context); // Close the BottomSheet
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          isCorrect ? Color(0xFF99CC29) : Colors.red,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            100.0), // Adjust the borderRadius value
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal:
                              120.0), // Adjust padding for height and width
                      minimumSize: const Size(
                          200.0, 40.0), // Set minimum size for height and width
                    ),
                    child: isCorrect
                        ? const Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const Text(
                            'Try Again',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheetForSoundQuestion(
      bool isCorrect, SoundQuestion question) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: isCorrect ? Color(0xFFF5FFD8) : Color(0xFFFFDDD8),
              borderRadius: BorderRadius.circular(20)),
          height: 200.0,
          width: 350,
          // Adjust the height here
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isCorrect
                        ? "That's right"
                        : "Ups.. That's not quite right \n",
                    style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: isCorrect ? Colors.green : Color(0xFFFF2442),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isCorrect ? "Amazing!" : "don't worry",
                    style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                      color: isCorrect ? Colors.green : Color(0xFFFF2442),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: () {
                      // Add the code you want to execute when the button is pressed
                      Navigator.pop(context); // Close the BottomSheet
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          isCorrect ? Color(0xFF99CC29) : Colors.red,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            100.0), // Adjust the borderRadius value
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal:
                              120.0), // Adjust padding for height and width
                      minimumSize: const Size(
                          200.0, 40.0), // Set minimum size for height and width
                    ),
                    child: isCorrect
                        ? const Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const Text(
                            'Try Again',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheetScrambled(
      bool isCorrect, ScrambledWordsQuestion question) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: isCorrect ? Color(0xFFF5FFD8) : Color(0xFFFFDDD8),
              borderRadius: BorderRadius.circular(20)),
          height: 200.0,
          width: 350,
          // Adjust the height here
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isCorrect
                        ? "That's right"
                        : "Ups.. That's not quite right \n",
                    style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: isCorrect ? Colors.green : Color(0xFFFF2442),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isCorrect ? "Amazing!" : "don't worry",
                    style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                      color: isCorrect ? Colors.green : Color(0xFFFF2442),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Add the code you want to execute when the button is pressed
                    Navigator.pop(context); // Close the BottomSheet
                    if (isCorrect) {
                      _nextPageForScrambledWordsQuestion();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: isCorrect ? Color(0xFF99CC29) : Colors.red,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          100.0), // Adjust the borderRadius value
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal:
                            120.0), // Adjust padding for height and width
                    minimumSize: const Size(
                        200.0, 40.0), // Set minimum size for height and width
                  ),
                  child: isCorrect
                      ? const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const Text(
                          'Try Again',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

///////////////////////////////////////////////////
  Future<void> _nextPageForScrambledWordsQuestion() async {
    // Check if the current question is of type ScrambledWordsQuestion
    if (questions[_currentPage] is ScrambledWordsQuestion) {
      ScrambledWordsQuestion currentQuestion =
          questions[_currentPage] as ScrambledWordsQuestion;

      // Vérifiez si les mots sélectionnés sont dans le bon ordre
      bool isCorrectOrder = ListEquality().equals(
        currentQuestion.selectedWords,
        currentQuestion.correctSentence.split(' '),
      );

      if (isCorrectOrder) {
        // Show Bottom Sheet with "Correct" text
        _showBottomSheetScrambled(isCorrectOrder, currentQuestion);

        if (_currentPage < questions.length - 1) {
          setState(() {
            _currentPage++;
            _progress = (_currentPage + 1) / questions.length;
            _pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          });
        } else {
          var courseSnapshot = await FirebaseFirestore.instance
              .collection('user_levels')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('courses')
              .where('code', isEqualTo: 'fr')
              .get();
          Navigator.of(context).pushReplacementNamed("frenshunities");

          if (courseSnapshot.docs.isNotEmpty) {
            setState(() {
              // Le document existe avec le code 'fr'
              // Vous pouvez accéder aux données du premier document trouvé (courseSnapshot.docs[0])
              // et vérifier la valeur actuelle du champ 'lecon8Bonjour'

              // Mettez à jour le champ 'lecon8Bonjour' car il n'est pas encore vrai
              FirebaseFirestore.instance
                  .collection('user_levels')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('courses')
                  .doc(courseSnapshot.docs[0].id)
                  .update({
                'lecon8Bonjour': true,
              });

              print('Champ lecon8Bonjour ajouté avec succès!');
            });
          } else {
            // La condition est déjà vraie, vous pouvez faire quelque chose ici si nécessaire
            print('Le champ lecon8Bonjour est déjà vrai!');
          }
        }
      } else {
        // Show Bottom Sheet with "Incorrect" text
        _showBottomSheetScrambled(isCorrectOrder, currentQuestion);
      }
    } else {
      // Handle the case where the current question is not of type ScrambledWordsQuestion
      // You may want to show an error message or take appropriate action.
      print('Current question is not of type ScrambledWordsQuestion');
    }
  }

  Future<bool> _nextPageForSoundQuestion() async {
    if (questions[_currentPage] is SoundQuestion) {
      String spokenWord = (questions[_currentPage] as SoundQuestion).spokenWord;
      String selectedWord =
          (questions[_currentPage] as SoundQuestion).selectedWord;

      bool isCorrect = spokenWord == selectedWord;

      if (isCorrect) {
        // Show Bottom Sheet with "Correct" text
        _showBottomSheetForSoundQuestion(isCorrect, questions[_currentPage]);

        if (_currentPage < questions.length - 1) {
          setState(() {
            _currentPage++;
            _progress = (_currentPage + 1) / questions.length;
            _pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          });
        } else {
          var courseSnapshot = await FirebaseFirestore.instance
              .collection('user_levels')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('courses')
              .where('code', isEqualTo: 'fr')
              .get();
          Navigator.of(context).pushReplacementNamed("frenshunities");

          if (courseSnapshot.docs.isNotEmpty) {
            setState(() {
              // Le document existe avec le code 'fr'
              // Vous pouvez accéder aux données du premier document trouvé (courseSnapshot.docs[0])
              // et vérifier la valeur actuelle du champ 'lecon8Bonjour'

              // Mettez à jour le champ 'lecon8Bonjour' car il n'est pas encore vrai
              FirebaseFirestore.instance
                  .collection('user_levels')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('courses')
                  .doc(courseSnapshot.docs[0].id)
                  .update({
                'lecon8Bonjour': true,
              });

              print('Champ lecon8Bonjour ajouté avec succès!');
            });
          } else {
            // La condition est déjà vraie, vous pouvez faire quelque chose ici si nécessaire
            print('Le champ lecon8Bonjour est déjà vrai!');
          }
        }
      } else {
        // Show Bottom Sheet with "Incorrect" text
        _showBottomSheetForSoundQuestion(isCorrect, questions[_currentPage]);
      }

      return isCorrect;
    } else {
      // Gérer le cas où la question n'est pas de type SoundQuestion
      return false;
    }
  }

  Future<bool> _nextPageForQuestion() async {
    bool isCorrect = ListEquality().equals(
      (questions[_currentPage] as Question).selectedOptions,
      (questions[_currentPage] as Question).correctOptions,
    );

    if (isCorrect) {
      // Show Bottom Sheet with "Correct" text
      _showBottomSheet(isCorrect, questions[_currentPage]);

      if (_currentPage < questions.length - 1) {
        setState(() {
          _currentPage++;
          _progress = (_currentPage + 1) / questions.length;
          _pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        });
      } else {
        var courseSnapshot = await FirebaseFirestore.instance
            .collection('user_levels')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('courses')
            .where('code', isEqualTo: 'fr')
            .get();
        Navigator.of(context).pushReplacementNamed("frenshunities");

        if (courseSnapshot.docs.isNotEmpty) {
          setState(() {
            // Le document existe avec le code 'fr'
            // Vous pouvez accéder aux données du premier document trouvé (courseSnapshot.docs[0])
            // et vérifier la valeur actuelle du champ 'lecon8Bonjour'

            // Mettez à jour le champ 'lecon8Bonjour' car il n'est pas encore vrai
            FirebaseFirestore.instance
                .collection('user_levels')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('courses')
                .doc(courseSnapshot.docs[0].id)
                .update({
              'lecon8Bonjour': true,
            });

            print('Champ lecon8Bonjour ajouté avec succès!');
          });
        } else {
          // La condition est déjà vraie, vous pouvez faire quelque chose ici si nécessaire
          print('Le champ lecon8Bonjour est déjà vrai!');
        }
      }
    } else {
      // Show Bottom Sheet with "Incorrect" text
      _showBottomSheet(isCorrect, questions[_currentPage]);
    }

    return isCorrect;
  }

  Future<bool> _nextPageForTextQuestion() async {
    bool isCorrect = ListEquality().equals(
      (questions[_currentPage] as TextQuestion).selectedOptions,
      (questions[_currentPage] as TextQuestion).correctOptions,
    );

    if (isCorrect) {
      // Show Bottom Sheet with "Correct" text
      _showBottomSheetForTextQuestion(isCorrect, questions[_currentPage]);

      if (_currentPage < questions.length - 1) {
        setState(() {
          _currentPage++;
          _progress = (_currentPage + 1) / questions.length;
          _pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        });
      } else {
        var courseSnapshot = await FirebaseFirestore.instance
            .collection('user_levels')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('courses')
            .where('code', isEqualTo: 'fr')
            .get();
        Navigator.of(context).pushReplacementNamed("frenshunities");

        if (courseSnapshot.docs.isNotEmpty) {
          setState(() {
            // Le document existe avec le code 'fr'
            // Vous pouvez accéder aux données du premier document trouvé (courseSnapshot.docs[0])
            // et vérifier la valeur actuelle du champ 'lecon8Bonjour'

            // Mettez à jour le champ 'lecon8Bonjour' car il n'est pas encore vrai
            FirebaseFirestore.instance
                .collection('user_levels')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('courses')
                .doc(courseSnapshot.docs[0].id)
                .update({
              'lecon8Bonjour': true,
            });

            print('Champ lecon8Bonjour ajouté avec succès!');
          });
        } else {
          // La condition est déjà vraie, vous pouvez faire quelque chose ici si nécessaire
          print('Le champ lecon8Bonjour est déjà vrai!');
        }
      }
    } else {
      // Show Bottom Sheet with "Incorrect" text
      _showBottomSheetForTextQuestion(isCorrect, questions[_currentPage]);
    }

    return isCorrect;
  }

  Future<bool> _nextPageForTranslationQuestion(String userTranslation) async {
    String correctTranslation =
        (questions[_currentPage] as TranslationQuestion).correctTranslation;
    bool isCorrect =
        userTranslation.toLowerCase() == correctTranslation.toLowerCase();

    if (isCorrect) {
      // Show Bottom Sheet with "Correct" text
      _showBottomSheetTranslation(isCorrect, questions[_currentPage]);

      if (_currentPage < questions.length - 1) {
        setState(() {
          _currentPage++;
          _progress = (_currentPage + 1) / questions.length;
          _pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        });
      } else {
        var courseSnapshot = await FirebaseFirestore.instance
            .collection('user_levels')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('courses')
            .where('code', isEqualTo: 'fr')
            .get();
        Navigator.of(context).pushReplacementNamed("frenshunities");

        if (courseSnapshot.docs.isNotEmpty) {
          setState(() {
            // Le document existe avec le code 'fr'
            // Vous pouvez accéder aux données du premier document trouvé (courseSnapshot.docs[0])
            // et vérifier la valeur actuelle du champ 'lecon8Bonjour'

            // Mettez à jour le champ 'lecon8Bonjour' car il n'est pas encore vrai
            FirebaseFirestore.instance
                .collection('user_levels')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('courses')
                .doc(courseSnapshot.docs[0].id)
                .update({
              'lecon8Bonjour': true,
            });

            print('Champ lecon8Bonjour ajouté avec succès!');
          });
        } else {
          // La condition est déjà vraie, vous pouvez faire quelque chose ici si nécessaire
          print('Le champ lecon8Bonjour est déjà vrai!');
        }
      }
    } else {
      // Show Bottom Sheet with "Incorrect" text
      _showBottomSheetTranslation(isCorrect, questions[_currentPage]);
    }

    return isCorrect;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 55.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    // Afficher le Bottom Sheet lorsque le bouton est cliqué
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        // Contenu du Bottom Sheet
                        return Container(
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                "assets/dangereux.png",
                                width: 100,
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                "Quit and you'll lose all XP gained in this lesson",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontSize: 25),
                              ),
                              SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: () {
                                  // Fermer le Bottom Sheet lorsque le bouton est cliqué
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(
                                      0xFF3DB2FF), // Couleur du fond du bouton
                                ),
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                      'KEEP GOING',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    // Pas de couleur de fond spécifiée ici
                                    ),
                                onPressed: () {
                                  // Fermer le Bottom Sheet lorsque le bouton est cliqué
                                  Navigator.of(context)
                                      .pushReplacementNamed("home");
                                },
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                      'QUIT',
                                      style: GoogleFonts.poppins(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    child: Icon(
                      Icons.close,
                      color: Color(0xFF3DB2FF),
                      size: 35,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 20,
                  width: 240,
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green,
                    value: _progress,
                  ),
                ),
              ],
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                    // Ne mettez à jour la barre de progression que si la réponse est correcte
                    if (questions[_currentPage] is Question) {
                      _progress = ListEquality().equals(
                        (questions[_currentPage] as Question).selectedOptions,
                        (questions[_currentPage] as Question).correctOptions,
                      )
                          ? (_currentPage + 1) / questions.length
                          : _progress;
                    }
                  });
                },
                physics: NeverScrollableScrollPhysics(),
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  if (questions[index] is Question) {
                    return ExercisePage(
                      question: questions[index],
                      onCorrectAnswer: _nextPageForQuestion,
                    );
                  } else if (questions[index] is TranslationQuestion) {
                    TextEditingController translationController =
                        TextEditingController(); // Créez un nouveau contrôleur pour chaque instance de TranslationExercisePage
                    return TranslationExercisePage.create(
                      question: questions[index] as TranslationQuestion,
                      translationController: translationController,
                      onCorrectAnswer: () => _nextPageForTranslationQuestion(
                          translationController.text.trim()),
                    );
                  } else if (questions[index] is ScrambledWordsQuestion) {
                    return ScrambledWordsQuestionWidget(
                      question: questions[index] as ScrambledWordsQuestion,
                      onCorrectAnswer: _nextPageForScrambledWordsQuestion,
                    );
                  } else if (questions[index] is SoundQuestion) {
                    return QuestionSound(
                      question: questions[index] as SoundQuestion,
                      onCorrectAnswer: _nextPageForSoundQuestion,
                    );
                  } else if (questions[index] is TextQuestion) {
                    return TextQuestionPage(
                      question: questions[index]
                          as TextQuestion, // Cast to TextQuestion
                      onCorrectAnswer: _nextPageForTextQuestion,
                    );
                  } else {
                    // Gérer le cas où le type de question n'est ni Question, ni TranslationQuestion, ni ScrambledWordsQuestion, ni SoundQuestion, ni TextQuestion
                    return Container(); // ou tout autre widget par défaut
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
