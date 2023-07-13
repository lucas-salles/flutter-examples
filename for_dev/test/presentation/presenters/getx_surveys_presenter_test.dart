import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/domain/usecases/usecases.dart';

// Annotation which generates the getx_surveys_presenter_test.mocks.dart library and the MockLoadSurveys class.
@GenerateNiceMocks([MockSpec<LoadSurveys>()])
import './getx_surveys_presenter_test.mocks.dart';

class GetxSurveysPresenter {
  final LoadSurveys loadSurveys;

  GetxSurveysPresenter({required this.loadSurveys});

  Future<void> loadData() async {
    await loadSurveys.load();
  }
}

void main() {
  late MockLoadSurveys loadSurveys;
  late GetxSurveysPresenter sut;

  setUp(() {
    loadSurveys = MockLoadSurveys();
    sut = GetxSurveysPresenter(loadSurveys: loadSurveys);
  });

  test('Should call LoadSurveys on loadData', () async {
    await sut.loadData();

    verify(loadSurveys.load()).called(1);
  });
}
