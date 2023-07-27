import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/domain/helpers/helpers.dart';
import 'package:for_dev/domain/usecases/usecases.dart';
import 'package:for_dev/data/http/http.dart';
import 'package:for_dev/data/usecases/usecases.dart';

import '../../../domain/mocks/mocks.dart';
import '../../../infra/mocks/mocks.dart';

// Annotation which generates the remote_add_account_test.mocks.dart library and the MockHttpClient class.
@GenerateNiceMocks([MockSpec<HttpClient>()])
import './remote_add_account_test.mocks.dart';

void main() {
  late RemoteAddAccount sut;
  late MockHttpClient httpClient;
  late String url;
  late AddAccountParams params;
  late Map apiResult;

  PostExpectation mockRequest() => when(httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body'),
      ));

  void mockHttpData(Map data) {
    apiResult = data;
    mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) => mockRequest().thenThrow(error);

  setUp(() {
    httpClient = MockHttpClient();
    url = faker.internet.httpUrl();
    sut = RemoteAddAccount(httpClient: httpClient, url: url);
    params = ParamsFactory.makeAddAccount();
    mockHttpData(ApiFactory.makeAccountJson());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.add(params);

    verify(httpClient.request(
      url: url,
      method: 'post',
      body: {
        'name': params.name,
        'email': params.email,
        'password': params.password,
        'passwordConfirmation': params.passwordConfirmation,
      },
    ));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    mockHttpError(HttpError.badRequest);

    final response = sut.add(params);

    expect(response, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final response = sut.add(params);

    expect(response, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final response = sut.add(params);

    expect(response, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient returns 403',
      () async {
    mockHttpError(HttpError.forbidden);

    final response = sut.add(params);

    expect(response, throwsA(DomainError.emailInUse));
  });

  test('Should return an Account if HttpClient returns 200', () async {
    final account = await sut.add(params);

    expect(account.token, apiResult['accessToken']);
  });

  test(
      'Should throw UnexpectedError if HttpClient returns 200 with invalid data',
      () async {
    mockHttpData({'invalid_key': 'invalid_value'});

    final response = sut.add(params);

    expect(response, throwsA(DomainError.unexpected));
  });
}
