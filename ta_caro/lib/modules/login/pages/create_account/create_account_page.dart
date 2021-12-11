import 'package:flutter/material.dart';
import 'package:ta_caro/modules/login/pages/create_account/create_account_controller.dart';
import 'package:ta_caro/modules/login/repositories/login_repository_impl.dart';
import 'package:ta_caro/shared/services/app_database.dart';
import 'package:ta_caro/shared/theme/app_theme.dart';
import 'package:ta_caro/shared/widgets/button/button.dart';
import 'package:ta_caro/shared/widgets/input_text/input_text.dart';
import 'package:validators/validators.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  late final CreateAccountController controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    controller = CreateAccountController(
      repository: LoginRepositoryImpl(
        database: AppDatabase.instance,
      ),
    );

    controller.addListener(() {
      controller.state.when(
        success: (value) => Navigator.of(context).pop(),
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
      appBar: AppBar(
        backgroundColor: AppTheme.colors.background,
        leading: BackButton(
          color: AppTheme.colors.backButton,
        ),
        elevation: 0,
      ),
      backgroundColor: AppTheme.colors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Criando uma conta",
                  style: AppTheme.textStyles.title,
                ),
                const SizedBox(height: 10),
                Text(
                  "Matenha seus gastos em dia",
                  style: AppTheme.textStyles.subtitle,
                ),
                const SizedBox(height: 38),
                InputText(
                  label: "Nome",
                  hint: "Digite seu nome completo",
                  validator: (value) =>
                      value.isNotEmpty ? null : "Digite seu nome completo",
                  onChanged: (value) => controller.onChanged(name: value),
                ),
                const SizedBox(height: 18),
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
                    loading: () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    ),
                    orElse: () => Button(
                      label: "Criar conta",
                      onTap: () {
                        controller.create();
                      },
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
