import '../../../../domain/entities/entities.dart';
import '../../../../domain/helpers/helpers.dart';
import '../../../http/http.dart';
import '../../../../infra/infra.dart';
import '../../../models/models.dart';
import '../../../../infra/websocket_service.dart';
import '../../../../../../domain/usecases/usecases.dart';
import '../../../../../../data/models/table_models/models_remote_delete.dart';

class RemoteDeleteSimuc implements DeleteSimuc {
  final WebSocketService webSocketService;
  final String url;

  RemoteDeleteSimuc({
    WebSocketService? webSocketService,
    this.url = '',
  }) : webSocketService = webSocketService ?? WebSocketService();

  @override
  Future<bool> deleteSimuc(List<EntityId> params) async {
    try {
      if (!webSocketService.isConnected && url.isNotEmpty) {
        await webSocketService.connect(url);

        // Aguardar um curto período para garantir que a conexão seja estabelecida
        await Future.delayed(const Duration(milliseconds: 500));

        // Se ainda não estiver conectado após a tentativa, lançar erro
        if (!webSocketService.isConnected) {
          throw HttpError.serverError;
        }
      }
      final body = RemoteDeleteSimucModel.fromDomain(params).toJson();
      webSocketService.sendItemEdit("delete_simuc", body);
      return true;
    } catch (e) {
      print('Erro ao deletar SIMUC: $e');
      throw DomainError.unexpected;
    }
  }
}
