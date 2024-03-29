import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/ui/pages/pages.dart';

import '../helpers/helpers.dart';

// Annotation which generates the splash_page_test.mocks.dart library and the MockSplashPresenter class.
@GenerateNiceMocks([MockSpec<SplashPresenter>()])
import './splash_page_test.mocks.dart';

void main() {
  late MockSplashPresenter presenter;
  late StreamController<String?> navigateToController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = MockSplashPresenter();
    navigateToController = StreamController<String?>();
    when(presenter.navigateToStream)
        .thenAnswer((_) => navigateToController.stream);
    await tester.pumpWidget(makePage(
      path: '/',
      page: () => SplashPage(presenter: presenter),
    ));
  }

  tearDown(() => navigateToController.close());

  testWidgets('Should present spinner on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should call loadCurrentAccount on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.checkAccount()).called(1);
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

    expect(currentRoute, '/');
  });
}
