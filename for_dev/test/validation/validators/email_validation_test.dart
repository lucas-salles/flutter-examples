import 'package:flutter_test/flutter_test.dart';

import 'package:for_dev/validation/protocols/protocols.dart';

class EmailValidation implements FieldValidation {
  final String field;

  const EmailValidation(this.field);

  @override
  String? validate(String? value) {
    return null;
  }
}

void main() {
  test('Should return null if email is empty', () {
    const sut = EmailValidation('any_field');

    final error = sut.validate('');

    expect(error, null);
  });
}
