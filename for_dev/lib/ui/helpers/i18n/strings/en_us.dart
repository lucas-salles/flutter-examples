import 'translations.dart';

class EnUs implements Translations {
  @override
  String get msgInvalidCredentials => 'Invalid credentials.';
  @override
  String get msgInvalidField => 'Invalid field.';
  @override
  String get msgRequiredField => 'Required field.';
  @override
  String get msgUnexpected => 'Something wrong happened. Try again soon.';

  @override
  String get addAccount => 'Add account';
  @override
  String get email => 'E-mail';
  @override
  String get enter => 'Enter';
  @override
  String get login => 'Login';
  @override
  String get password => 'Passsword';
}
