import 'package:flutter_test/flutter_test.dart';

import 'package:for_dev/presentation/protocols/protocols.dart';
import 'package:for_dev/validation/protocols/protocols.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Annotation which generates the validation_composite_test.mocks.dart library and the MockValidation and MockAuthentication class.
@GenerateNiceMocks([MockSpec<FieldValidation>()])
import './validation_composite_test.mocks.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  const ValidationComposite(this.validations);

  @override
  String? validate({required String field, required String value}) {
    return null;
  }
}

void main() {
  test('Should return null if all validations returns null or empty', () {
    final validation1 = MockFieldValidation();
    when(validation1.field).thenReturn('any_field');
    when(validation1.validate(any)).thenReturn(null);
    final validation2 = MockFieldValidation();
    when(validation2.field).thenReturn('any_field');
    when(validation2.validate(any)).thenReturn('');
    final sut = ValidationComposite([validation1, validation2]);

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });
}
