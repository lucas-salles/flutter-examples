import 'package:flutter/material.dart';

import '../../helpers/errors/ui_error.dart';

abstract class SignUpPresenter implements Listenable {
  Stream<UIError?> get nameErrorStream;
  Stream<UIError?> get emailErrorStream;
  Stream<UIError?> get passwordErrorStream;
  Stream<UIError?> get passwordConfirmationErrorStream;
  Stream<UIError?> get mainErrorStream;
  Stream<bool> get isValidFormStream;
  Stream<bool> get isLoadingStream;
  Stream<String?> get navigateToStream;

  void validateName(String name);
  void validateEmail(String email);
  void validatePassword(String password);
  void validatePasswordConfirmation(String passwordConfirmarion);
  Future<void> signUp();
  void goToLogin();
}
