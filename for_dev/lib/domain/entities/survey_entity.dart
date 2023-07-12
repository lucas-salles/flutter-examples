class SurveyEntity {
  final String id;
  final String question;
  final String dateTime;
  final String didAnswer;

  const SurveyEntity({
    required this.id,
    required this.question,
    required this.dateTime,
    required this.didAnswer,
  });
}
