import '../../helpers/errors/ui_error.dart';

abstract class SignUpPresenter {
  Stream<UIError?>? get nameErrorStream;
  Stream<UIError?>? get emailErrorStream;
  Stream<UIError?>? get passwordErrorStream;
  Stream<UIError?>? get passwordConfirmationErrorStream;
  Stream<bool>? get isFormValidStream;

  void validateName(String name);
  void validateEmail(String email);
  void validatePassword(String password);
  void validatePasswordConfirmation(String passwordConfirmarion);
  Future<void> signUp();
}
