import 'package:get/get.dart';

import '../../ui/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../protocols/protocols.dart';

class GetxSignUpPresenter extends GetxController {
  final Validation validation;
  final AddAccount addAccount;

  final _emailError = Rxn<UIError>();
  final _nameError = Rxn<UIError>();
  final _passwordError = Rxn<UIError>();
  final _passwordConfirmationError = Rxn<UIError>();
  final _isFormValid = false.obs;

  String? _name;
  String? _email;
  String? _password;
  String? _passwordConfirmation;

  GetxSignUpPresenter({required this.validation, required this.addAccount});

  Stream<UIError?>? get emailErrorStream => _emailError.stream;
  Stream<UIError?>? get nameErrorStream => _nameError.stream;
  Stream<UIError?>? get passwordErrorStream => _passwordError.stream;
  Stream<UIError?>? get passwordConfirmationErrorStream =>
      _passwordConfirmationError.stream;
  Stream<bool>? get isValidFormStream => _isFormValid.stream;

  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }

  void validateName(String name) {
    _name = name;
    _nameError.value = _validateField(field: 'name', value: name);
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField(field: 'password', value: password);
    _validateForm();
  }

  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value = _validateField(
        field: 'passwordConfirmation', value: passwordConfirmation);
    _validateForm();
  }

  UIError? _validateField({required String field, required String value}) {
    final error = validation.validate(field: field, value: value);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      default:
        return null;
    }
  }

  void _validateForm() {
    _isFormValid.value = _emailError.value == null &&
        _nameError.value == null &&
        _passwordError.value == null &&
        _passwordConfirmationError.value == null &&
        _email != null &&
        _name != null &&
        _password != null &&
        _passwordConfirmation != null;
  }

  Future<void> signUp() async {
    await addAccount.add(AddAccountParams(
      name: _name!,
      email: _email!,
      password: _password!,
      passwordConfirmation: _passwordConfirmation!,
    ));
  }
}