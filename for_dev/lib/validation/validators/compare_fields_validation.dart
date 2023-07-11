import 'package:equatable/equatable.dart';

import '../../presentation/protocols/protocols.dart';

import '../protocols/protocols.dart';

class CompareFieldsValidation extends Equatable implements FieldValidation {
  @override
  final String field;
  final String fieldToCompare;

  const CompareFieldsValidation(
      {required this.field, required this.fieldToCompare});

  @override
  List get props => [field, fieldToCompare];

  @override
  ValidationError? validate(Map input) {
    return input[field] == input[fieldToCompare]
        ? null
        : ValidationError.invalidField;
  }
}
