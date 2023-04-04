import 'package:flutter_test/flutter_test.dart';

import 'package:for_dev/validation/validators/validators.dart';

void main() {
  late EmailValidation sut;

  setUp(() {
    sut = const EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    final error = sut.validate('');

    expect(error, null);
  });

  test('Should return null if email is null', () {
    final error = sut.validate(null);

    expect(error, null);
  });

  test('Should return null if email is valid', () {
    final error = sut.validate('any.name@example.com');

    expect(error, null);
  });

  test('Should return error if email is invalid', () {
    final error = sut.validate('any.name');

    expect(error, 'Campo inválido');
  });
}
