import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/domain/entities/entities.dart';
import 'package:for_dev/domain/helpers/helpers.dart';
import 'package:for_dev/domain/usecases/usecases.dart';

import 'package:for_dev/ui/helpers/helpers.dart';
import 'package:for_dev/ui/pages/pages.dart';

import 'package:for_dev/presentation/presenters/presenters.dart';

// Annotation which generates the getx_survey_result_presenter_test.mocks.dart library and the MockLoadSurveyResult and MockSaveSurveyResult class.
@GenerateNiceMocks([
  MockSpec<LoadSurveyResult>(),
  MockSpec<SaveSurveyResult>(),
])
import './getx_survey_result_presenter_test.mocks.dart';

void main() {
  late MockLoadSurveyResult loadSurveyResult;
  late MockSaveSurveyResult saveSurveyResult;
  late GetxSurveyResultPresenter sut;
  late SurveyResultEntity loadResult;
  late SurveyResultEntity saveResult;
  late String surveyId;
  late String answer;

  SurveyResultEntity mockValidData() => SurveyResultEntity(
        surveyId: faker.guid.guid(),
        question: faker.lorem.sentence(),
        answers: [
          SurveyAnswerEntity(
            image: faker.internet.httpUrl(),
            answer: faker.lorem.sentence(),
            isCurrentAnswer: faker.randomGenerator.boolean(),
            percent: faker.randomGenerator.integer(100),
          ),
          SurveyAnswerEntity(
            answer: faker.lorem.sentence(),
            isCurrentAnswer: faker.randomGenerator.boolean(),
            percent: faker.randomGenerator.integer(100),
          ),
        ],
      );

  PostExpectation mockLoadSurveyResultCall() =>
      when(loadSurveyResult.loadBySurvey(surveyId: anyNamed('surveyId')));

  void mockLoadSurveyResult(SurveyResultEntity data) {
    loadResult = data;
    mockLoadSurveyResultCall().thenAnswer((_) async => loadResult);
  }

  void mockLoadSurveyResultError() =>
      mockLoadSurveyResultCall().thenThrow(DomainError.unexpected);

  void mockAccessDeniedError() =>
      mockLoadSurveyResultCall().thenThrow(DomainError.accessDenied);

  PostExpectation mockSaveSurveyResultCall() =>
      when(saveSurveyResult.save(answer: anyNamed('answer')));

  void mockSaveSurveyResult(SurveyResultEntity data) {
    saveResult = data;
    mockSaveSurveyResultCall().thenAnswer((_) async => saveResult);
  }

  setUp(() {
    surveyId = faker.guid.guid();
    answer = faker.lorem.sentence();
    loadSurveyResult = MockLoadSurveyResult();
    saveSurveyResult = MockSaveSurveyResult();
    sut = GetxSurveyResultPresenter(
      loadSurveyResult: loadSurveyResult,
      saveSurveyResult: saveSurveyResult,
      surveyId: surveyId,
    );
    mockLoadSurveyResult(mockValidData());
    mockSaveSurveyResult(mockValidData());
  });

  group('loadData', () {
    test('Should call LoadSurveyResult on loadData', () async {
      await sut.loadData();

      verify(loadSurveyResult.loadBySurvey(surveyId: surveyId)).called(1);
    });

    test('Should emit correct events on success', () async {
      expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
      sut.surveyResultStream.listen(expectAsync1((result) => expect(
          result,
          SurveyResultViewModel(
            surveyId: loadResult.surveyId,
            question: loadResult.question,
            answers: [
              SurveyAnswerViewModel(
                image: loadResult.answers[0].image,
                answer: loadResult.answers[0].answer,
                isCurrentAnswer: loadResult.answers[0].isCurrentAnswer,
                percent: '${loadResult.answers[0].percent}%',
              ),
              SurveyAnswerViewModel(
                answer: loadResult.answers[1].answer,
                isCurrentAnswer: loadResult.answers[1].isCurrentAnswer,
                percent: '${loadResult.answers[1].percent}%',
              ),
            ],
          ))));

      await sut.loadData();
    });

    test('Should emit correct events on failure', () async {
      mockLoadSurveyResultError();

      expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
      sut.surveyResultStream.listen(null,
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
  });

  group('save', () {
    test('Should call SaveSurveyResult on save', () async {
      await sut.save(answer: answer);

      verify(saveSurveyResult.save(answer: answer)).called(1);
    });

    test('Should emit correct events on success', () async {
      expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
      sut.surveyResultStream.listen(expectAsync1((result) => expect(
          result,
          SurveyResultViewModel(
            surveyId: saveResult.surveyId,
            question: saveResult.question,
            answers: [
              SurveyAnswerViewModel(
                image: saveResult.answers[0].image,
                answer: saveResult.answers[0].answer,
                isCurrentAnswer: saveResult.answers[0].isCurrentAnswer,
                percent: '${saveResult.answers[0].percent}%',
              ),
              SurveyAnswerViewModel(
                answer: saveResult.answers[1].answer,
                isCurrentAnswer: saveResult.answers[1].isCurrentAnswer,
                percent: '${saveResult.answers[1].percent}%',
              ),
            ],
          ))));

      await sut.save(answer: answer);
    });
  });
}
