import 'package:flutter_test/flutter_test.dart';
import 'package:get/route_manager.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:for_dev/ui/pages/pages.dart';

// Annotation which generates the survey_result_page_test.mocks.dart library and the MockSurveyResultPresenter class.
@GenerateNiceMocks([MockSpec<SurveyResultPresenter>()])
import './survey_result_page_test.mocks.dart';

void main() {
  late MockSurveyResultPresenter presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = MockSurveyResultPresenter();
    final surveysPage = GetMaterialApp(
      initialRoute: '/survey_result/any_survey_id',
      getPages: [
        GetPage(
          name: '/survey_result/:survey_id',
          page: () => SurveyResultPage(presenter),
        )
      ],
    );
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(surveysPage);
    });
  }

  testWidgets('Should call LoadSurveyResult on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.loadData()).called(1);
  });
}
