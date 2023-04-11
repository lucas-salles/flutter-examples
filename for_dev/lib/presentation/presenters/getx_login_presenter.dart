import 'package:get/get.dart';

import '../../ui/pages/pages.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../protocols/protocols.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;

  String? _email;
  String? _password;
  var _emailError = RxnString();
  var _passwordError = RxnString();
  var _mainError = RxnString();
  var _isFormValid = false.obs;
  var _isLoading = false.obs;

  GetxLoginPresenter({required this.authentication, required this.validation});

  @override
  Stream<String?>? get emailErrorStream => _emailError.stream;
  @override
  Stream<String?>? get passwordErrorStream => _passwordError.stream;
  @override
  Stream<String?>? get mainErrorStream => _mainError.stream;
  @override
  Stream<bool>? get isValidFormStream => _isFormValid.stream;
  @override
  Stream<bool>? get isLoadingStream => _isLoading.stream;

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = validation.validate(field: 'email', value: email);
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value =
        validation.validate(field: 'password', value: password);
    _validateForm();
  }

  void _validateForm() {
    _isFormValid.value = _emailError.value == null &&
        _passwordError.value == null &&
        _email != null &&
        _password != null;
  }

  @override
  Future<void> auth() async {
    _isLoading.value = true;
    try {
      await authentication
          .auth(AuthenticationParams(email: _email!, secret: _password!));
    } on DomainError catch (error) {
      _mainError.value = error.description;
    }
    _isLoading.value = false;
  }

  @override
  void dispose() {}
}