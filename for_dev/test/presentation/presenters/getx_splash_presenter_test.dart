import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/domain/usecases/usecases.dart';

import 'package:for_dev/ui/pages/pages.dart';

// Annotation which generates the getx_splash_presenter_test.mocks.dart library and the MockLoadCurrentAccount class.
@GenerateNiceMocks([MockSpec<LoadCurrentAccount>()])
import './getx_splash_presenter_test.mocks.dart';

class GetxSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;

  final _navigateTo = RxString('');

  GetxSplashPresenter({required this.loadCurrentAccount});

  @override
  Stream<String> get navigateToStream => _navigateTo.stream;

  @override
  Future<void> checkAccount() async {
    await loadCurrentAccount.load();
  }
}

void main() {
  test('Should call loadCurrentAccount', () async {
    final loadCurrentAccount = MockLoadCurrentAccount();
    final sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);

    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });
}
