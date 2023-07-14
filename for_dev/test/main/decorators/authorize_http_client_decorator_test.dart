import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/data/cache/cache.dart';

// Annotation which generates the authorize_http_client_decorator_test.mocks.dart library and the MockFetchSecureCacheStorage class.
@GenerateNiceMocks([MockSpec<FetchSecureCacheStorage>()])
import './authorize_http_client_decorator_test.mocks.dart';

class AuthorizeHttpClientDecorator {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  const AuthorizeHttpClientDecorator({required this.fetchSecureCacheStorage});

  Future<void> request() async {
    await fetchSecureCacheStorage.fetchSecure('token');
  }
}

void main() {
  late MockFetchSecureCacheStorage fetchSecureCacheStorage;
  late AuthorizeHttpClientDecorator sut;

  setUp(() {
    fetchSecureCacheStorage = MockFetchSecureCacheStorage();
    sut = AuthorizeHttpClientDecorator(
        fetchSecureCacheStorage: fetchSecureCacheStorage);
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {
    await sut.request();

    verify(fetchSecureCacheStorage.fetchSecure('token')).called(1);
  });
}
