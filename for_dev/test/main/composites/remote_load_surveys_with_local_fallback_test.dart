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
  test('Should call remote load', () async {
    final remote = MockRemoteLoadSurveys();
    final sut = RemoteLoadSurveysWithLocalFallback(remote: remote);

    await sut.load();

    verify(remote.load()).called(1);
  });
}
