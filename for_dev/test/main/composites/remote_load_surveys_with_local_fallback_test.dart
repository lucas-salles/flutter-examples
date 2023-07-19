import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/data/usecases/usecases.dart';

// Annotation which generates the remote_load_surveys_with_local_fallback_test.mocks.dart library and the MockRemoteLoadSurveys class.
@GenerateNiceMocks([MockSpec<RemoteLoadSurveys>()])
import 'remote_load_surveys_with_local_fallback_test.mocks.dart';

class RemoteLoadSurveysWithLocalFallback {
  final RemoteLoadSurveys remote;

  RemoteLoadSurveysWithLocalFallback({required this.remote});

  Future<void> load() async {
    await remote.load();
  }
}

void main() {
  late MockRemoteLoadSurveys remote;
  late RemoteLoadSurveysWithLocalFallback sut;

  setUp(() {
    remote = MockRemoteLoadSurveys();
    sut = RemoteLoadSurveysWithLocalFallback(remote: remote);
  });

  test('Should call remote load', () async {
    await sut.load();

    verify(remote.load()).called(1);
  });
}
