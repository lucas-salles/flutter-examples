import '../../../../presentation/protocols/protocols.dart';
import '../../../../validation/protocols/protocols.dart';
import '../../../../validation/validators/validators.dart';

Validation makeLoginValidation() {
  return ValidationComposite(makeLoginValidations());
}

List<FieldValidation> makeLoginValidations() {
  return const [
    RequiredFieldValidation('email'),
    EmailValidation('email'),
    RequiredFieldValidation('password'),
  ];
}
