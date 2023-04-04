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
  late ValidationComposite sut;
  late MockFieldValidation validation1;
  late MockFieldValidation validation2;
  late MockFieldValidation validation3;

  void mockValidation1(String? error) {
    when(validation1.validate(any)).thenReturn(error);
  }

  void mockValidation2(String? error) {
    when(validation2.validate(any)).thenReturn(error);
  }

  void mockValidation3(String? error) {
    when(validation3.validate(any)).thenReturn(error);
  }

  setUp(() {
    validation1 = MockFieldValidation();
    when(validation1.field).thenReturn('any_field');
    mockValidation1(null);
    validation2 = MockFieldValidation();
    when(validation2.field).thenReturn('any_field');
    mockValidation2(null);
    validation3 = MockFieldValidation();
    when(validation3.field).thenReturn('other_field');
    mockValidation3(null);
    sut = ValidationComposite([validation1, validation2, validation3]);
  });

  test('Should return null if all validations returns null or empty', () {
    mockValidation2('');

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });
}
