abstract class LoginPresenter {
  Stream<String> get emailErrorStream;
  Stream<String> get passwordErrorStream;
  Stream<String> get mainErrorStream;
  Stream<bool> get isValidFormStream;
  Stream<bool> get isLoadingStream;

  void validateEmail(String email);
  void validatePassword(String password);
  void auth();
}
