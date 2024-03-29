import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/domain/entities/entities.dart';
import 'package:for_dev/domain/usecases/usecases.dart';
import 'package:for_dev/presentation/presenters/presenters.dart';

import '../../domain/mocks/mocks.dart';

// Annotation which generates the getx_splash_presenter_test.mocks.dart library and the MockLoadCurrentAccount class.
@GenerateNiceMocks([MockSpec<LoadCurrentAccount>()])
import './getx_splash_presenter_test.mocks.dart';

void main() {
  late GetxSplashPresenter sut;
  late MockLoadCurrentAccount loadCurrentAccount;

  PostExpectation mockLoadCurrentAccountCall() =>
      when(loadCurrentAccount.load());

  void mockLoadCurrentAccount({required AccountEntity account}) =>
      mockLoadCurrentAccountCall().thenAnswer((_) async => account);

  void mockLoadCurrentAccountError() =>
      mockLoadCurrentAccountCall().thenThrow(Exception());

  setUp(() {
    loadCurrentAccount = MockLoadCurrentAccount();
    sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);
    mockLoadCurrentAccount(account: EntityFactory.makeAccount());
  });

  test('Should call loadCurrentAccount', () async {
    await sut.checkAccount(durationInSeconds: 0);

    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should go to surveys page on success', () async {
    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, '/surveys')));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on error', () async {
    mockLoadCurrentAccountError();

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount(durationInSeconds: 0);
  });
}
