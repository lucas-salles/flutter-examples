import 'package:flutter_test/flutter_test.dart';

import 'package:for_dev/presentation/protocols/protocols.dart';

import 'package:for_dev/validation/validators/validators.dart';

void main() {
  late CompareFieldsValidation sut;

  setUp(() {
    sut = CompareFieldsValidation(
        field: 'any_field', valueToCompare: 'any_value');
  });

  test('Should return error if values are not equal', () {
    final error = sut.validate('wrong_value');
    expect(error, ValidationError.invalidField);
  });

  test('Should return null if value are equal', () {
    final error = sut.validate('any_value');
    expect(error, null);
  });
}
