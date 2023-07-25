import '../../http/http.dart';

class RemoteSaveSurveyResult {
  final String url;
  final HttpClient httpClient;

  const RemoteSaveSurveyResult({
    required this.url,
    required this.httpClient,
  });

  Future<void> save({required String answer}) async {
    await httpClient.request(url: url, method: 'put', body: {'answer': answer});
  }
}
