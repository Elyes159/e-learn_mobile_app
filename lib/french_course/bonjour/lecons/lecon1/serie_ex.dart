import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../../constant/question.dart';

class ExLeconOne extends StatefulWidget {
  @override
  _ExLeconOneState createState() => _ExLeconOneState();
}

class _ExLeconOneState extends State<ExLeconOne> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  double _progress = 0.0;

  List<Question> questions = [
    Question(
      'Question 1',
      [
        Option1('Option 1', 'assets/UserCircle.png'),
        Option1('Option 2', 'assets/UserCircle.png'),
        Option1('Option 3', 'assets/UserCircle.png'),
        Option1('Option 3', 'assets/UserCircle.png'),
      ],
      [false, false, false, false],
      [true, false, false, false],
    ),
    Question(
      'Question 2',
      [
        Option1('Option 1', 'assets/UserCircle.png'),
        Option1('Option 2', 'assets/UserCircle.png'),
        Option1('Option 3', 'assets/UserCircle.png'),
        Option1('Option 3', 'assets/UserCircle.png'),
      ],
      [false, false, false, false],
      [true, false, false, false],
    ),
    // Add more questions as needed
  ];

  void _nextPage() {
    setState(() {
      if (_currentPage < questions.length - 1) {
        _currentPage++;
        _progress = (_currentPage + 1) / questions.length;
        _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercices'),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: _progress,
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                  _progress = (_currentPage + 1) / questions.length;
                });
              },
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                questions.length,
                (index) => ExercisePage(
                  question: questions[index],
                  onCorrectAnswer: _nextPage,
                ),
              ),
            ),
          ),
        ],
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
          Text(widget.question.questionText, style: TextStyle(fontSize: 20)),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: widget.question.selectedOptions[index]
                          ? Colors.blue
                          : Colors.white,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          widget.question.options[index].imagePath,
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(height: 5),
                        Text(
                          widget.question.options[index].text,
                          style: TextStyle(
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
          ElevatedButton(
            onPressed: () {
              bool isCorrect = ListEquality().equals(
                widget.question.selectedOptions,
                widget.question.correctOptions,
              );

              if (isCorrect) {
                widget.onCorrectAnswer();
              } else {
                // Handle incorrect answer logic if needed
              }
            },
            child: Text('Répondre correctement'),
          ),
        ],
      ),
    );
  }
}
