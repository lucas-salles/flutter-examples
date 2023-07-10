import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/ui/helpers/errors/errors.dart';

import 'package:for_dev/presentation/presenters/presenters.dart';
import 'package:for_dev/presentation/protocols/protocols.dart';

// Annotation which generates the getx_signup_presenter_test.mocks.dart library and the MockValidation class.
@GenerateNiceMocks([MockSpec<Validation>()])
import './getx_signup_presenter_test.mocks.dart';

void main() {
  late GetxSignUpPresenter sut;
  late MockValidation validation;
  late String email;

  PostExpectation mockValidationCall(String? field) => when(validation.validate(
      field: field ?? anyNamed('field'), value: anyNamed('value')));

  void mockValidation({String? field, ValidationError? value}) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    validation = MockValidation();
    sut = GetxSignUpPresenter(validation: validation);
    email = faker.internet.email();
    mockValidation();
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
}
