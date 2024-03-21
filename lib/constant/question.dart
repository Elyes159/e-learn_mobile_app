class Option1 {
  String text;
  String imagePath;

  Option1(this.text, this.imagePath);

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'imagePath': imagePath,
    };
  }
}

class Question {
  String questionText;
  List<Option1> options;
  List<bool> selectedOptions;
  List<bool> correctOptions;

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
  List<String> additionalWords = [];
  List<String> selectedWordOrder = [];
  final String questionLanguage; // Ajoutez cette ligne
  // Ajoutez cette ligne

  ScrambledWordsQuestion({
    required this.correctSentence,
    required this.questionText,
    required this.additionalWords,
    required this.selectedWordOrder,
    required this.questionLanguage, // Ajoutez cette ligne
  }) {
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

class TextQuestion {
  final String questionText;
  final List<Option1> options;
  final List<bool> selectedOptions;
  final List<bool> correctOptions;

  TextQuestion(this.questionText, this.options, this.selectedOptions,
      this.correctOptions);
}
