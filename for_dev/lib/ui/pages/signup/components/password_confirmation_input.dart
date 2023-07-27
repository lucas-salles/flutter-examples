import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helpers.dart';
import '../signup_presenter.dart';

class PasswordConfirmationInput extends StatelessWidget {
  const PasswordConfirmationInput({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);

    return StreamBuilder<UIError?>(
      stream: presenter.passwordConfirmationErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: R.strings.confirmPassword,
            icon: const Icon(Icons.lock),
            errorText: snapshot.data?.description,
          ),
          obscureText: true,
          onChanged: presenter.validatePasswordConfirmation,
        );
      },
    );
  }
}
