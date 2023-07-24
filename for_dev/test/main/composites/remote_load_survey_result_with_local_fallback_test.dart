// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/data/usecases/usecases.dart';

// Annotation which generates the remote_load_survey_result_with_local_fallback_test.mocks.dart library and the MockLoadSurveyResult class.
@GenerateNiceMocks([MockSpec<RemoteLoadSurveyResult>()])
import 'remote_load_survey_result_with_local_fallback_test.mocks.dart';

class RemoteLoadSurveyResultWithLocalFallback {
  final RemoteLoadSurveyResult remote;

  RemoteLoadSurveyResultWithLocalFallback({required this.remote});

  Future<void> loadBySurvey({String? surveyId}) async {
    await remote.loadBySurvey(surveyId: surveyId);
  }
}

void main() {
  test('Should call remote LoadBySurvey', () async {
    final surveyId = faker.guid.guid();
    final remote = MockRemoteLoadSurveyResult();
    final sut = RemoteLoadSurveyResultWithLocalFallback(remote: remote);

    await sut.loadBySurvey(surveyId: surveyId);

    verify(remote.loadBySurvey(surveyId: surveyId)).called(1);
  });
}
