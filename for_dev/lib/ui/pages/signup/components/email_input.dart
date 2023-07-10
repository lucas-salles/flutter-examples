import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: R.strings.email,
        icon: const Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
