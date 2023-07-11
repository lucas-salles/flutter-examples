import 'dart:async';

import '../../ui/helpers/errors/errors.dart';
import '../../ui/pages/pages.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../protocols/protocols.dart';

class LoginState {
  String? email;
  String? password;
  UIError? emailError;
  UIError? passwordError;
  UIError? mainError;
  String? navigateTo;
  bool isLoading = false;

  bool get isValidForm =>
      emailError == null &&
      passwordError == null &&
      email != null &&
      password != null;
}

class StreamLoginPresenter implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  StreamController<LoginState>? _controller =
      StreamController<LoginState>.broadcast();

  final _state = LoginState();

  StreamLoginPresenter({
    required this.authentication,
    required this.validation,
    required this.saveCurrentAccount,
  });

  @override
  Stream<UIError?>? get emailErrorStream =>
      _controller?.stream.map((state) => state.emailError).distinct();
  @override
  Stream<UIError?>? get passwordErrorStream =>
      _controller?.stream.map((state) => state.passwordError).distinct();
  @override
  Stream<UIError?>? get mainErrorStream =>
      _controller?.stream.map((state) => state.mainError).distinct();
  @override
  Stream<String?>? get navigateToStream =>
      _controller?.stream.map((state) => state.navigateTo).distinct();
  @override
  Stream<bool>? get isValidFormStream =>
      _controller?.stream.map((state) => state.isValidForm).distinct();
  @override
  Stream<bool>? get isLoadingStream =>
      _controller?.stream.map((state) => state.isLoading).distinct();

  void _update() => _controller?.add(_state);

  @override
  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = _validateField('email');
    _update();
  }

  @override
  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError = _validateField('password');
    _update();
  }

  UIError? _validateField(String field) {
    final formData = {
      'email': _state.email,
      'password': _state.password,
    };
    final error = validation.validate(field: field, input: formData);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      default:
        return null;
    }
  }

  @override
  Future<void> auth() async {
    _state.isLoading = true;
    _update();
    try {
      final account = await authentication.auth(
          AuthenticationParams(email: _state.email!, secret: _state.password!));
      await saveCurrentAccount.save(account);
      _state.navigateTo = '/surveys';
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.invalidCredentials:
          _state.mainError = UIError.invalidCredentials;
          break;
        default:
          _state.mainError = UIError.unexpected;
      }
    }
    _state.isLoading = false;
    _update();
  }

  @override
  void goToSignUp() {
    _state.navigateTo = '/signup';
    _update();
  }

  @override
  void dispose() {
    _controller?.close();
    _controller = null;
  }
}
