import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/data/http/http.dart';

import 'package:for_dev/infra/http/http.dart';

// Annotation which generates the http_adapter_test.mocks.dart library and the MockClient class.
@GenerateNiceMocks([MockSpec<Client>()])
import './http_adapter_test.mocks.dart';

void main() {
  late HttpAdapter sut;
  late MockClient client;
  late String url;

  setUp(() {
    client = MockClient();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });

  group('shared', () {
    test('Should throw ServerError if invalid metho is provided', () async {
      final future = sut.request(url: url.toString(), method: 'invalid_method');

      expect(future, throwsA(HttpError.serverError));
    });
  });

  group('post', () {
    PostExpectation mockRequest() => when(client.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ));

    void mockResponse(int statusCode,
        {String body = '{"any_key":"any_value"}'}) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    void mockError() {
      mockRequest().thenThrow(Exception());
    }

    setUp(() {
      mockResponse(200);
    });

    test('Should call post with correct values', () async {
      await sut.request(
        url: url.toString(),
        method: 'post',
        body: {'any_key': 'any_value'},
      );

      verify(client.post(
        Uri.parse(url),
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

    test('Should return data if post returns 200', () async {
      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return empty map if post returns 200 with no data', () async {
      mockResponse(200, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, {});
    });

    test('Should return empty map if post returns 204', () async {
      mockResponse(204, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, {});
    });

    test('Should return empty map if post returns 204 with data', () async {
      mockResponse(204);

      final response = await sut.request(url: url, method: 'post');

      expect(response, {});
    });

    test('Should return BadRequestError if post with empty body returns 400',
        () async {
      mockResponse(400, body: '');

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return BadRequestError if post returns 400', () async {
      mockResponse(400);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return UnauthorizedError if post returns 401', () async {
      mockResponse(401);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.unauthorized));
    });

    test('Should return ForbiddenError if post returns 403', () async {
      mockResponse(403);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.forbidden));
    });

    test('Should return NotFoundError if post returns 404', () async {
      mockResponse(404);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.notFound));
    });

    test('Should return ServerError if post returns 500', () async {
      mockResponse(500);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.serverError));
    });

    test('Should return ServerError if post throws', () async {
      mockError();

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.serverError));
    });
  });

  group('get', () {
    PostExpectation mockRequest() => when(client.get(
          any,
          headers: anyNamed('headers'),
        ));

    void mockResponse(int statusCode,
        {String body = '{"any_key":"any_value"}'}) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    setUp(() {
      mockResponse(200);
    });

    test('Should call get with correct values', () async {
      await sut.request(
        url: url.toString(),
        method: 'get',
      );

      verify(client.get(
        Uri.parse(url),
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
      ));
    });

    test('Should return data if get returns 200', () async {
      final response = await sut.request(url: url, method: 'get');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return empty map if get returns 200 with no data', () async {
      mockResponse(200, body: '');

      final response = await sut.request(url: url, method: 'get');

      expect(response, {});
    });

    test('Should return empty map if get returns 204', () async {
      mockResponse(204, body: '');

      final response = await sut.request(url: url, method: 'get');

      expect(response, {});
    });

    test('Should return empty map if get returns 204 with data', () async {
      mockResponse(204);

      final response = await sut.request(url: url, method: 'get');

      expect(response, {});
    });

    test('Should return BadRequestError if get with empty body returns 400',
        () async {
      mockResponse(400, body: '');

      final future = sut.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return BadRequestError if get returns 400', () async {
      mockResponse(400);

      final future = sut.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('Should return UnauthorizedError if get returns 401', () async {
      mockResponse(401);

      final future = sut.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.unauthorized));
    });
  });
}
