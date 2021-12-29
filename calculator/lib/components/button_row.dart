import 'package:calculator/components/button.dart';
import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  final List<Button> buttons;

  const ButtonRow(this.buttons, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.fold([], (list, button) {
          list.isEmpty
              ? list.add(button)
              : list.addAll([
                  const SizedBox(width: 1),
                  button,
                ]);
          return list;
        }),
      ),
    );
  }
}
