import 'package:teste_git_hub/domain/usecases/table_usecases/load_usecases/load_pdf.dart';

import '../../../../domain/entities/entities.dart';
import '../../../../domain/helpers/helpers.dart';
import '../../../http/http.dart';
import '../../../models/models.dart';

class RemoteLoadPdf implements LoadPdf {
  final String url;
  final HttpClient httpClient;

  RemoteLoadPdf({
    required this.url,
    required this.httpClient,
  });

  @override
  Future<List<PdfEntity>> loadPdf(ar) async {
    try {
      final httpResponse = await httpClient
          .request(url: url, method: 'post', body: {"ar_id": ar});
      
      if (httpResponse == null) {
        throw DomainError.unexpected;
      }
      
      if (httpResponse is! List) {
        throw DomainError.unexpected;
      }
      
      return httpResponse.map<PdfEntity>((json) {
        try {
          final pdfsEntity = RemotePdfsModel.fromJson(json).toEntity();
          return pdfsEntity;
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
