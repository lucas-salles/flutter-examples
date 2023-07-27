import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/domain/entities/entities.dart';
import 'package:for_dev/domain/helpers/helpers.dart';
import 'package:for_dev/domain/usecases/usecases.dart';
import 'package:for_dev/presentation/presenters/presenters.dart';
import 'package:for_dev/ui/helpers/helpers.dart';
import 'package:for_dev/ui/pages/pages.dart';

import '../../domain/mocks/mocks.dart';

// Annotation which generates the getx_surveys_presenter_test.mocks.dart library and the MockLoadSurveys class.
@GenerateNiceMocks([MockSpec<LoadSurveys>()])
import './getx_surveys_presenter_test.mocks.dart';

void main() {
  late MockLoadSurveys loadSurveys;
  late GetxSurveysPresenter sut;
  late List<SurveyEntity> surveys;

  PostExpectation mockLoadSurveysCall() => when(loadSurveys.load());

  void mockLoadSurveys(List<SurveyEntity> data) {
    surveys = data;
    mockLoadSurveysCall().thenAnswer((_) async => surveys);
  }

  void mockLoadSurveysError() =>
      mockLoadSurveysCall().thenThrow(DomainError.unexpected);

  void mockAccessDeniedError() =>
      mockLoadSurveysCall().thenThrow(DomainError.accessDenied);

  setUp(() {
    loadSurveys = MockLoadSurveys();
    sut = GetxSurveysPresenter(loadSurveys: loadSurveys);
    mockLoadSurveys(EntityFactory.makeSurveyList());
  });

  test('Should call LoadSurveys on loadData', () async {
    await sut.loadData();

    verify(loadSurveys.load()).called(1);
  });

  test('Should emit correct events on success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.surveysStream.listen(expectAsync1((surveys) => expect(surveys, [
          SurveyViewModel(
            id: surveys[0].id,
            question: surveys[0].question,
            date: '02 Feb 2020',
            didAnswer: surveys[0].didAnswer,
          ),
          SurveyViewModel(
            id: surveys[1].id,
            question: surveys[1].question,
            date: '20 Dec 2018',
            didAnswer: surveys[1].didAnswer,
          ),
        ])));

    await sut.loadData();
  });

  test('Should emit correct events on failure', () async {
    mockLoadSurveysError();

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.surveysStream.listen(null,
        onError: expectAsync1(
            (error) => expect(error, UIError.unexpected.description)));

    await sut.loadData();
  });

  test('Should emit correct events on access denied', () async {
    mockAccessDeniedError();

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(sut.isSessionExpiredStream, emits(true));

    await sut.loadData();
  });

  test('Should go to SurveyResultPage on survey click', () async {
    expectLater(sut.navigateToStream,
        emitsInOrder(['/survey_result/any_route', '/survey_result/any_route']));

    sut.goToSurveyResult('any_route');
    sut.goToSurveyResult('any_route');
  });
}
