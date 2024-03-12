class Option1 {
  final String text;
  final String imagePath;

  Option1(this.text, this.imagePath);
}

class Question {
  final String questionText;
  final List<Option1> options;
  final List<bool> selectedOptions;
  final List<bool> correctOptions;

  Question(this.questionText, this.options, this.selectedOptions,
      this.correctOptions);
}

class TranslationQuestion {
  final String originalText;
  final String correctTranslation;
  String userTranslationn;

  TranslationQuestion(
      {required this.originalText,
      required this.correctTranslation,
      required this.userTranslationn});
}

class ScrambledWordsQuestion {
  final String questionText;

  final String correctSentence;
  List<String> selectedWords = [];
  List<String> selectedWordOrder = [];

  ScrambledWordsQuestion(
      {required this.correctSentence, required this.questionText}) {
    // Split the sentence into words when the question is created
    selectedWordOrder = correctSentence.split(' ');
  }
}

class SoundQuestion {
  final String questionText;
  final List<Option1> options;
  final String spokenWord;
  String selectedWord;

  SoundQuestion(
      {required this.questionText,
      required this.options,
      required this.spokenWord,
      required this.selectedWord});
}
