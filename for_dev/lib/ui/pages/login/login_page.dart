import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import '../../helpers/helpers.dart';
import 'components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    void hideKeyboard() {
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream?.listen((isLoading) {
            if (isLoading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          presenter.mainErrorStream?.listen((error) {
            if (error != null) {
              showErrorMessage(context, error.description);
            }
          });

          presenter.navigateToStream?.listen((page) {
            if (page?.isNotEmpty == true) {
              Get.offAllNamed(page!);
            }
          });

          return GestureDetector(
            onTap: hideKeyboard,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LoginHeader(),
                  Text(
                    R.strings.login.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Provider(
                      create: (_) => presenter,
                      child: Form(
                        child: Column(
                          children: [
                            const EmailInput(),
                            const Padding(
                              padding: EdgeInsets.only(top: 8, bottom: 32),
                              child: PasswordInput(),
                            ),
                            const LoginButton(),
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.person),
                              label: Text(R.strings.addAccount),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
