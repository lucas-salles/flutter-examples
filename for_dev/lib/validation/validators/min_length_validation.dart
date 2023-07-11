import '../../presentation/protocols/protocols.dart';

import '../protocols/protocols.dart';

class MinLengthValidation implements FieldValidation {
  @override
  final String field;
  final int size;

  MinLengthValidation({required this.field, required this.size});

  @override
  ValidationError? validate(String? value) {
    return value != null && value.length >= size
        ? null
        : ValidationError.invalidField;
  }
}
