import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter? presenter;

  const LoginPage({super.key, this.presenter});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          widget.presenter?.isLoadingStream.listen((isLoading) {
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

          widget.presenter?.mainErrorStream.listen((error) {
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
                          stream: widget.presenter?.emailErrorStream,
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
                              onChanged: widget.presenter?.validateEmail,
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 32),
                          child: StreamBuilder<String>(
                            stream: widget.presenter?.passwordErrorStream,
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
                                onChanged: widget.presenter?.validatePassword,
                              );
                            },
                          ),
                        ),
                        StreamBuilder<bool>(
                          stream: widget.presenter?.isValidFormStream,
                          builder: (context, snapshot) {
                            return ElevatedButton(
                              onPressed: snapshot.data == true
                                  ? widget.presenter?.auth
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
