import 'survey_answer_entity.dart';

class SurveyResultEntity {
  final String surveyId;
  final String question;
  final List<SurveyAnswerEntity> answers;

  const SurveyResultEntity({
    required this.surveyId,
    required this.question,
    required this.answers,
  });
}
