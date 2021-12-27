import 'dart:io';

enum AuthMode { Signup, Login }

class AuthFormData {
  String name = '';
  String email = '';
  String password = '';
  File? image;
  AuthMode _mode = AuthMode.Login;

  bool get isLogin => _mode == AuthMode.Login;

  bool get isSignup => _mode == AuthMode.Signup;

  void toggleAuthMode() {
    _mode = isLogin ? AuthMode.Signup : AuthMode.Login;
  }
}
