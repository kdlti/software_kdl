import 'package:teste_git_hub/data/models/models.dart';
import 'package:teste_git_hub/domain/entities/tables/entity_defects.dart';
import 'package:teste_git_hub/domain/entities/tables/entity_defects_record.dart';
import 'package:teste_git_hub/domain/helpers/domain_error.dart';
import 'package:teste_git_hub/domain/usecases/usecases.dart';
// import 'package:websocket_service_package/export.dart';
import '../../../../infra/infra.dart';
import '../../../../main/factories/http/http.dart';
import '../../../http/http.dart';

class RemoteLoadDefects implements LoadDefects {
  final String url;
  final HttpClient httpClient;
  final WebSocketService webSocketService;

  RemoteLoadDefects({
    required this.url,
    required this.httpClient,
    WebSocketService? webSocketService,
  }) : webSocketService = webSocketService ?? WebSocketService();

  @override
  Future<List<EntityDefects>> loadDefects() async {
    try {
      final httpResponse = await httpClient.request(url: url, method: 'get');
      return httpResponse.map<EntityDefects>((json) {
        final defectEntity = RemoteDefectModel.fromJson(json).toEntity();
        return defectEntity;
      }).toList();
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }

  @override
  Future<bool> recordDefects(DefectsRecordEntity params) async {
    try {
      // Verificar se o WebSocket está conectado
      if (!webSocketService.isConnected) {
        await webSocketService.connect('ws');
        
        // Aguardar um curto período para garantir que a conexão seja estabelecida
        await Future.delayed(Duration(milliseconds: 500));
        
        // Se ainda não estiver conectado após a tentativa, lançar erro
        if (!webSocketService.isConnected) {
          throw HttpError.serverError;
        }
      }
      
      // Enviar a mensagem (método void)
      final body = ModelsRemoteDefectsRecord.fromDomain(params).toJson();
      webSocketService.sendMessage("record_defects", body);
      
      // Retornar sucesso
      return true;
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    } catch (e) {
      // Capturar outros erros que possam ocorrer
      print('Erro ao registrar defeitos: $e');
      return false;
    }
  }
}
