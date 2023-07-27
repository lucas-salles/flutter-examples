import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/data/usecases/usecases.dart';
import 'package:for_dev/domain/entities/entities.dart';
import 'package:for_dev/domain/helpers/helpers.dart';
import 'package:for_dev/main/composites/composites.dart';

import '../../domain/mocks/mocks.dart';

// Annotation which generates the remote_load_surveys_with_local_fallback_test.mocks.dart library and the MockRemoteLoadSurveys and MockLocalLoadSurveys class.
@GenerateNiceMocks([
  MockSpec<RemoteLoadSurveys>(),
  MockSpec<LocalLoadSurveys>(),
])
import 'remote_load_surveys_with_local_fallback_test.mocks.dart';

void main() {
  late MockRemoteLoadSurveys remote;
  late MockLocalLoadSurveys local;
  late RemoteLoadSurveysWithLocalFallback sut;
  late List<SurveyEntity> remoteSurveys;
  late List<SurveyEntity> localSurveys;

  PostExpectation mockRemoteLoadCall() => when(remote.load());

  void mockRemoteLoad() {
    remoteSurveys = EntityFactory.makeSurveyList();
    mockRemoteLoadCall().thenAnswer((_) async => remoteSurveys);
  }

  void mockRemoteLoadError(DomainError error) =>
      mockRemoteLoadCall().thenThrow(error);

  PostExpectation mockLocalLoadCall() => when(local.load());

  void mockLocalLoad() {
    localSurveys = EntityFactory.makeSurveyList();
    mockLocalLoadCall().thenAnswer((_) async => localSurveys);
  }

  void mockLocalLoadError() =>
      mockLocalLoadCall().thenThrow(DomainError.unexpected);

  setUp(() {
    remote = MockRemoteLoadSurveys();
    local = MockLocalLoadSurveys();
    sut = RemoteLoadSurveysWithLocalFallback(remote: remote, local: local);
    mockRemoteLoad();
    mockLocalLoad();
  });

  test('Should call remote load', () async {
    await sut.load();

    verify(remote.load()).called(1);
  });

  test('Should call local save with remote data', () async {
    await sut.load();

    verify(local.save(remoteSurveys)).called(1);
  });

  test('Should return remote surveys', () async {
    final surveys = await sut.load();

    expect(surveys, remoteSurveys);
  });

  test('Should rethrow if remote load throws AccessDeniedError', () async {
    mockRemoteLoadError(DomainError.accessDenied);

    final future = sut.load();

    expect(future, throwsA(DomainError.accessDenied));
  });

  test('Should call local fetch on remote error', () async {
    mockRemoteLoadError(DomainError.unexpected);

    await sut.load();

    verify(local.validate()).called(1);
    verify(local.load()).called(1);
  });

  test('Should return local surveys', () async {
    mockRemoteLoadError(DomainError.unexpected);

    final surveys = await sut.load();

    expect(surveys, localSurveys);
  });

  test('Should throw UnexpectedError if remote and local throws', () async {
    mockRemoteLoadError(DomainError.unexpected);
    mockLocalLoadError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
