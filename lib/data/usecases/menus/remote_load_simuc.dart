import 'package:teste_git_hub/data/models/models.dart';

import '../../../../../../data/http/http.dart';
import '../../../../../../domain/entities/entities.dart';
import '../../../../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

class RemoteLoadSimucMenu implements LoadSimucMenu {
  final String? id;
  final String url;
  final HttpClient httpClient;

  RemoteLoadSimucMenu({
    required this.id,
    required this.url,
    required this.httpClient,
  });

  @override
  Future<List<SimucEntityMenus>> loadSimuc() async {
    try {
      final httpResponse = await httpClient
          .request(url: url, method: 'post', body: {"ar_id": int.parse(id!)});
      return httpResponse.map<SimucEntityMenus>((json) {
        final simucEntity = RemoteSimucModelMenu.fromJson(json).toEntity();
        print(simucEntity);
        return simucEntity;
      }).toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
