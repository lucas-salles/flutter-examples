import 'package:equatable/equatable.dart';

import '../../presentation/protocols/protocols.dart';

import '../protocols/protocols.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  const RequiredFieldValidation(this.field);

  @override
  List get props => [field];

  @override
  ValidationError? validate(Map input) {
    return input[field]?.isNotEmpty == true
        ? null
        : ValidationError.requiredField;
  }
}
