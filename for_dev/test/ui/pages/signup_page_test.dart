import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/ui/helpers/helpers.dart';
import 'package:for_dev/ui/pages/pages.dart';

// Annotation which generates the signup_page_test.mocks.dart library and the MockSignUpPresenter class.
@GenerateNiceMocks([MockSpec<SignUpPresenter>()])
import './signup_page_test.mocks.dart';

void main() {
  late SignUpPresenter presenter;
  late StreamController<UIError?> nameErrorController;
  late StreamController<UIError?> emailErrorController;
  late StreamController<UIError?> passwordErrorController;
  late StreamController<UIError?> passwordConfirmationErrorController;
  late StreamController<bool> isFormValidController;
  late StreamController<bool> isLoadingController;

  void initStreams() {
    nameErrorController = StreamController<UIError?>();
    emailErrorController = StreamController<UIError?>();
    passwordErrorController = StreamController<UIError?>();
    passwordConfirmationErrorController = StreamController<UIError?>();
    isFormValidController = StreamController<bool>();
    isLoadingController = StreamController<bool>();
  }

  void mockStreams() {
    when(presenter.nameErrorStream)
        .thenAnswer((_) => nameErrorController.stream);
    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);
    when(presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);
    when(presenter.passwordConfirmationErrorStream)
        .thenAnswer((_) => passwordConfirmationErrorController.stream);
    when(presenter.isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
  }

  void closeStreams() {
    nameErrorController.close();
    emailErrorController.close();
    passwordErrorController.close();
    passwordConfirmationErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = MockSignUpPresenter();
    initStreams();
    mockStreams();
    final signUpPage = GetMaterialApp(
      initialRoute: '/signup',
      getPages: [
        GetPage(name: '/signup', page: () => SignUpPage(presenter)),
      ],
    );
    await tester.pumpWidget(signUpPage);
  }

  tearDown(() {
    closeStreams();
  });

  testWidgets('Should load with correct initial state',
      (WidgetTester tester) async {
    await loadPage(tester);

    final nameTextChildren = find.descendant(
        of: find.bySemanticsLabel('Nome'), matching: find.byType(Text));
    expect(
      nameTextChildren,
      findsOneWidget,
      reason:
          'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the label text',
    );

    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(
      emailTextChildren,
      findsOneWidget,
      reason:
          'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the label text',
    );

    final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(
      passwordTextChildren,
      findsOneWidget,
      reason:
          'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the label text',
    );

    final passwordConfirmationTextChildren = find.descendant(
        of: find.bySemanticsLabel('Confirmar senha'),
        matching: find.byType(Text));
    expect(
      passwordConfirmationTextChildren,
      findsOneWidget,
      reason:
          'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the label text',
    );

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should call validate with correct values',
      (WidgetTester tester) async {
    await loadPage(tester);

    final name = faker.person.name();
    await tester.enterText(find.bySemanticsLabel('Nome'), name);
    verify(presenter.validateName(name));

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email'), email);
    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(presenter.validatePassword(password));

    await tester.enterText(find.bySemanticsLabel('Confirmar senha'), password);
    verify(presenter.validatePasswordConfirmation(password));
  });

  testWidgets('Should present email error', (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido.'), findsOneWidget);

    emailErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório.'), findsOneWidget);

    emailErrorController.add(null);
    await tester.pump();
    expect(
      find.descendant(
        of: find.bySemanticsLabel('Email'),
        matching: find.byType(Text),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Should present name error', (WidgetTester tester) async {
    await loadPage(tester);

    nameErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido.'), findsOneWidget);

    nameErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório.'), findsOneWidget);

    nameErrorController.add(null);
    await tester.pump();
    expect(
      find.descendant(
        of: find.bySemanticsLabel('Nome'),
        matching: find.byType(Text),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Should present password error', (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido.'), findsOneWidget);

    passwordErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório.'), findsOneWidget);

    passwordErrorController.add(null);
    await tester.pump();
    expect(
      find.descendant(
        of: find.bySemanticsLabel('Senha'),
        matching: find.byType(Text),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Should present passwordConfirmation error',
      (WidgetTester tester) async {
    await loadPage(tester);

    passwordConfirmationErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido.'), findsOneWidget);

    passwordConfirmationErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório.'), findsOneWidget);

    passwordConfirmationErrorController.add(null);
    await tester.pump();
    expect(
      find.descendant(
        of: find.bySemanticsLabel('Confirmar senha'),
        matching: find.byType(Text),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Should enabled button if form is valid',
      (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Should disable button if form is invalid',
      (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(false);
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });

  testWidgets('Should call signUp on form submit', (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();
    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(presenter.signUp()).called(1);
  });

  testWidgets('Should present loading', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should hide loading', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();
    isLoadingController.add(false);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
