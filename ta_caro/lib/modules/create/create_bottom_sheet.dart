import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:ta_caro/modules/create/create_controller.dart';
import 'package:ta_caro/modules/create/repositories/create_repository_impl.dart';
import 'package:ta_caro/shared/services/app_database.dart';
import 'package:ta_caro/shared/widgets/button/button.dart';
import 'package:ta_caro/shared/widgets/input_text/input_text.dart';

class CreateBottomSheet extends StatefulWidget {
  const CreateBottomSheet({Key? key}) : super(key: key);

  @override
  State<CreateBottomSheet> createState() => _CreateBottomSheetState();
}

class _CreateBottomSheetState extends State<CreateBottomSheet> {
  late final CreateController controller;

  @override
  void initState() {
    super.initState();
    controller = CreateController(
      repository: CreateRepositoryImpl(
        database: AppDatabase.instance,
      ),
    );
    controller.addListener(() {
      controller.state.when(
        success: (_) {
          Navigator.of(context).pop();
        },
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
    return Padding(
      padding: EdgeInsets.only(
        left: 42,
        right: 42,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 32),
            InputText(
              label: "Produto",
              hint: "Digite um nome",
              onChanged: (value) => controller.onChanged(name: value),
              validator: (value) =>
                  value.isNotEmpty ? null : "Favor digitar o nome",
            ),
            const SizedBox(height: 8),
            InputText(
              label: "Preço",
              hint: "Digite o valor",
              onChanged: (value) => controller.onChanged(price: value),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value.isNotEmpty ? null : "Favor digitar um valor",
              inputFormatters: [
                MoneyInputFormatter(leadingSymbol: "R\$"),
              ],
            ),
            const SizedBox(height: 8),
            InputText(
              label: "Data da compra",
              hint: "Digite dd/mm/aaaa",
              onChanged: (value) => controller.onChanged(date: value),
              keyboardType: TextInputType.datetime,
              validator: (value) =>
                  value.isNotEmpty ? null : "Favor digitar uma data",
              inputFormatters: [
                MaskedInputFormatter('00/00/0000'),
              ],
            ),
            const SizedBox(height: 28),
            AnimatedBuilder(
              animation: controller,
              builder: (_, __) => controller.state.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (message, _) => Text(message),
                orElse: () => Button(
                  label: "Adicionar",
                  onTap: () {
                    controller.create();
                  },
                ),
              ),
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
