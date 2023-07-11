import 'package:flutter_test/flutter_test.dart';

import 'package:for_dev/presentation/protocols/protocols.dart';
import 'package:for_dev/validation/validators/validators.dart';

void main() {
  late EmailValidation sut;

  setUp(() {
    sut = const EmailValidation('any_field');
  });

  test('Should return null on invalid case', () {
    expect(sut.validate({}), null);
  });

  test('Should return null if email is empty', () {
    final error = sut.validate({'any_field': ''});

    expect(error, null);
  });

  test('Should return null if email is null', () {
    final error = sut.validate({'any_field': null});

    expect(error, null);
  });

  test('Should return null if email is valid', () {
    final error = sut.validate({'any_field': 'any.name@example.com'});

    expect(error, null);
  });

  test('Should return error if email is invalid', () {
    final error = sut.validate({'any_field': 'any.name'});

    expect(error, ValidationError.invalidField);
  });
}
