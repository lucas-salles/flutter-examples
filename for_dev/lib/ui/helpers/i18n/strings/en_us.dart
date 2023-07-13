import 'translations.dart';

class EnUs implements Translations {
  @override
  String get msgEmailInUse => 'Email is already in use.';
  @override
  String get msgInvalidCredentials => 'Invalid credentials.';
  @override
  String get msgInvalidField => 'Invalid field.';
  @override
  String get msgRequiredField => 'Required field.';
  @override
  String get msgUnexpectedError => 'Something wrong happened. Try again soon.';

  @override
  String get addAccount => 'Add account';
  @override
  String get confirmPassword => 'Confirm password';
  @override
  String get email => 'Email';
  @override
  String get enter => 'Enter';
  @override
  String get login => 'Login';
  @override
  String get name => 'Name';
  @override
  String get password => 'Passsword';
  @override
  String get reload => 'Reload';
  @override
  String get surveys => 'Surveys';
  @override
  String get wait => 'Wait...';
}
