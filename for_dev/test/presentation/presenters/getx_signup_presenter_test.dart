import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/ui/helpers/errors/errors.dart';

import 'package:for_dev/domain/entities/entities.dart';
import 'package:for_dev/domain/usecases/usecases.dart';

import 'package:for_dev/presentation/presenters/presenters.dart';
import 'package:for_dev/presentation/protocols/protocols.dart';

// Annotation which generates the getx_signup_presenter_test.mocks.dart library and the MockValidation and MockAddAccount class.
@GenerateNiceMocks([
  MockSpec<Validation>(),
  MockSpec<AddAccount>(),
])
import './getx_signup_presenter_test.mocks.dart';

void main() {
  late GetxSignUpPresenter sut;
  late MockValidation validation;
  late MockAddAccount addAccount;
  late String email;
  late String name;
  late String password;
  late String passwordConfirmation;
  late String token;

  PostExpectation mockValidationCall(String? field) => when(validation.validate(
      field: field ?? anyNamed('field'), value: anyNamed('value')));

  void mockValidation({String? field, ValidationError? value}) {
    mockValidationCall(field).thenReturn(value);
  }

  PostExpectation mockAddAccountCall() => when(addAccount.add(any));

  void mockAddAccount() {
    mockAddAccountCall().thenAnswer((_) async => AccountEntity(token));
  }

  setUp(() {
    validation = MockValidation();
    addAccount = MockAddAccount();
    sut = GetxSignUpPresenter(validation: validation, addAccount: addAccount);
    email = faker.internet.email();
    name = faker.person.name();
    password = faker.internet.password();
    passwordConfirmation = faker.internet.password();
    token = faker.guid.guid();
    mockValidation();
    mockAddAccount();
  });

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email invalidFieldError if email is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    sut.emailErrorStream
        ?.listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isValidFormStream
        ?.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit email requiredFieldError if email is empty', () {
    mockValidation(value: ValidationError.requiredField);

    sut.emailErrorStream
        ?.listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isValidFormStream
        ?.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should emit null if email validation succeeds', () {
    sut.emailErrorStream?.listen(expectAsync1((error) => expect(error, null)));
    sut.isValidFormStream
        ?.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should call Validation with correct name', () {
    sut.validateName(name);

    verify(validation.validate(field: 'name', value: name)).called(1);
  });

  test('Should emit name invalidFieldError if name is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    sut.nameErrorStream
        ?.listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isValidFormStream
        ?.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
    sut.validateName(name);
  });

  test('Should emit name requiredFieldError if name is empty', () {
    mockValidation(value: ValidationError.requiredField);

    sut.nameErrorStream
        ?.listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isValidFormStream
        ?.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(name);
    sut.validateName(name);
  });

  test('Should emit null if password validation succeeds', () {
    sut.passwordErrorStream
        ?.listen(expectAsync1((error) => expect(error, null)));
    sut.isValidFormStream
        ?.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should call Validation with correct password', () {
    sut.validatePassword(password);

    verify(validation.validate(field: 'password', value: password)).called(1);
  });

  test('Should emit password invalidFieldError if password is invalid', () {
    mockValidation(value: ValidationError.invalidField);

    sut.passwordErrorStream
        ?.listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isValidFormStream
        ?.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit password requiredFieldError if password is empty', () {
    mockValidation(value: ValidationError.requiredField);

    sut.passwordErrorStream
        ?.listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isValidFormStream
        ?.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit null if password validation succeeds', () {
    sut.passwordErrorStream
        ?.listen(expectAsync1((error) => expect(error, null)));
    sut.isValidFormStream
        ?.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should call Validation with correct passwordConfirmation', () {
    sut.validatePasswordConfirmation(passwordConfirmation);

    verify(validation.validate(
            field: 'passwordConfirmation', value: passwordConfirmation))
        .called(1);
  });

  test(
      'Should emit passwordConfirmation invalidFieldError if passwordConfirmation is invalid',
      () {
    mockValidation(value: ValidationError.invalidField);

    sut.passwordConfirmationErrorStream
        ?.listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isValidFormStream
        ?.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test(
      'Should emit passwordConfirmation requiredFieldError if passwordConfirmation is empty',
      () {
    mockValidation(value: ValidationError.requiredField);

    sut.passwordConfirmationErrorStream
        ?.listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isValidFormStream
        ?.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should emit null if passwordConfirmation validation succeeds', () {
    sut.passwordConfirmationErrorStream
        ?.listen(expectAsync1((error) => expect(error, null)));
    sut.isValidFormStream
        ?.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePasswordConfirmation(passwordConfirmation);
    sut.validatePasswordConfirmation(passwordConfirmation);
  });

  test('Should enable form button if all fields are valid', () async {
    expectLater(sut.isValidFormStream, emitsInOrder([false, true]));

    sut.validateName(name);
    await Future.delayed(Duration.zero);
    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);
    await Future.delayed(Duration.zero);
    sut.validatePasswordConfirmation(passwordConfirmation);
    await Future.delayed(Duration.zero);
  });

  test('Should call AddAccount with correct values', () async {
    sut.validateName(name);
    sut.validateEmail(email);
    sut.validatePassword(password);
    sut.validatePasswordConfirmation(passwordConfirmation);

    await sut.signUp();

    verify(addAccount.add(AddAccountParams(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    ))).called(1);
  });
}