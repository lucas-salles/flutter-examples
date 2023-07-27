import 'package:flutter/material.dart';

import '../helpers/helpers.dart';

Future<void> showLoading(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 10),
              Text(
                R.strings.wait,
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      );
    },
    barrierDismissible: false,
  );
}

void hideLoading(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
}
