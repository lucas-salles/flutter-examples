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
  late MockFetchCacheStorage fetchCacheStorage;
  late LocalLoadSurveys sut;

  setUp(() {
    fetchCacheStorage = MockFetchCacheStorage();
    sut = LocalLoadSurveys(fetchCacheStorage: fetchCacheStorage);
  });

  test('Should call FetchCacheStorage with correct key', () async {
    await sut.load();

    verify(fetchCacheStorage.fetch('surveys')).called(1);
  });
}
