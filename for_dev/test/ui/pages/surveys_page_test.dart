import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/ui/helpers/helpers.dart';
import 'package:for_dev/ui/pages/pages.dart';

import '../mocks/mocks.dart';
import '../helpers/helpers.dart';

// Annotation which generates the surveys_page_test.mocks.dart library and the MockSurveysPresenter class.
@GenerateNiceMocks([MockSpec<SurveysPresenter>()])
import './surveys_page_test.mocks.dart';

void main() {
  late MockSurveysPresenter presenter;
  late StreamController<bool> isLoadingController;
  late StreamController<bool> isSessionExpiredController;
  late StreamController<List<SurveyViewModel>> surveysController;
  late StreamController<String?> navigateToController;

  void initStreams() {
    isLoadingController = StreamController<bool>();
    isSessionExpiredController = StreamController<bool>();
    surveysController = StreamController<List<SurveyViewModel>>();
    navigateToController = StreamController<String?>();
  }

  void mockStreams() {
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
    when(presenter.isSessionExpiredStream)
        .thenAnswer((_) => isSessionExpiredController.stream);
    when(presenter.surveysStream).thenAnswer((_) => surveysController.stream);
    when(presenter.navigateToStream)
        .thenAnswer((_) => navigateToController.stream);
  }

  void closeStreams() {
    isLoadingController.close();
    surveysController.close();
    navigateToController.close();
    isSessionExpiredController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = MockSurveysPresenter();
    initStreams();
    mockStreams();
    await tester.pumpWidget(makePage(
      path: '/surveys',
      page: () => SurveysPage(presenter),
    ));
  }

  tearDown(() {
    closeStreams();
  });

  testWidgets('Should call LoadSurveys on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.loadData()).called(1);
  });

  testWidgets('Should call LoadSurveys on reload', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('/any_route');
    await tester.pumpAndSettle();
    await tester.pageBack();

    verify(presenter.loadData()).called(2);
  });

  testWidgets('Should handle loading correctly', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    isLoadingController.add(false);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);

    isLoadingController.add(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should present error if surveysStream fails',
      (WidgetTester tester) async {
    await loadPage(tester);

    surveysController.addError(UIError.unexpected.description);
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'),
        findsOneWidget);
    expect(find.text('Recarregar'), findsOneWidget);
    expect(find.text('Question 1'), findsNothing);
  });

  testWidgets('Should present list if surveysStream succeeds',
      (WidgetTester tester) async {
    await loadPage(tester);

    surveysController.add(ViewModelFactory.makeSurveyList());
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'),
        findsNothing);
    expect(find.text('Recarregar'), findsNothing);
    expect(find.text('Question 1'), findsWidgets);
    expect(find.text('Question 2'), findsWidgets);
    expect(find.text('Date 1'), findsWidgets);
    expect(find.text('Date 2'), findsWidgets);
  });

  testWidgets('Should call LoadSurveys on reload button click',
      (WidgetTester tester) async {
    await loadPage(tester);

    surveysController.addError(UIError.unexpected.description);
    await tester.pump();
    await tester.tap(find.text('Recarregar'));

    verify(presenter.loadData()).called(2);
  });

  testWidgets('Should call goToSurveyResult on survey click',
      (WidgetTester tester) async {
    await loadPage(tester);

    surveysController.add(ViewModelFactory.makeSurveyList());
    await tester.pump();

    await tester.tap(find.text('Question 1'));
    await tester.pump();

    verify(presenter.goToSurveyResult('1')).called(1);
  });

  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('/any_route');
    await tester.pumpAndSettle();

    expect(currentRoute, '/any_route');
    expect(find.text('fake page'), findsOneWidget);
  });

  testWidgets('Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('');
    await tester.pump();
    expect(currentRoute, '/surveys');
  });

  testWidgets('Should logout', (WidgetTester tester) async {
    await loadPage(tester);

    isSessionExpiredController.add(true);
    await tester.pumpAndSettle();

    expect(currentRoute, '/login');
    expect(find.text('fake login'), findsOneWidget);
  });

  testWidgets('Should not logout', (WidgetTester tester) async {
    await loadPage(tester);

    isSessionExpiredController.add(false);
    await tester.pump();
    expect(currentRoute, '/surveys');
  });
}
