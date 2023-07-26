import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/data/http/http.dart';
import 'package:for_dev/data/usecases/usecases.dart';
import 'package:for_dev/domain/entities/entities.dart';
import 'package:for_dev/domain/helpers/helpers.dart';

import '../../../mocks/mocks.dart';

// Annotation which generates the remote_save_survey_result_test.mocks.dart library and the MockHttpClient class.
@GenerateNiceMocks([MockSpec<HttpClient>()])
import './remote_save_survey_result_test.mocks.dart';

void main() {
  late String url;
  late String answer;
  late MockHttpClient httpClient;
  late RemoteSaveSurveyResult sut;
  late Map surveyResult;

  PostExpectation mockRequest() => when(httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body'),
      ));

  void mockHttpData(Map data) {
    surveyResult = data;
    mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) => mockRequest().thenThrow(error);

  setUp(() {
    url = faker.internet.httpUrl();
    answer = faker.lorem.sentence();
    httpClient = MockHttpClient();
    sut = RemoteSaveSurveyResult(url: url, httpClient: httpClient);
    mockHttpData(FakeSurveyResultFactory.makeApiJson());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.save(answer: answer);

    verify(httpClient.request(
      url: url,
      method: 'put',
      body: {'answer': answer},
    ));
  });

  test('Should return surveyResult on 200', () async {
    final result = await sut.save(answer: answer);

    expect(
      result,
      SurveyResultEntity(
        surveyId: surveyResult['surveyId'],
        question: surveyResult['question'],
        answers: [
          SurveyAnswerEntity(
            image: surveyResult['answers'][0]['image'],
            answer: surveyResult['answers'][0]['answer'],
            isCurrentAnswer: surveyResult['answers'][0]
                ['isCurrentAccountAnswer'],
            percent: surveyResult['answers'][0]['percent'],
          ),
          SurveyAnswerEntity(
            answer: surveyResult['answers'][1]['answer'],
            isCurrentAnswer: surveyResult['answers'][1]
                ['isCurrentAccountAnswer'],
            percent: surveyResult['answers'][1]['percent'],
          ),
        ],
      ),
    );
  });

  test(
      'Should throw UnexpectedError if HttpClient returns 200 with invalid data',
      () async {
    mockHttpData(FakeSurveyResultFactory.makeInvalidApiJson());

    final response = sut.save(answer: answer);

    expect(response, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final response = sut.save(answer: answer);

    expect(response, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final response = sut.save(answer: answer);

    expect(response, throwsA(DomainError.unexpected));
  });

  test('Should throw AccessDeniedError if HttpClient returns 403', () async {
    mockHttpError(HttpError.forbidden);

    final response = sut.save(answer: answer);

    expect(response, throwsA(DomainError.accessDenied));
  });
}
