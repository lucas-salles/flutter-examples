import 'package:flutter/material.dart';
import 'package:ta_caro/modules/login/login_controller.dart';
import 'package:ta_caro/modules/login/repositories/login_repository.dart';
import 'package:ta_caro/modules/login/repositories/login_repository_impl.dart';
import 'package:ta_caro/shared/services/app_database.dart';
import 'package:ta_caro/shared/theme/app_theme.dart';
import 'package:ta_caro/shared/widgets/button/button.dart';
import 'package:ta_caro/shared/widgets/input_text/input_text.dart';
import 'package:validators/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginController controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    controller = LoginController(
      repository: LoginRepositoryImpl(
        database: AppDatabase.instance,
      ),
    );

    controller.addListener(() {
      controller.state.when(
        success: (value) => Navigator.of(context)
            .pushReplacementNamed("/home", arguments: value),
        error: (message, _) => scaffoldKey.currentState!.showBottomSheet(
          (context) => BottomSheet(
            onClosing: () {},
            builder: (context) => Container(
              child: Text(message),
            ),
          ),
        ),
        orElse: () {},
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.colors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 200,
                ),
                InputText(
                  label: "E-mail",
                  hint: "Digite seu email",
                  validator: (value) =>
                      isEmail(value) ? null : "Digite um e-mail válido",
                  onChanged: (value) => controller.onChanged(email: value),
                ),
                const SizedBox(height: 18),
                InputText(
                  label: "Senha",
                  hint: "Digite sua senha",
                  obscure: true,
                  validator: (value) =>
                      value.length >= 6 ? null : "Digite uma senha válida",
                  onChanged: (value) => controller.onChanged(password: value),
                ),
                const SizedBox(height: 14),
                AnimatedBuilder(
                  animation: controller,
                  builder: (_, __) => controller.state.when(
                    loading: () => const CircularProgressIndicator(),
                    orElse: () => Column(
                      children: [
                        Button(
                          label: "Entrar",
                          onTap: () {
                            controller.login();
                          },
                        ),
                        const SizedBox(height: 50),
                        Button(
                          label: "Criar conta",
                          type: ButtonType.outline,
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed("/login/create-account");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
