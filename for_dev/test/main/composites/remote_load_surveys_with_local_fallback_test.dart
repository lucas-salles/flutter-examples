import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/data/usecases/usecases.dart';
import 'package:for_dev/domain/entities/entities.dart';

// Annotation which generates the remote_load_surveys_with_local_fallback_test.mocks.dart library and the MockRemoteLoadSurveys and MockLocalLoadSurveys class.
@GenerateNiceMocks([
  MockSpec<RemoteLoadSurveys>(),
  MockSpec<LocalLoadSurveys>(),
])
import 'remote_load_surveys_with_local_fallback_test.mocks.dart';

class RemoteLoadSurveysWithLocalFallback {
  final RemoteLoadSurveys remote;
  final LocalLoadSurveys local;

  RemoteLoadSurveysWithLocalFallback({
    required this.remote,
    required this.local,
  });

  Future<void> load() async {
    final surveys = await remote.load();
    await local.save(surveys);
  }
}

void main() {
  late MockRemoteLoadSurveys remote;
  late MockLocalLoadSurveys local;
  late RemoteLoadSurveysWithLocalFallback sut;
  late List<SurveyEntity> surveys;

  List<SurveyEntity> mockSurveys() => [
        SurveyEntity(
          id: faker.guid.guid(),
          question: faker.randomGenerator.string(10),
          dateTime: faker.date.dateTime(),
          didAnswer: faker.randomGenerator.boolean(),
        )
      ];

  void mockRemoteLoad() {
    surveys = mockSurveys();
    when(remote.load()).thenAnswer((_) async => surveys);
  }

  setUp(() {
    remote = MockRemoteLoadSurveys();
    local = MockLocalLoadSurveys();
    sut = RemoteLoadSurveysWithLocalFallback(remote: remote, local: local);
    mockRemoteLoad();
  });

  test('Should call remote load', () async {
    await sut.load();

    verify(remote.load()).called(1);
  });

  test('Should call local save with remote data', () async {
    await sut.load();

    verify(local.save(surveys)).called(1);
  });
}
