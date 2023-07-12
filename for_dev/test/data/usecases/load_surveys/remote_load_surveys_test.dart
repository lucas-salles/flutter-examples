// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/data/http/http.dart';

// Annotation which generates the remote_load_surveys_test.mocks.dart library and the MockHttpClient class.
@GenerateNiceMocks([MockSpec<HttpClient>()])
import './remote_load_surveys_test.mocks.dart';

class RemoteLoadSurveys {
  final String url;
  final HttpClient httpClient;

  const RemoteLoadSurveys({
    required this.url,
    required this.httpClient,
  });

  Future<void> load() async {
    await httpClient.request(url: url, method: 'get');
  }
}

void main() {
  test('Should call HttpClient with correct values', () async {
    final url = faker.internet.httpUrl();
    final httpClient = MockHttpClient();
    final sut = RemoteLoadSurveys(url: url, httpClient: httpClient);

    await sut.load();

    verify(httpClient.request(url: url, method: 'get'));
  });
}
