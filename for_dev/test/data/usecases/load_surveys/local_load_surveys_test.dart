import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Annotation which generates the local_load_surveys_test.mocks.dart library and the MockFetchCacheStorage class.
@GenerateNiceMocks([MockSpec<FetchCacheStorage>()])
import './local_load_surveys_test.mocks.dart';

abstract class FetchCacheStorage {
  Future<void> fetch(String key);
}

class LocalLoadSurveys {
  final FetchCacheStorage fetchCacheStorage;

  LocalLoadSurveys({required this.fetchCacheStorage});

  Future<void> load() async {
    await fetchCacheStorage.fetch('surveys');
  }
}

void main() {
  test('Should call FetchCacheStorage with correct key', () async {
    final fetchCacheStorage = MockFetchCacheStorage();
    final sut = LocalLoadSurveys(fetchCacheStorage: fetchCacheStorage);

    await sut.load();

    verify(fetchCacheStorage.fetch('surveys')).called(1);
  });
}
