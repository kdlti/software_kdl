import 'package:teste_git_hub/domain/usecases/usecases.dart';

import '../../../domain/entities/entities.dart';
import '../../http/http.dart';
import '../../../domain/helpers/helpers.dart';
import '../../models/models.dart';

class RemoteLoadDefectsData implements LoadDefectsView {
  final String id;
  final String url;
  final HttpClient httpClient;

  RemoteLoadDefectsData({
    required this.id,
    required this.url,
    required this.httpClient,
  });

  @override
  Future<List<DefectsEntity>> loadDefects() async {
    try {
      final httpResponse =
          await httpClient.request(url: url, method: 'post', body: {"id": id});
      final defects = httpResponse.map<DefectsEntity>((json) {
        final defectsEntity = RemoteDefectsModel.fromJson(json).toEntity();
        return defectsEntity;
      }).toList();
      return defects;
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
