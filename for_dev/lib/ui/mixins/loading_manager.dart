import 'package:flutter/material.dart';

import '../components/components.dart';

mixin LoadingManager {
  void handleLoading(BuildContext context, Stream<bool> stream) {
    stream.listen((isLoading) async {
      if (isLoading) {
        await showLoading(context);
      } else {
        hideLoading(context);
      }
    });
  }
}
