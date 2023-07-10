import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: R.strings.password,
        icon: const Icon(Icons.lock),
      ),
      obscureText: true,
    );
  }
}
