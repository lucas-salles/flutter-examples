import 'package:get/get.dart';

import '../../ui/helpers/helpers.dart';

mixin MainErrorManager {
  final _mainError = Rxn<UIError>();
  Stream<UIError?> get mainErrorStream => _mainError.stream;
  set mainError(UIError? value) => _mainError.value = value;
}
