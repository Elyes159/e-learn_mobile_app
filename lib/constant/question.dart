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

  Map<String, dynamic> toMap() {
    return {
      'questionText': questionText,
      'options': options.map((option) => option.toMap()).toList(),
      'selectedOptions': selectedOptions,
      'correctOptions': correctOptions,
    };
  }
}

class TranslationQuestion {
  final String originalText;
  final String correctTranslation;
  String userTranslationn;

  TranslationQuestion(
      {required this.originalText,
      required this.correctTranslation,
      required this.userTranslationn});

  Map<String, dynamic> toMap() {
    return {
      'originalText': originalText,
      'correctTranslation': correctTranslation,
      'userTranslationn': userTranslationn,
    };
  }
}

class ScrambledWordsQuestion {
  final String questionText;
  final String correctSentence;
  List<String> selectedWords = [];
  List<String> selectedWordOrder = [];
  List<String> additionalWords = []; // Ajoutez cette ligne

  ScrambledWordsQuestion({
    required this.correctSentence,
    required this.questionText,
    required this.additionalWords, // Ajoutez cette ligne
  }) {
    selectedWordOrder = correctSentence.split(' ');
  }

  Map<String, dynamic> toMap() {
    return {
      'questionText': questionText,
      'correctSentence': correctSentence,
      'selectedWords': selectedWords,
      'selectedWordOrder': selectedWordOrder,
      'additionalWords': additionalWords,
    };
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

  Map<String, dynamic> toMap() {
    return {
      'questionText': questionText,
      'options': options.map((option) => option.toMap()).toList(),
      'spokenWord': spokenWord,
      'selectedWord': selectedWord,
    };
  }
}

class TextQuestion {
  final String questionText;
  final List<Option1> options;
  final List<bool> selectedOptions;
  final List<bool> correctOptions;

  TextQuestion(this.questionText, this.options, this.selectedOptions,
      this.correctOptions);

  Map<String, dynamic> toMap() {
    return {
      'questionText': questionText,
      'options': options.map((option) => option.toMap()).toList(),
      'selectedOptions': selectedOptions,
      'correctOptions': correctOptions,
    };
  }
}
