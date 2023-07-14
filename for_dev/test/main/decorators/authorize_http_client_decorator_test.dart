// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/data/cache/cache.dart';
import 'package:for_dev/data/http/http.dart';

// Annotation which generates the authorize_http_client_decorator_test.mocks.dart library and the MockFetchSecureCacheStorage and MockHttpClient class.
@GenerateNiceMocks([
  MockSpec<FetchSecureCacheStorage>(),
  MockSpec<HttpClient>(),
])
import './authorize_http_client_decorator_test.mocks.dart';

class AuthorizeHttpClientDecorator {
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  final HttpClient decoratee;

  const AuthorizeHttpClientDecorator({
    required this.fetchSecureCacheStorage,
    required this.decoratee,
  });

  Future<void> request({
    required String url,
    required String method,
    Map? body,
    Map? headers,
  }) async {
    final token = await fetchSecureCacheStorage.fetchSecure('token');
    final authorizedHeaders = {'x-access-token': token};
    await decoratee.request(
      url: url,
      method: method,
      body: body,
      headers: authorizedHeaders,
    );
  }
}

void main() {
  late MockFetchSecureCacheStorage fetchSecureCacheStorage;
  late MockHttpClient httpClient;
  late AuthorizeHttpClientDecorator sut;
  late String url;
  late String method;
  late Map body;
  late String token;

  void mockToken() {
    token = faker.guid.guid();
    when(fetchSecureCacheStorage.fetchSecure(any))
        .thenAnswer((_) async => token);
  }

  setUp(() {
    fetchSecureCacheStorage = MockFetchSecureCacheStorage();
    httpClient = MockHttpClient();
    sut = AuthorizeHttpClientDecorator(
      fetchSecureCacheStorage: fetchSecureCacheStorage,
      decoratee: httpClient,
    );
    url = faker.internet.httpUrl();
    method = faker.randomGenerator.string(10);
    body = {'any_key': 'any_value'};
    mockToken();
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {
    await sut.request(url: url, method: method, body: body);

    verify(fetchSecureCacheStorage.fetchSecure('token')).called(1);
  });

  test('Should call decoratee with access token on header', () async {
    await sut.request(url: url, method: method, body: body);

    verify(httpClient.request(
      url: url,
      method: method,
      body: body,
      headers: {'x-access-token': token},
    )).called(1);
  });
}
