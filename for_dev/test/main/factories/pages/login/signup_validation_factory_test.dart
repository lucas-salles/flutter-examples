import 'package:flutter_test/flutter_test.dart';

import 'package:for_dev/main/factories/factories.dart';
import 'package:for_dev/validation/validators/validators.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeSignUpValidations();

    expect(validations, const [
      RequiredFieldValidation('name'),
      MinLengthValidation(field: 'name', size: 3),
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
      MinLengthValidation(field: 'password', size: 3),
      RequiredFieldValidation('passwordConfirmation'),
      CompareFieldsValidation(
          field: 'passwordConfirmation', fieldToCompare: 'password'),
    ]);
  });
}
