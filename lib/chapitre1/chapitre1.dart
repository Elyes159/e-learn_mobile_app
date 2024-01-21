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
                // Vérifier si toutes les réponses correctes sont sélectionnées
                bool allCorrectSelected = List.generate(
                  questions[currentQuestionIndex].selectedOptions.length,
                  (index) =>
                      questions[currentQuestionIndex].selectedOptions[index] ==
                      questions[currentQuestionIndex].correctOptions[index],
                ).reduce((value, element) => value && element);

                if (allCorrectSelected) {
                  // Réponse correcte, mettez à jour la barre de progression et d'XP
                  updateProgressAndXP(1 / 2);
                  xp = xp + 10;
                }

                // Passer à la question suivante
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
            LinearProgressIndicator(
              minHeight: 20,
              borderRadius: BorderRadius.circular(5),
              value: overallProgress,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromARGB(255, 1, 214, 48),
              ),
            ),
            SizedBox(height: 10),
            Text("XP Level: $xpLevel xp : $xp"),
            LinearProgressIndicator(
              minHeight: 10,
              value: xpProgress,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateProgressAndXP(double valueToAdd) {
    setState(() {
      // Mettez à jour la valeur de progression
      progressValue += valueToAdd;

      // Limitez la valeur de progression entre 0 et 1
      if (progressValue > 1.0) {
        progressValue = 1.0;
      }

      // Mettez à jour la barre d'XP
      xpProgress += valueToAdd;
      if (xpProgress >= 1.0) {
        // L'utilisateur a atteint la barre d'XP complète dans le niveau actuel
        xpProgress = 0.0;
        xpLevel++;
      }
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
