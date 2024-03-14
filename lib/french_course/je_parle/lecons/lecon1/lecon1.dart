// ignore_for_file: library_private_types_in_public_api, prefer_final_fields

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../constant/question.dart';

class ExParleLeconOne extends StatefulWidget {
  const ExParleLeconOne({super.key});

  @override
  _ExParleLeconOneState createState() => _ExParleLeconOneState();
}

class _ExParleLeconOneState extends State<ExParleLeconOne> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  double _progress = 0.0;

  List<dynamic> questions = [
    Question(
      'the kitchen',
      [
        Option1('la cuisine', 'assets/cuisine.png'),
        Option1('thé', 'assets/thé.png'),
        Option1('le repas', 'assets/repas.png'),
        Option1('Le beurre', 'assets/propage.png'),
      ],
      [false, false, false, false],
      [true, false, false, false],
    ),
    ScrambledWordsQuestion(
      correctSentence: 'He is running',
      questionText: "il court",
      additionalWords: ['she', 'am', 'and'], // Liste des mots supplémentaires
    ),
    ScrambledWordsQuestion(
      correctSentence: 'You cook',
      questionText: "Tu cuisines",
      additionalWords: ['she', "I'm", 'and'], // Liste des mots supplémentaires
    ),
    Question(
      'an egg',
      [
        Option1('la cuisine', 'assets/cuisine.png'),
        Option1('thé', 'assets/thé.png'),
        Option1('un oeuf', 'assets/egg.png'),
        Option1('Le beurre', 'assets/propage.png'),
      ],
      [false, false, false, false],
      [false, false, true, false],
    ),
    Question(
      'the cake',
      [
        Option1('la cuisine', 'assets/cuisine.png'),
        Option1('thé', 'assets/thé.png'),
        Option1('un oeuf', 'assets/egg.png'),
        Option1('Le gâteau', 'assets/gateau.png'),
      ],
      [false, false, false, false],
      [false, false, false, true],
    ),
    ScrambledWordsQuestion(
      correctSentence: 'he respects his woman',
      questionText: 'Il respecte sa femme',
      additionalWords: [
        'you',
        'rich',
        'am',
        'I'
      ], // Liste des mots supplémentaires
    ),

    ScrambledWordsQuestion(
      correctSentence: 'your bag contains vegetables',
      questionText: 'Ton sac contient des légumes',
      additionalWords: [
        'how',
        'what',
        'where',
        'on'
      ], // Liste des mots supplémentaires
    ),

    ScrambledWordsQuestion(
      correctSentence: 'men cut apples',
      questionText: 'les hommes coupent des pommes',
      additionalWords: [
        'woman',
        'orange',
        'appple',
        'pizza',
      ], // Liste des mots supplémentaires
    ),

    ScrambledWordsQuestion(
      correctSentence: 'We respect his woman',
      questionText: 'Nous respectons sa femme',
      additionalWords: [
        'man',
        'orange',
        'now',
        'tomorrow',
      ], // Liste des mots supplémentaires
    ),

    ScrambledWordsQuestion(
      correctSentence: 'We run',
      questionText: 'Nous courons',
      additionalWords: [
        'horse',
        'pizza',
        'how',
        'where',
      ], // Liste des mots supplémentaires
    ),
    Question(
      'shoes',
      [
        Option1('chaussures', 'assets/baskets.png'),
        Option1('une cappuche', 'assets/veste.png'),
        Option1('un pantalon', 'assets/pantalon.png'),
        Option1('un pull', 'assets/pull.png'),
      ],
      [false, false, false, false],
      [true, false, false, false],
    ),

    ScrambledWordsQuestion(
      correctSentence: 'You run',
      questionText: 'Vous courez',
      additionalWords: [
        'we',
        'am',
        'I',
        'why',
      ], // Liste des mots supplémentaires
    ),
    ScrambledWordsQuestion(
      correctSentence: 'he cuts an orange',
      questionText: 'Il coupe un orange',
      additionalWords: [
        'we',
        'am',
        'I',
        'why',
      ], // Liste des mots supplémentaires
    ),
    ScrambledWordsQuestion(
      correctSentence: 'they respect the woman',
      questionText: 'Ils respectent la femme',
      additionalWords: [
        'man',
        'orange',
        'now',
        'tomorrow',
      ], // Liste des mots supplémentaires
    ), // Add more questions as needed
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
              // et vérifier la valeur actuelle du champ 'lecon1Parle'

              // Mettez à jour le champ 'lecon1Parle' car il n'est pas encore vrai
              FirebaseFirestore.instance
                  .collection('user_levels')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('courses')
                  .doc(courseSnapshot.docs[0].id)
                  .update({
                'lecon1Parle': true,
              });

              print('Champ lecon1Parle ajouté avec succès!');
            });
          } else {
            // La condition est déjà vraie, vous pouvez faire quelque chose ici si nécessaire
            print('Le champ lecon1Parle est déjà vrai!');
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
              // et vérifier la valeur actuelle du champ 'lecon1Parle'

              // Mettez à jour le champ 'lecon1Parle' car il n'est pas encore vrai
              FirebaseFirestore.instance
                  .collection('user_levels')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('courses')
                  .doc(courseSnapshot.docs[0].id)
                  .update({
                'lecon1Parle': true,
              });

              print('Champ lecon1Parle ajouté avec succès!');
            });
          } else {
            // La condition est déjà vraie, vous pouvez faire quelque chose ici si nécessaire
            print('Le champ lecon1Parle est déjà vrai!');
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
            // et vérifier la valeur actuelle du champ 'lecon1Parle'

            // Mettez à jour le champ 'lecon1Parle' car il n'est pas encore vrai
            FirebaseFirestore.instance
                .collection('user_levels')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('courses')
                .doc(courseSnapshot.docs[0].id)
                .update({
              'lecon1Parle': true,
            });

            print('Champ lecon1Parle ajouté avec succès!');
          });
        } else {
          // La condition est déjà vraie, vous pouvez faire quelque chose ici si nécessaire
          print('Le champ lecon1Parle est déjà vrai!');
        }
      }
    } else {
      // Show Bottom Sheet with "Incorrect" text
      _showBottomSheet(isCorrect, questions[_currentPage]);
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
            // et vérifier la valeur actuelle du champ 'lecon1Parle'

            // Mettez à jour le champ 'lecon1Parle' car il n'est pas encore vrai
            FirebaseFirestore.instance
                .collection('user_levels')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('courses')
                .doc(courseSnapshot.docs[0].id)
                .update({
              'lecon1Parle': true,
            });

            print('Champ lecon1Parle ajouté avec succès!');
          });
        } else {
          // La condition est déjà vraie, vous pouvez faire quelque chose ici si nécessaire
          print('Le champ lecon1Parle est déjà vrai!');
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
                  } else {
                    // Gérer le cas où le type de question n'est ni Question, ni TranslationQuestion, ni ScrambledWordsQuestion, ni SoundQuestion
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

class ExercisePage extends StatefulWidget {
  final Question question;
  final VoidCallback onCorrectAnswer;

  ExercisePage({
    required this.question,
    required this.onCorrectAnswer,
  });

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage("fr-FR");
  }

  Future<void> speak(String text) async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Select the correct image",
                style: GoogleFonts.poppins(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16.0, left: 10),
                    child: Text(
                      'Which one of these is \n"${widget.question.questionText}"?',
                      style: GoogleFonts.poppins(
                          fontSize: 20.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemCount: widget.question.options.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    widget.question.selectedOptions[index] =
                        !widget.question.selectedOptions[index];
                  });
                  speak(widget.question.options[index].text);

                  // speak(widget.question.options[index].text);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 200,
                    width: 150,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: widget.question.selectedOptions[index]
                          ? Color(0xFF3DB2FF)
                          : Colors.white,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          widget.question.options[index].imagePath,
                          width: 150,
                          height: 100,
                        ),
                        SizedBox(height: 5),
                        Text(
                          widget.question.options[index].text,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: widget.question.selectedOptions[index]
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8, bottom: 50),
            child: ElevatedButton(
              onPressed: () {
                bool isCorrect = ListEquality().equals(
                  widget.question.selectedOptions,
                  widget.question.correctOptions,
                );

                if (isCorrect || !isCorrect) {
                  widget.onCorrectAnswer();
                } else {
                  // Gérez la logique de réponse incorrecte si nécessaire
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    Color(0xFF3DB2FF), // Couleur du texte du bouton
                padding: EdgeInsets.all(16), // Espace intérieur du bouton
                minimumSize: Size(MediaQuery.of(context).size.width, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      20.0), // Ajustez cette valeur selon vos besoins
                ), // Largeur du bouton = largeur de l'écran
              ),
              child: Text(
                'CHECK',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextQuestionPage extends StatefulWidget {
  final TextQuestion question;
  final VoidCallback onCorrectAnswer;

  TextQuestionPage({
    required this.question,
    required this.onCorrectAnswer,
  });

  @override
  _TextQuestionPageState createState() => _TextQuestionPageState();
}

class _TextQuestionPageState extends State<TextQuestionPage> {
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage("fr-FR");
  }

  Future<void> speak(String text) async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Read and Respond",
                style: GoogleFonts.poppins(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: [
              InkWell(
                  onTap: () {
                    String textToSpeak = widget.question.questionText
                        .replaceAll('_', ''); // Supprimer les tirets bas
                    speak(textToSpeak);
                  },
                  child: Image.asset("assets/Volume button.png")),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "${widget.question.questionText}",
                    style: GoogleFonts.poppins(
                        fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: List.generate(
                widget.question.options.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.question.selectedOptions[index] =
                          !widget.question.selectedOptions[index];
                    });
                    speak(widget.question.options[index].text);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: widget.question.selectedOptions[index]
                            ? Color(0xFF3DB2FF)
                            : Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.question.options[index].text,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: widget.question.selectedOptions[index]
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8, bottom: 50),
            child: ElevatedButton(
              onPressed: () {
                bool isCorrect = ListEquality().equals(
                  widget.question.selectedOptions,
                  widget.question.correctOptions,
                );

                if (isCorrect || !isCorrect) {
                  widget.onCorrectAnswer();
                } else {
                  // Gérez la logique de réponse incorrecte si nécessaire
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    Color(0xFF3DB2FF), // Couleur du texte du bouton
                padding: EdgeInsets.all(16), // Espace intérieur du bouton
                minimumSize: Size(MediaQuery.of(context).size.width, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      20.0), // Ajustez cette valeur selon vos besoins
                ), // Largeur du bouton = largeur de l'écran
              ),
              child: Text(
                'CHECK',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TranslationExercisePage extends StatefulWidget {
  final TranslationQuestion question;
  final TextEditingController translationController;
  final VoidCallback onCorrectAnswer;

  TranslationExercisePage({
    required this.question,
    required this.translationController,
    required this.onCorrectAnswer,
  });

  @override
  _TranslationExercisePageState createState() =>
      _TranslationExercisePageState();

  // Ajoutez cette fonction de fabrique
  static TranslationExercisePage create({
    required TranslationQuestion question,
    required TextEditingController translationController,
    required VoidCallback onCorrectAnswer,
  }) {
    return TranslationExercisePage(
      question: question,
      translationController: translationController,
      onCorrectAnswer: onCorrectAnswer,
    );
  }
}

class _TranslationExercisePageState extends State<TranslationExercisePage> {
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage("fr-FR");
  }

  Future<void> speak(String text) async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
  }
  // Retirez cette ligne
  // TextEditingController _translationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String correctTranslation = widget.question.correctTranslation;

    return ListView(
      children: [
        SizedBox(
          height: 50,
        ),
        Center(
            child: Text(
          "Whay's the meaning of \n       this sentence ?",
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w500),
        )),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                speak(widget.question.originalText);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image.asset(
                  "assets/Volume button.png",
                  width: 100,
                ),
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    "${widget.question.originalText}",
                    style: GoogleFonts.poppins(
                        fontSize: 20.0, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: widget.translationController,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Traduisez ici...',

              contentPadding: EdgeInsets.symmetric(
                  vertical: 50,
                  horizontal: 10), // Ajustez la hauteur du champ de texte
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    10), // Ajustez la bordure du champ de texte
              ),
              alignLabelWithHint: true,
            ),
          ),
        ),
        SizedBox(height: 200),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              String userTranslation = widget.translationController.text
                  .trim(); // Modifiez cette ligne
              bool isCorrect = userTranslation.toLowerCase() ==
                  correctTranslation.toLowerCase();

              // Mettre à jour l'instance de TranslationQuestion avec la userTranslation
              widget.question.userTranslationn = userTranslation;

              if (isCorrect || !isCorrect) {
                widget.onCorrectAnswer();
              } else {
                // Gérer la logique pour une réponse incorrecte si nécessaire
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF3DB2FF), // Couleur du texte du bouton
              padding: EdgeInsets.all(16), // Espace intérieur du bouton
              minimumSize: Size(MediaQuery.of(context).size.width, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    20.0), // Ajustez cette valeur selon vos besoins
              ), // Largeur du bouton = largeur de l'écran
            ),
            child: Text('Check'),
          ),
        ),
      ],
    );
  }
}

class ScrambledWordsQuestionWidget extends StatefulWidget {
  final ScrambledWordsQuestion question;
  final VoidCallback onCorrectAnswer;

  ScrambledWordsQuestionWidget({
    required this.question,
    required this.onCorrectAnswer,
  });

  @override
  _ScrambledWordsQuestionWidgetState createState() =>
      _ScrambledWordsQuestionWidgetState();
}

class _ScrambledWordsQuestionWidgetState
    extends State<ScrambledWordsQuestionWidget> {
  late List<String> shuffledWords;

  @override
  void initState() {
    super.initState();
    initializeShuffledWords();
    flutterTts.setLanguage("fr-FR");
  }

  void initializeShuffledWords() {
    // Inclure les mots supplémentaires dans la liste shuffledWords
    shuffledWords = List.from(widget.question.selectedWordOrder)
      ..addAll(widget.question.additionalWords)
      ..shuffle(Random());
  }

  FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String text) async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Write this in French : \n ${widget.question.questionText}",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF3DB2FF)),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 8.0,
                  spreadRadius: 2.0,
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 8.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Selected Words:",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: widget.question.selectedWords.map((word) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: const Color(0xFF3DB2FF),
                          ),
                          child: Text(
                            word,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 100,
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: shuffledWords
              .map((word) => GestureDetector(
                    onTap: () {
                      setState(() {
                        if (widget.question.selectedWords.contains(word)) {
                          widget.question.selectedWords.remove(word);
                        } else {
                          widget.question.selectedWords.add(word);
                        }
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8.0),
                        color: widget.question.selectedWords.contains(word)
                            ? Color(0xFF3DB2FF)
                            : Colors.white,
                      ),
                      child: Text(
                        word,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(height: 16.0),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              // Vérifiez si les mots sélectionnés sont dans le bon ordre
              bool isCorrectOrder = ListEquality().equals(
                widget.question.selectedWords,
                widget.question.correctSentence.split(' '),
              );

              // Affichez un message ou effectuez une action en fonction de la réponse
              if (isCorrectOrder || !isCorrectOrder) {
                // Affichez un message de réussite ou effectuez une action
                print("Bravo ! Vous avez formé la phrase correctement.");
                widget.onCorrectAnswer();
              } else {
                // Affichez un message d'échec ou effectuez une action
                print("Désolé, la phrase est incorrecte. Réessayez !");
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF3DB2FF),
              padding: EdgeInsets.all(16),
              minimumSize: Size(MediaQuery.of(context).size.width, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: Text("CHECK"),
          ),
        ),
      ],
    );
  }
}

class QuestionSound extends StatefulWidget {
  final SoundQuestion question;
  final VoidCallback onCorrectAnswer;

  QuestionSound({
    required this.question,
    required this.onCorrectAnswer,
  });

  @override
  _QuestionSoundState createState() => _QuestionSoundState();
}

class _QuestionSoundState extends State<QuestionSound> {
  FlutterTts flutterTts = FlutterTts();
  String selectedOption = '';

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage("fr-FR");
  }

  Future<void> speak(String text) async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                widget.question.questionText,
                style: GoogleFonts.poppins(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              speak(widget.question.spokenWord);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Image.asset(
                "assets/Volume button.png",
                width: 100, // Définissez la largeur souhaitée
                height: 90, // Définissez la hauteur souhaitée
              ),
            ),
          ),
          Text(
            "tap here ",
            style: GoogleFonts.poppins(
                color: Colors.red, fontWeight: FontWeight.w600, fontSize: 18),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemCount: widget.question.options.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedOption = widget.question.options[index].text;
                    speak(selectedOption);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 100, // Ajustez la hauteur selon vos besoins
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color:
                          selectedOption == widget.question.options[index].text
                              ? Color(0xFF3DB2FF)
                              : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        widget.question.options[index].text,
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: selectedOption ==
                                  widget.question.options[index].text
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8, right: 8, left: 8),
            child: ElevatedButton(
              onPressed: () {
                bool isCorrect = selectedOption == widget.question.spokenWord;
                setState(() {
                  widget.question.selectedWord = selectedOption;
                });
                if (isCorrect || !isCorrect) {
                  widget.onCorrectAnswer();
                } else {
                  // Gérez la logique de réponse incorrecte si nécessaire
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF3DB2FF),
                padding: EdgeInsets.all(16),
                minimumSize: Size(MediaQuery.of(context).size.width, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                'CHECK',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
