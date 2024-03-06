class Question {
  final String questionText;
  final List<Option1> options;
  final List<bool> selectedOptions;
  final List<bool> correctOptions;

  Question(this.questionText, this.options, this.selectedOptions,
      this.correctOptions);
}

class Option1 {
  final String text;
  final String imagePath;

  Option1(this.text, this.imagePath);
}
