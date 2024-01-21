class Question {
  final String questionText;
  final List<String> options;
  final List<bool> selectedOptions;
  final List<bool> correctOptions;

  Question(this.questionText, this.options, this.selectedOptions,
      this.correctOptions);
}
