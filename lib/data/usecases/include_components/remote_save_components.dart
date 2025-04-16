import '../../../domain/usecases/usecases.dart';
import '../../../infra/infra.dart';
import '../../http/http.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/entities/include_components/components_record.dart';
import '../../models/include_components/remote_components_save_model.dart';

class RemoteRecordSimuc implements ComponentsRecord {
  final String url;
  final HttpClient httpClient;
  final WebSocketService webSocketService;

  RemoteRecordSimuc({
    required this.url,
    required this.httpClient,
    WebSocketService? webSocketService,
  }) : webSocketService = webSocketService ?? WebSocketService();

  @override
  Future<bool> recordComponents(ComponentsRecordEntity params) async {
    final body = RemoteComponentsSaveModel.fromDomain(params).toJson();
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
      webSocketService.sendMessage("record_components", body);
      
      // Retornar sucesso
      return true;
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    } catch (e) {
      // Capturar outros erros que possam ocorrer
      print('Erro ao enviar componentes: $e');
      throw DomainError.unexpected;
    }
  }
}
