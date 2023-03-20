import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Annotation which generates the remote_authentication.test.mocks.dart library and the MockHttpClient class.
@GenerateNiceMocks([MockSpec<HttpClient>()])
import './remote_authentication_test.mocks.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth() async {
    await httpClient.request(url: url, method: 'post');
  }
}

abstract class HttpClient {
  Future<void> request({required String url, required String method});
}

void main() {
  test('Should call HttpClient with correct values', () async {
    final httpClient = MockHttpClient();
    final url = faker.internet.httpUrl();
    // sut = system under test
    final sut = RemoteAuthentication(httpClient: httpClient, url: url);

    await sut.auth();

    verify(httpClient.request(url: url, method: 'post'));
  });
}
