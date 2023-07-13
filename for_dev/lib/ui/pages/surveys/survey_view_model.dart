class SurveyViewModel {
  final String id;
  final String question;
  final String date;
  final bool didAnswer;

  const SurveyViewModel({
    required this.id,
    required this.question,
    required this.date,
    required this.didAnswer,
  });
}
