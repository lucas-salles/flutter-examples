import 'package:equatable/equatable.dart';

import '../protocols/protocols.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  final String field;

  const RequiredFieldValidation(this.field);

  @override
  List get props => [field];

  @override
  String? validate(String? value) {
    return value?.isNotEmpty == true ? null : 'Campo obrigatório';
  }
}
