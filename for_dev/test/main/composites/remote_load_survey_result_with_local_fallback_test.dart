import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/data/usecases/usecases.dart';
import 'package:for_dev/domain/entities/entities.dart';

// Annotation which generates the remote_load_survey_result_with_local_fallback_test.mocks.dart library and the MockRemoteLoadSurveyResult and MockLocalLoadSurveyResult class.
@GenerateNiceMocks([
  MockSpec<RemoteLoadSurveyResult>(),
  MockSpec<LocalLoadSurveyResult>(),
])
import 'remote_load_survey_result_with_local_fallback_test.mocks.dart';

class RemoteLoadSurveyResultWithLocalFallback {
  final RemoteLoadSurveyResult remote;
  final LocalLoadSurveyResult local;

  RemoteLoadSurveyResultWithLocalFallback({
    required this.remote,
    required this.local,
  });

  Future<void> loadBySurvey({String? surveyId}) async {
    final surveyResult = await remote.loadBySurvey(surveyId: surveyId);
    await local.save(surveyId: surveyId!, surveyResult: surveyResult);
  }
}

void main() {
  late MockRemoteLoadSurveyResult remote;
  late MockLocalLoadSurveyResult local;
  late RemoteLoadSurveyResultWithLocalFallback sut;
  late String surveyId;
  late SurveyResultEntity surveyResult;

  void mockSurveyResult() {
    surveyResult = SurveyResultEntity(
      surveyId: faker.guid.guid(),
      question: faker.lorem.sentence(),
      answers: [
        SurveyAnswerEntity(
          answer: faker.lorem.sentence(),
          isCurrentAnswer: faker.randomGenerator.boolean(),
          percent: faker.randomGenerator.integer(100),
        ),
      ],
    );
    when(remote.loadBySurvey(surveyId: anyNamed('surveyId')))
        .thenAnswer((_) async => surveyResult);
  }

  setUp(() {
    surveyId = faker.guid.guid();
    remote = MockRemoteLoadSurveyResult();
    local = MockLocalLoadSurveyResult();
    sut = RemoteLoadSurveyResultWithLocalFallback(remote: remote, local: local);
    mockSurveyResult();
  });

  test('Should call remote LoadBySurvey', () async {
    await sut.loadBySurvey(surveyId: surveyId);

    verify(remote.loadBySurvey(surveyId: surveyId)).called(1);
  });

  test('Should call local save with remote data', () async {
    await sut.loadBySurvey(surveyId: surveyId);

    verify(local.save(surveyId: surveyId, surveyResult: surveyResult))
        .called(1);
  });
}
