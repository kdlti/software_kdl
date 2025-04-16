import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/costumer/load_costumers.dart';
import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadCostumers implements LoadCostumers {
  final String url;
  final HttpClient httpClient;

  RemoteLoadCostumers({
    required this.url,
    required this.httpClient,
  });

  @override
  Future<List<CostumersEntity>> loadCostumers() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: 'get');
      return httpResponse.map<CostumersEntity>((json) {
        final costumersEntity = RemoteCostumerModel.fromJson(json).toEntity();
        print(costumersEntity);
        return costumersEntity;
      }).toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}