// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/data/cache/cache.dart';
import 'package:for_dev/data/http/http.dart';

import 'package:for_dev/main/decorators/decorators.dart';

// Annotation which generates the authorize_http_client_decorator_test.mocks.dart library and the MockFetchSecureCacheStorage, MockDeleteSecureCacheStorage  and MockHttpClient class.
@GenerateNiceMocks([
  MockSpec<FetchSecureCacheStorage>(),
  MockSpec<DeleteSecureCacheStorage>(),
  MockSpec<HttpClient>(),
])
import './authorize_http_client_decorator_test.mocks.dart';

void main() {
  late MockFetchSecureCacheStorage fetchSecureCacheStorage;
  late MockDeleteSecureCacheStorage deleteSecureCacheStorage;
  late MockHttpClient httpClient;
  late AuthorizeHttpClientDecorator sut;
  late String url;
  late String method;
  late Map body;
  late String token;
  late String httpResponse;

  PostExpectation mockTokenCall() => when(fetchSecureCacheStorage.fetch(any));

  void mockToken() {
    token = faker.guid.guid();
    mockTokenCall().thenAnswer((_) async => token);
  }

  void mockTokenError() {
    mockTokenCall().thenThrow(Exception());
  }

  PostExpectation mockHttpResponseCall() => when(httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body'),
        headers: anyNamed('headers'),
      ));

  void mockHttpResponse() {
    httpResponse = faker.randomGenerator.string(50);
    mockHttpResponseCall().thenAnswer((_) async => httpResponse);
  }

  void mockHttpResponseError(HttpError error) {
    mockHttpResponseCall().thenThrow(error);
  }

  setUp(() {
    fetchSecureCacheStorage = MockFetchSecureCacheStorage();
    deleteSecureCacheStorage = MockDeleteSecureCacheStorage();
    httpClient = MockHttpClient();
    sut = AuthorizeHttpClientDecorator(
      fetchSecureCacheStorage: fetchSecureCacheStorage,
      deleteSecureCacheStorage: deleteSecureCacheStorage,
      decoratee: httpClient,
    );
    url = faker.internet.httpUrl();
    method = faker.randomGenerator.string(10);
    body = {'any_key': 'any_value'};
    mockToken();
    mockHttpResponse();
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {
    await sut.request(url: url, method: method, body: body);

    verify(fetchSecureCacheStorage.fetch('token')).called(1);
  });

  test('Should call decoratee with access token on header', () async {
    await sut.request(url: url, method: method, body: body);
    verify(httpClient.request(
      url: url,
      method: method,
      body: body,
      headers: {'x-access-token': token},
    )).called(1);

    await sut.request(
      url: url,
      method: method,
      body: body,
      headers: {'any_header': 'any_value'},
    );
    verify(httpClient.request(
      url: url,
      method: method,
      body: body,
      headers: {'x-access-token': token, 'any_header': 'any_value'},
    )).called(1);
  });

  test('Should return same result as decoratee', () async {
    final response = await sut.request(url: url, method: method, body: body);

    expect(response, httpResponse);
  });

  test('Should throw ForbiddenError if FetchSecureCacheStorage throws',
      () async {
    mockTokenError();

    final future = sut.request(url: url, method: method, body: body);

    expect(future, throwsA(HttpError.forbidden));
    verify(deleteSecureCacheStorage.delete('token')).called(1);
  });

  test('Should rethrow if decoratee throws', () async {
    mockHttpResponseError(HttpError.badRequest);

    final future = sut.request(url: url, method: method, body: body);

    expect(future, throwsA(HttpError.badRequest));
  });

  // test('Should delete cache if request throws ForbiddenError', () async {
  //   mockHttpResponseError(HttpError.forbidden);

  //   final future = sut.request(url: url, method: method, body: body);
  //   await untilCalled(deleteSecureCacheStorage.delete('token'));

  //   expect(future, throwsA(HttpError.forbidden));
  //   verify(deleteSecureCacheStorage.delete('token')).called(1);
  // });
}
