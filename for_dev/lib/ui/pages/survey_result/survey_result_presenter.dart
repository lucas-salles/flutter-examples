import 'survey_result_viewmodel.dart';

abstract class SurveyResultPresenter {
  Stream<bool> get isLoadingStream;
  Stream<SurveyResultViewModel> get surveyResultStream;

  Future<void> loadData();
}