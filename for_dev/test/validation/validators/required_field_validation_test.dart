import 'package:flutter_test/flutter_test.dart';

abstract class FieldValidation {
  String get field;
  String? validate(String? value);
}

class RequiredFieldValidation implements FieldValidation {
  final String field;

  const RequiredFieldValidation(this.field);

  @override
  String? validate(String? value) {
    return value?.isNotEmpty == true ? null : 'Campo obrigatório';
  }
}

void main() {
  late RequiredFieldValidation sut;

  setUp(() {
    sut = const RequiredFieldValidation('any_field');
  });

  test('Should return null if value is not empty', () {
    final error = sut.validate('any_value');

    expect(error, null);
  });

  test('Should return error if value is empty', () {
    final error = sut.validate('');

    expect(error, 'Campo obrigatório');
  });

  test('Should return error if value is null', () {
    final error = sut.validate(null);

    expect(error, 'Campo obrigatório');
  });
}