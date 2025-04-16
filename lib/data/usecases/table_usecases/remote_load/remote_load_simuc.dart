import '../../../../domain/entities/entities.dart';
import '../../../../domain/helpers/helpers.dart';
import '../../../../domain/usecases/usecases.dart';
import '../../../http/http.dart';
import '../../../models/models.dart';

class RemoteLoadSimuc implements LoadSimuc {
  final String url;
  final HttpClient httpClient;

  RemoteLoadSimuc({required this.url, required this.httpClient});

  @override
  Future<List<SimucEntityTables>> loadSimuc(id) async {
    try {
      final httpResponse = await httpClient
          .request(url: url, method: 'post', body: {"ar_id": int.parse(id)});
      
      if (httpResponse == null) {
        throw DomainError.unexpected;
      }
      
      if (httpResponse is! List) {
        throw DomainError.unexpected;
      }
      
      return httpResponse.map<SimucEntityTables>((json) {
        try {
          final simucEntity = RemoteSimucModel.fromJson(json).toEntity();
          return simucEntity;
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
