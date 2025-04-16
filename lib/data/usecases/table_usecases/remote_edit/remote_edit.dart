import 'dart:convert';

// import 'package:websocket_service_package/export.dart';

import '../../../../domain/helpers/helpers.dart';
import '../../../../domain/usecases/usecases.dart';
import '../../../../infra/infra.dart';
import '../../../../main/factories/http/http.dart';
import '../../../http/http.dart';


class RemoteEditAr implements EditAr {
  final WebSocketService webSocketService;
  final String url;

  RemoteEditAr({
    WebSocketService? webSocketService,
    this.url = '',
  }) : webSocketService = webSocketService ?? WebSocketService();

  @override
  Future<void> editAr(item) async {
    try {
      // Verificar se o WebSocket está conectado
      if (!webSocketService.isConnected && url.isNotEmpty) {
        await webSocketService.connect(url);
        
        // Aguardar um curto período para garantir que a conexão seja estabelecida
        await Future.delayed(Duration(milliseconds: 500));
        
        // Se ainda não estiver conectado após a tentativa, lançar erro
        if (!webSocketService.isConnected) {
          throw HttpError.serverError;
        }
      }
      
      // Enviar a mensagem (método void)
      final String simucJson = jsonEncode({"ar":item.ar, "position":""});
      webSocketService.sendItemEdit("edit_ar", simucJson);
    } on HttpError catch (error) {
      throw error == HttpError.forbidden
          ? DomainError.accessDenied
          : DomainError.unexpected;
    } catch (e) {
      // Capturar outros erros que possam ocorrer
      print('Erro ao editar AR: $e');
      throw DomainError.unexpected;
    }
  }
}