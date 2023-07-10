import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';

class PasswordConfirmationInput extends StatelessWidget {
  const PasswordConfirmationInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: R.strings.confirmPassword,
        icon: const Icon(Icons.lock),
      ),
      obscureText: true,
    );
  }
}
