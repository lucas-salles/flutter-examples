import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/domain/helpers/helpers.dart';
import 'package:for_dev/domain/entities/entities.dart';

import 'package:for_dev/data/cache/cache.dart';
import 'package:for_dev/data/usecases/usecases.dart';

// Annotation which generates the local_load_current_account_test.mocks.dart library and the MockFetchSecureCacheStorage class.
@GenerateNiceMocks([MockSpec<FetchSecureCacheStorage>()])
import './local_load_current_account_test.mocks.dart';

void main() {
  late MockFetchSecureCacheStorage fetchSecureCacheStorage;
  late LocalLoadCurrentAccount sut;
  late String token;

  PostExpectation mockFetchSecureCall() =>
      when(fetchSecureCacheStorage.fetch(any));

  void mockFetchSecure(String? data) =>
      mockFetchSecureCall().thenAnswer((_) async => data);

  void mockFetchSecureError() => mockFetchSecureCall().thenThrow(Exception());

  setUp(() {
    fetchSecureCacheStorage = MockFetchSecureCacheStorage();
    sut = LocalLoadCurrentAccount(
        fetchSecureCacheStorage: fetchSecureCacheStorage);
    token = faker.guid.guid();
    mockFetchSecure(token);
  });

  test('Should call FetchSecureCacheStorage with correct value', () async {
    await sut.load();

    verify(fetchSecureCacheStorage.fetch('token'));
  });

  test('Should return an AccountEntity', () async {
    final account = await sut.load();

    expect(account, AccountEntity(token));
  });

  test('Should throw UnexpectedError if FetchSecureCacheStorage throws', () {
    mockFetchSecureError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if FetchSecureCacheStorage returns null',
      () {
    mockFetchSecure(null);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
