import '../../../../../../data/http/http.dart';
import '../../../../../../domain/entities/entities.dart';
import '../../../../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../models/models.dart';

class RemoteLoadArs implements LoadArMenu {
  final String url;
  final HttpClient httpClient;

  RemoteLoadArs({
    required this.url,
    required this.httpClient,
  });

  @override
  Future<List<ArEntityMenus>> loadAr() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: 'get');
      return httpResponse.map<ArEntityMenus>((json) {
        final arEntity = RemoteArModelMenu.fromJson(json).toEntity();
        return arEntity;
      }).toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
