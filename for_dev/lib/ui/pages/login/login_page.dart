import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter? presenter;

  const LoginPage({super.key, this.presenter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter?.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text(
                            'Aguarde...',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ],
                  );
                },
                barrierDismissible: false,
              );
            } else {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
            }
          });

          presenter?.mainErrorStream.listen((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red[900],
                content: Text(
                  error,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          });

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LoginHeader(),
                Text(
                  'Login'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Form(
                    child: Column(
                      children: [
                        StreamBuilder<String>(
                          stream: presenter?.emailErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                icon: const Icon(Icons.email),
                                errorText: snapshot.data?.isEmpty == true
                                    ? null
                                    : snapshot.data,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: presenter?.validateEmail,
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 32),
                          child: StreamBuilder<String>(
                            stream: presenter?.passwordErrorStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Senha',
                                  icon: const Icon(Icons.lock),
                                  errorText: snapshot.data?.isEmpty == true
                                      ? null
                                      : snapshot.data,
                                ),
                                obscureText: true,
                                onChanged: presenter?.validatePassword,
                              );
                            },
                          ),
                        ),
                        StreamBuilder<bool>(
                          stream: presenter?.isValidFormStream,
                          builder: (context, snapshot) {
                            return ElevatedButton(
                              onPressed: snapshot.data == true
                                  ? presenter?.auth
                                  : null,
                              child: Text(
                                'Entrar'.toUpperCase(),
                              ),
                            );
                          },
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.person),
                          label: const Text('Criar Conta'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
