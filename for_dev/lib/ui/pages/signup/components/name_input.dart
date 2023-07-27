import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/helpers.dart';
import '../signup_presenter.dart';

class NameInput extends StatelessWidget {
  const NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);

    return StreamBuilder<UIError?>(
      stream: presenter.nameErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: R.strings.name,
            icon: const Icon(Icons.person),
            errorText: snapshot.data?.description,
          ),
          keyboardType: TextInputType.name,
          onChanged: presenter.validateName,
        );
      },
    );
  }
}
