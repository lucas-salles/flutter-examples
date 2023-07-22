import 'package:get/get.dart';

mixin SessionManager {
  void handleSessionExpired(Stream<bool> stream) {
    stream.listen((isExpired) {
      if (isExpired) {
        Get.offAllNamed('/login');
      }
    });
  }
}
