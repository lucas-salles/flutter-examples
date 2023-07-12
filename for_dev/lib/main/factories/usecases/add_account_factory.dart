import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';
import '../../../data/http/http.dart';

AddAccount makeRemoteAddAccount() {
  return RemoteAddAccount(
      httpClient: makeHttpAdapter() as HttpClient<Map>,
      url: makeApiUrl('signup'));
}
