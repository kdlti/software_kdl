import '../../../../../../data/http/http.dart';
import '../../../../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../../infra/infra.dart';


class RemoteRecordAr implements RecordAr {
  final String url;
  final HttpClient httpClient;
  final WebSocketService webSocketService;

  RemoteRecordAr({
    required this.url,
    required this.httpClient,
    WebSocketService? webSocketService,
  }) : webSocketService = webSocketService ?? WebSocketService();

  @override
  Future<bool> recordAr(AddArParams params) async {
    
    final body = RemoteAddArParams.fromDomain(params).toJson();
    try {
      // Verificar se o WebSocket está conectado
      if (!webSocketService.isConnected) {
        await webSocketService.connect(url);
        
        // Aguardar um curto período para garantir que a conexão seja estabelecida
        await Future.delayed(const Duration(milliseconds: 500));
        
        // Se ainda não estiver conectado após a tentativa, lançar erro
        if (!webSocketService.isConnected) {
          throw HttpError.serverError;
        }
      }
      
      // Enviar a mensagem (método void)
      webSocketService.sendMessage("record_ar", body);
      
      // Retornar sucesso
      return true;
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    } catch (e) {
      // Capturar outros erros que possam ocorrer
      print('Erro ao enviar AR: $e');
      throw DomainError.unexpected;
    }
  }
}

class RemoteAddArParams {
  final String client;
  final String docType;
  final String docEntrace;
  final String position;
  final String quantityItens;
  final String dateOpen;
  final String user;

  RemoteAddArParams({
    required this.client,
    required this.docType,
    required this.docEntrace,
    required this.position,
    required this.quantityItens,
    required this.dateOpen,
    required this.user,
  });

  factory RemoteAddArParams.fromDomain(AddArParams params) => RemoteAddArParams(
        client: params.client,
        docType: params.docType,
        docEntrace: params.docEntrance,
        position: params.position,
        quantityItens: params.quantityItens,
        dateOpen: params.dateOpen,
        user: params.user,
      );

  Map toJson() => {
        'client': client,
        'doc_type': docType,
        'doc_entrance': docEntrace,
        'position': position,
        'quantity_itens': quantityItens,
        'date_open': dateOpen,
        'user': user,
      };
}
