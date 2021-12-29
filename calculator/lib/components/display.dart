import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  final String text;

  const Display(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: const Color.fromRGBO(48, 48, 48, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: AutoSizeText(
                text,
                minFontSize: 20,
                maxFontSize: 80,
                maxLines: 1,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontWeight: FontWeight.w100,
                  decoration: TextDecoration.none,
                  fontSize: 80,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
