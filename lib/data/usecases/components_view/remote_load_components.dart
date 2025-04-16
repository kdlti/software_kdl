import 'package:teste_git_hub/domain/usecases/usecases.dart';

import '../../../domain/entities/entities.dart';
import '../../http/http.dart';
import '../../../domain/helpers/helpers.dart';
import '../../models/models.dart';

class RemoteLoadComponents implements LoadComponentsComponentsView {
  final String id;
  final String url;
  final HttpClient httpClient;

  RemoteLoadComponents({
    required this.id,
    required this.url,
    required this.httpClient,
  });

  @override
  Future<List<ComponentsEntity>> loadComponents() async {
    try {
      final httpResponse =
          await httpClient.request(url: url, method: 'post', body: {"id": id});
      final components = httpResponse.map<ComponentsEntity>((json) {
        final componentsEntity =
            RemoteComponentsModel.fromJson(json).toEntity();
        return componentsEntity;
      }).toList();
      return components;
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
