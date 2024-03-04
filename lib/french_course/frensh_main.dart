import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pfe_1/constant/question.dart';
import 'package:pfe_1/services/firebase_services.dart';

class Chapitre1 extends StatefulWidget {
  @override
  _Chapitre1State createState() => _Chapitre1State();
}

class _Chapitre1State extends State<Chapitre1> {
  double progressValue = 0.0; // Valeur de progression
  double overallProgress =
      0.0; // Progression totale à travers toutes les questions
  int currentQuestionIndex = 0;
  int xpLevel = 1; // Niveau d'XP initial
  double xpProgress = 0.0; // Progression de l'XP dans le niveau actuel

  List<Question> questions = [
    Question(
      "Quelle est la capitale de la France ?",
      ["Paris", "Berlin", "Londres", "Madrid"],
      [
        false,
        false,
        false,
        false
      ], // Liste pour suivre les réponses sélectionnées
      [true, false, false, false], // Liste pour indiquer les réponses correctes
    ),
    Question(
      "Quel est le plus grand océan du monde ?",
      ["Atlantique", "Arctique", "Indien", "Pacifique"],
      [false, false, false, false],
      [false, false, false, true],
    ),
    // Ajoutez d'autres questions ici
  ];
  int xp = 0;

  FirebaseService firebaseService =
      FirebaseService(); // Instance de FirebaseService

  @override
  Widget build(BuildContext context) {
    final User? user1 = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Chapitre 1'),
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              questions[currentQuestionIndex].questionText,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20),
            Column(
              children: List.generate(
                questions[currentQuestionIndex].options.length,
                (index) => CheckboxListTile(
                  title: Text(questions[currentQuestionIndex].options[index]),
                  value: questions[currentQuestionIndex].selectedOptions[index],
                  onChanged: (value) {
                    handleAnswer(index, value);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                bool allCorrectSelected = List.generate(
                  questions[currentQuestionIndex].selectedOptions.length,
                  (index) =>
                      questions[currentQuestionIndex].selectedOptions[index] ==
                      questions[currentQuestionIndex].correctOptions[index],
                ).reduce((value, element) => value && element);

                if (allCorrectSelected) {
                  updateProgressAndXP(1 / 2);
                  xp = xp + 10;
                }

                moveToNextQuestion();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text('Continuer'),
            ),
            SizedBox(height: 20),
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user1?.uid)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text("Erreur: ${snapshot.error}");
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Text("Aucune donnée utilisateur trouvée");
                }

                double progressValueFromFirestore =
                    (snapshot.data!['progressValue'] ?? 0).toDouble();

                int xpFromFirestore = snapshot.data!['xp'] ?? 0;
                double xpProgressFromFirestore =
                    (snapshot.data!['xpProgress'] ?? 0).toDouble();

                int xpLevelFromFirestore = snapshot.data!['xpLevel'] ?? 1;

                // Mettre à jour l'état sans utiliser setState
                progressValue = progressValueFromFirestore;
                xp = xpFromFirestore;
                xpProgress = xpProgressFromFirestore;
                xpLevel = xpLevelFromFirestore;

                return Column(
                  children: [
                    LinearProgressIndicator(
                      minHeight: 20,
                      borderRadius: BorderRadius.circular(5),
                      value: progressValue,
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 1, 214, 48),
                      ),
                    ),
                    LinearProgressIndicator(
                      minHeight: 10,
                      value: xpProgress,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blue,
                      ),
                    ),
                    Text("XP Level: $xpLevel xp : $xp"),
                  ],
                );
              },
            ),

            SizedBox(height: 10),
            // Le FutureBuilder est désormais en dehors du bloc build
          ],
        ),
      ),
    );
  }

  void updateProgressAndXP(double valueToAdd) {
    setState(() {
      progressValue += valueToAdd;

      if (progressValue > 1.0) {
        progressValue = 1.0;
      }

      xpProgress += valueToAdd;

      if (xpProgress >= 1.0) {
        xpProgress = 0.0;
        xpLevel++;
      }
      final User? user1 = FirebaseAuth.instance.currentUser;

      // Update user data in Firestore
      FirebaseFirestore.instance.collection('users').doc(user1?.uid).update({
        'progressValue': progressValue,
        'xp': xp,
        'xpProgress': xpProgress,
        'xpLevel': xpLevel,
      });
    });
  }

  void moveToNextQuestion() {
    setState(() {
      // Ajouter la progression de la question actuelle à la progression totale
      overallProgress += progressValue;

      // Réinitialiser la barre de progression pour la prochaine question
      progressValue = 0.0;

      // Passer à la question suivante
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        // Vous avez atteint la dernière question, vous pouvez ajouter une logique ici
        // par exemple, revenir à l'écran précédent ou afficher un message de fin.
        print("Fin des questions");
      }
    });
  }

  void handleAnswer(int selectedOptionIndex, bool? value) {
    setState(() {
      // Mettre à jour la liste des réponses sélectionnées
      questions[currentQuestionIndex].selectedOptions[selectedOptionIndex] =
          value ?? false;
    });
  }
}
