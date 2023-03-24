import 'dart:convert';

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

  Future<void> request(
      {required Uri url, required String method, Map? body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    await client.post(
      url,
      headers: headers,
      body: jsonBody,
    );
  }
}

void main() {
  // sut = system under test
  late HttpAdapter sut;
  late MockClient client;
  late Uri url;

  setUp(() {
    client = MockClient();
    sut = HttpAdapter(client);
    final urlString = faker.internet.httpUrl();
    url = Uri.parse(urlString);
  });

  group('post', () {
    test('Should call post with correct values', () async {
      await sut.request(
        url: url,
        method: 'post',
        body: {'any_key': 'any_value'},
      );

      verify(client.post(
        url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
        body: '{"any_key":"any_value"}',
      ));
    });

    test('Should call post without body', () async {
      await sut.request(url: url, method: 'post');

      verify(client.post(any, headers: anyNamed('headers')));
    });
  });
}
