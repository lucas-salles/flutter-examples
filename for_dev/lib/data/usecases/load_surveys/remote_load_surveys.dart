import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadSurveys implements LoadSurveys {
  final String url;
  final HttpClient<List<Map>> httpClient;

  const RemoteLoadSurveys({
    required this.url,
    required this.httpClient,
  });

  @override
  Future<List<SurveyEntity>> load() async {
    try {
      final response = await httpClient.request(url: url, method: 'get');
      return response
          .map((json) => RemoteSurveyModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
