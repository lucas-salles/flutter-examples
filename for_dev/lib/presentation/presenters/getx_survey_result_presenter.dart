import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';
import '../mixins/mixins.dart';

class GetxSurveyResultPresenter extends GetxController
    with LoadingManager, SessionManager
    implements SurveyResultPresenter {
  final LoadSurveyResult loadSurveyResult;
  final SaveSurveyResult saveSurveyResult;
  final String surveyId;

  final _surveyResult = Rxn<SurveyResultViewModel>();

  @override
  Stream<SurveyResultViewModel?> get surveyResultStream => _surveyResult.stream;

  GetxSurveyResultPresenter({
    required this.loadSurveyResult,
    required this.saveSurveyResult,
    required this.surveyId,
  });

  @override
  Future<void> loadData() async {
    showResultOnAction(() => loadSurveyResult.loadBySurvey(surveyId: surveyId));
  }

  @override
  Future<void> save({required String answer}) async {
    showResultOnAction(() => saveSurveyResult.save(answer: answer));
  }

  Future<void> showResultOnAction(
      Future<SurveyResultEntity> Function() action) async {
    try {
      isLoading = true;
      final surveyResult = await action();
      _surveyResult.value = SurveyResultViewModel(
        surveyId: surveyResult.surveyId,
        question: surveyResult.question,
        answers: surveyResult.answers
            .map((answer) => SurveyAnswerViewModel(
                  image: answer.image,
                  answer: answer.answer,
                  isCurrentAnswer: answer.isCurrentAnswer,
                  percent: '${answer.percent}%',
                ))
            .toList(),
      );
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        isSessionExpired = true;
      } else {
        _surveyResult.subject.addError(UIError.unexpected.description);
      }
    } finally {
      isLoading = false;
    }
  }
}
