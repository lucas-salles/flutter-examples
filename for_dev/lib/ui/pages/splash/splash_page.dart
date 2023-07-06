import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_presenter.dart';

class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;

  const SplashPage({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    presenter.checkAccount();

    return Scaffold(
      appBar: AppBar(title: const Text('4Dev')),
      body: Builder(
        builder: (context) {
          presenter.navigateToStream.listen((page) {
            if (page.isNotEmpty) {
              Get.offAllNamed(page);
            }
          });

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
