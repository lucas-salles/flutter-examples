import 'package:equatable/equatable.dart';

import '../../presentation/protocols/protocols.dart';

import '../protocols/protocols.dart';

class MinLengthValidation extends Equatable implements FieldValidation {
  @override
  final String field;
  final int size;

  const MinLengthValidation({required this.field, required this.size});

  @override
  List get props => [field, size];

  @override
  ValidationError? validate(Map input) {
    return input[field] != null && input[field].length >= size
        ? null
        : ValidationError.invalidField;
  }
}
