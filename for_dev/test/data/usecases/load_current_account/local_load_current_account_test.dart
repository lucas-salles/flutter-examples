import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Annotation which generates the local_load_current_account_test.mocks.dart library and the MockFetchSecureCacheStorage class.
@GenerateNiceMocks([MockSpec<FetchSecureCacheStorage>()])
import './local_load_current_account_test.mocks.dart';

class LocalLoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  const LocalLoadCurrentAccount({required this.fetchSecureCacheStorage});

  Future<void> load() async {
    await fetchSecureCacheStorage.fetchSecure('token');
  }
}

abstract class FetchSecureCacheStorage {
  Future<void> fetchSecure(String key);
}

void main() {
  test('Should call FetchSecureCacheStorage with correct value', () async {
    final fetchSecureCacheStorage = MockFetchSecureCacheStorage();
    final sut = LocalLoadCurrentAccount(
        fetchSecureCacheStorage: fetchSecureCacheStorage);

    await sut.load();

    verify(fetchSecureCacheStorage.fetchSecure('token'));
  });
}
