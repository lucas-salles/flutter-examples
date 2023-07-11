import 'package:flutter_test/flutter_test.dart';

import 'package:for_dev/presentation/protocols/protocols.dart';
import 'package:for_dev/validation/validators/validators.dart';

void main() {
  late RequiredFieldValidation sut;

  setUp(() {
    sut = const RequiredFieldValidation('any_field');
  });

  test('Should return null if value is not empty', () {
    final error = sut.validate({'any_field': 'any_value'});

    expect(error, null);
  });

  test('Should return error if value is empty', () {
    final error = sut.validate({'any_field': ''});

    expect(error, ValidationError.requiredField);
  });

  test('Should return error if value is null', () {
    final error = sut.validate({'any_field': null});

    expect(error, ValidationError.requiredField);
  });
}
