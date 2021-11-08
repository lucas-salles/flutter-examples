import 'package:flutter/material.dart';

class FadeContainer extends StatelessWidget {
  final Animation<Color?> fadeAnimation;

  const FadeContainer({Key? key, required this.fadeAnimation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "fade",
      child: Container(
        decoration: BoxDecoration(
          color: fadeAnimation.value,
        ),
      ),
    );
  }
}
