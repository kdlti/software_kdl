import 'package:teste_git_hub/domain/usecases/usecases.dart';

import '../../http/http.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../models/models.dart';

class RemoteLoadComponents implements LoadComponentsInclude {
  final String url;
  final HttpClient httpClient;

  RemoteLoadComponents({
    required this.url,
    required this.httpClient,
  });

  @override
  Future<List<ComponentsEntityInclude>> loadComponents() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: 'get');
      return httpResponse.map<ComponentsEntityInclude>((json) {
        final componentsEntity =
            RemoteComponentsModelInclude.fromJson(json).toEntity();
        return componentsEntity;
      }).toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
