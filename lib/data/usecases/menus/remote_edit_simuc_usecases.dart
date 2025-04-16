import '../../../../../../data/http/http.dart';
import '../../../../../../domain/entities/entities.dart';
import '../../../../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../../infra/infra.dart';
import '../../../main/factories/http/http.dart';
import '../../models/models.dart';

class RemoteRecordEditSimuc implements RecordEditItem {
  final String url;
  final HttpClient httpClient;
  final WebSocketService webSocketService;

  RemoteRecordEditSimuc({
    required this.url,
    required this.httpClient,
    WebSocketService? webSocketService,
  }) : webSocketService = webSocketService ?? WebSocketService();

  @override
  Future<bool> recordEditItem(EditSimucEntity params) async {
    final body = RemoteEditSimucModel.fromDomain(params).toJson();
    try {
      // Verificar se o WebSocket está conectado
      if (!webSocketService.isConnected) {
        await webSocketService.connect(url);
        
        // Aguardar um curto período para garantir que a conexão seja estabelecida
        await Future.delayed(Duration(milliseconds: 500));
        
        // Se ainda não estiver conectado após a tentativa, lançar erro
        if (!webSocketService.isConnected) {
          throw HttpError.serverError;
        }
      }
      
      // Enviar a mensagem (método void)
      webSocketService.sendMessage("edit_item", body);
      
      // Retornar sucesso
      return true;
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    } catch (e) {
      // Capturar outros erros que possam ocorrer
      print('Erro ao editar item: $e');
      throw DomainError.unexpected;
    }
  }
}
