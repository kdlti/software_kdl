import '../../../../domain/entities/entities.dart';
import '../../../../domain/usecases/usecases.dart';
import '../../../http/http.dart';
import '../../../../domain/helpers/domain_error.dart';

import '../../../models/table_models/models_remote_ar.dart';

class RemoteLoadAr implements LoadAr {
  final String url;
  final HttpClient httpClient;

  RemoteLoadAr({
    required this.url,
    required this.httpClient,
  });

  @override
  Future<List<ArEntityTable>> loadAr() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: 'get');
      
      if (httpResponse == null) {
        throw DomainError.unexpected;
      }
      
      if (httpResponse is! List) {
        throw DomainError.unexpected;
      }
      return httpResponse.map<ArEntityTable>((json) {
        try {
          final arEntity = RemoteArModel.fromJson(json).toEntity();
          return arEntity;
        } catch (error) {
          throw DomainError.unexpected;
        }
      }).toList();
    } on HttpError catch (error) {
      switch (error) {
        case HttpError.forbidden:
          throw DomainError.accessDenied;
        case HttpError.unauthorized:
          throw DomainError.accessDenied;
        case HttpError.notFound:
          throw DomainError.unexpected;
        case HttpError.badRequest:
          throw DomainError.unexpected;
        default:
          throw DomainError.unexpected;
      }
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}