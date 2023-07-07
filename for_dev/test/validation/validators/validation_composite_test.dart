import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/presentation/protocols/protocols.dart';

import 'package:for_dev/validation/protocols/protocols.dart';
import 'package:for_dev/validation/validators/validators.dart';

// Annotation which generates the validation_composite_test.mocks.dart library and the MockValidation and MockAuthentication class.
@GenerateNiceMocks([MockSpec<FieldValidation>()])
import './validation_composite_test.mocks.dart';

void main() {
  late ValidationComposite sut;
  late MockFieldValidation validation1;
  late MockFieldValidation validation2;
  late MockFieldValidation validation3;

  void mockValidation1(ValidationError? error) {
    when(validation1.validate(any)).thenReturn(error);
  }

  void mockValidation2(ValidationError? error) {
    when(validation2.validate(any)).thenReturn(error);
  }

  void mockValidation3(ValidationError? error) {
    when(validation3.validate(any)).thenReturn(error);
  }

  setUp(() {
    validation1 = MockFieldValidation();
    when(validation1.field).thenReturn('other_field');
    mockValidation1(null);
    validation2 = MockFieldValidation();
    when(validation2.field).thenReturn('any_field');
    mockValidation2(null);
    validation3 = MockFieldValidation();
    when(validation3.field).thenReturn('any_field');
    mockValidation3(null);
    sut = ValidationComposite([validation1, validation2, validation3]);
  });

  test('Should return null if all validations returns null or empty', () {
    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });

  test('Should return the first error', () {
    mockValidation1(ValidationError.requiredField);
    mockValidation2(ValidationError.requiredField);
    mockValidation3(ValidationError.invalidField);

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, ValidationError.requiredField);
  });
}
