import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Annotation which generates the http_adapter_test.mocks.dart library and the MockClient class.
@GenerateNiceMocks([MockSpec<Client>()])
import './http_adapter_test.mocks.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request({required Uri url, required String method}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    await client.post(url, headers: headers);
  }
}

void main() {
  group('post', () {
    test('Should call post with correct values', () async {
      final client = MockClient();
      // sut = system under test
      final sut = HttpAdapter(client);
      final urlString = faker.internet.httpUrl();
      final url = Uri.parse(urlString);

      await sut.request(url: url, method: 'post');

      verify(client.post(
        url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
      ));
    });
  });
}
