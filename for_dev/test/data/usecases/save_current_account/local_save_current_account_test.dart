import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:for_dev/domain/helpers/helpers.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/domain/entities/entities.dart';
import 'package:for_dev/domain/usecases/usecases.dart';

// Annotation which generates the local_save_current_account_test.mocks.dart library and the SaveSecureCacheStorage class.
@GenerateNiceMocks([MockSpec<SaveSecureCacheStorage>()])
import './local_save_current_account_test.mocks.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  const LocalSaveCurrentAccount({required this.saveSecureCacheStorage});

  @override
  Future<void> save(AccountEntity account) async {
    try {
      await saveSecureCacheStorage.saveSecure(
          key: 'token', value: account.token);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}

abstract class SaveSecureCacheStorage {
  Future<void> saveSecure({required String key, required String value});
}

void main() {
  test('Should call SaveSecureCacheStorage with correct values', () async {
    final saveSecureCacheStorage = MockSaveSecureCacheStorage();
    final sut =
        LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    final account = AccountEntity(faker.guid.guid());

    await sut.save(account);

    verify(saveSecureCacheStorage.saveSecure(
      key: 'token',
      value: account.token,
    ));
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage throws',
      () async {
    final saveSecureCacheStorage = MockSaveSecureCacheStorage();
    final sut =
        LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    final account = AccountEntity(faker.guid.guid());
    when(saveSecureCacheStorage.saveSecure(
            key: anyNamed('key'), value: anyNamed('value')))
        .thenThrow(Exception());

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}