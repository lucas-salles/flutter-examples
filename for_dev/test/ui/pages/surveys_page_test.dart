import 'package:flutter_test/flutter_test.dart';
import 'package:get/route_manager.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/ui/pages/pages.dart';

// Annotation which generates the surveys_page_test.mocks.dart library and the MockSurveysPresenter class.
@GenerateNiceMocks([MockSpec<SurveysPresenter>()])
import './surveys_page_test.mocks.dart';

void main() {
  late MockSurveysPresenter presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = MockSurveysPresenter();
    final surveysPage = GetMaterialApp(
      initialRoute: '/surveys',
      getPages: [GetPage(name: '/surveys', page: () => SurveysPage(presenter))],
    );
    await tester.pumpWidget(surveysPage);
  }

  testWidgets('Should call LoadSurveys on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.loadData()).called(1);
  });
}
