import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

LoginPresenter makeStreamLoginPresenter() {
  return StreamLoginPresenter(
    authentication: makeRemoteAuthentication(),
    validation: makeLoginValidation(),
    saveCurrentAccount: makeLocalSaveCurrentAccount(),
  );
}

LoginPresenter makeGetxLoginPresenter() {
  return GetxLoginPresenter(
    authentication: makeRemoteAuthentication(),
    validation: makeLoginValidation(),
    saveCurrentAccount: makeLocalSaveCurrentAccount(),
  );
}
