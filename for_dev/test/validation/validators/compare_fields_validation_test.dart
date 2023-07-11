import 'package:flutter_test/flutter_test.dart';

import 'package:for_dev/presentation/protocols/protocols.dart';

import 'package:for_dev/validation/validators/validators.dart';

void main() {
  late CompareFieldsValidation sut;

  setUp(() {
    sut = const CompareFieldsValidation(
        field: 'any_field', fieldToCompare: 'other_field');
  });

  test('Should return error if values are not equal', () {
    final formData = {'any_field': 'any_value', 'other_field': 'other_value'};
    final error = sut.validate(formData);
    expect(error, ValidationError.invalidField);
  });

  test('Should return null if value are equal', () {
    final formData = {'any_field': 'any_value', 'other_field': 'any_value'};
    final error = sut.validate(formData);
    expect(error, null);
  });
}
