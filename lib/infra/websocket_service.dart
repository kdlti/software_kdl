import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;

  WebSocketChannel? _channel;
  String? _currentUrl;
  bool _isConnected = false;
  bool _isReconnecting = false;
  Timer? _reconnectTimer;
  Timer? _pingTimer;
  int _reconnectAttempts = 0;
  static const int maxReconnectAttempts = 5;
  static const int reconnectDelay = 3000;
  static const int pingInterval = 30000;
 
  final Map<String, StreamController<dynamic>> _controllers = {};
  final StreamController<bool> _connectionStatusController = StreamController<bool>.broadcast();

  WebSocketService._internal();

  dynamic selected = "";
  
  bool get isConnected => _isConnected;
  Stream<bool> get connectionStatus => _connectionStatusController.stream;

  Future<void> connect(String url) async {
    if (_isConnected) {
      print('WebSocket já está conectado');
      return;
    }

    if (_isReconnecting) {
      print('Tentativa de reconexão em andamento');
      return;
    }

    // Garantir que qualquer conexão prévia seja fechada corretamente
    _channel?.sink.close();
    
    _isReconnecting = false;
    _currentUrl = url;
    
    try {
      print('Iniciando conexão WebSocket para: $url');
      String wsurl = dotenv.env['WS_URL'] ?? 'URL padrão';
      final fullUrl = "$wsurl$url";
      print('URL completa: $fullUrl');
      
      _channel = HtmlWebSocketChannel.connect(
        Uri.parse(fullUrl),
      );
      
      // Adicionar um pequeno delay para garantir que a conexão seja estabelecida
      await Future.delayed(Duration(milliseconds: 500));
      
      _channel!.stream.listen(
        (message) {
          try {
            final decodedMessage = jsonDecode(message);
            print("decodedMessage: $decodedMessage");
            final tipo = decodedMessage['tipo'];
            if (tipo == 'pong') {
              // Resposta ao ping, resetar o timer de reconexão
              _resetPingTimer();
            } else if (_controllers.containsKey(tipo)) {
              _controllers[tipo]!.add(decodedMessage);
            }
          } catch (e) {
            print('Erro ao processar mensagem: $e');
          }
        },
        onError: (error) {
          print('WebSocket error: $error');
          _handleConnectionError();
        },
        onDone: () {
          print('WebSocket connection closed');
          _isConnected = false;
          _connectionStatusController.add(false);
          _handleConnectionError();
        },
      );
      
      _isConnected = true;
      _reconnectAttempts = 0;
      _connectionStatusController.add(true);
      _startPingTimer();
      print('Conexão WebSocket estabelecida com sucesso');
      
    } catch (e) {
      print('Erro ao conectar WebSocket: $e');
      _isConnected = false;
      _connectionStatusController.add(false);
      _handleConnectionError();
    }
  }

  void _handleConnectionError() {
    _isConnected = false;
    _connectionStatusController.add(false);
    
    if (!_isReconnecting && _currentUrl != null) {
      _attemptReconnect();
    }
  }

  void _attemptReconnect() {
    if (_isReconnecting || _reconnectAttempts >= maxReconnectAttempts) {
      if (_reconnectAttempts >= maxReconnectAttempts) {
        print('Número máximo de tentativas de reconexão atingido');
        _reconnectAttempts = 0;
        // Notificar o usuário que a conexão falhou permanentemente
      }
      return;
    }

    _isReconnecting = true;
    _reconnectTimer?.cancel();
    
    _reconnectTimer = Timer(Duration(milliseconds: reconnectDelay), () async {
      _reconnectAttempts++;
      print('Tentativa de reconexão $_reconnectAttempts de $maxReconnectAttempts');
      
      try {
        await connect(_currentUrl!);
        _isReconnecting = false;
      } catch (e) {
        _isReconnecting = false;
        print('Falha na tentativa de reconexão: $e');
        if (_reconnectAttempts < maxReconnectAttempts) {
          _attemptReconnect();
        }
      }
    });
  }

  void _startPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(Duration(milliseconds: pingInterval), (timer) {
      if (_isConnected && _channel != null) {
        try {
          sendMessage('ping', {});
        } catch (e) {
          print('Erro ao enviar ping: $e');
          _handleConnectionError();
        }
      } else {
        timer.cancel();
      }
    });
  }

  void _resetPingTimer() {
    _startPingTimer();
  }

  Stream<dynamic> getChannelStream(String channel) {
    if (!_controllers.containsKey(channel)) {
      _controllers[channel] = StreamController<dynamic>.broadcast();
    }
    return _controllers[channel]!.stream;
  }

  void sendMessage(String tipo, dynamic dados) {
    if (!_isConnected || _channel == null) {
      print('WebSocket não está conectado. Tentando reconectar...');
      _handleConnectionError();
      return;
    }
    
    try {
      final message = jsonEncode({"tipo": tipo, "dados": dados});
      _channel!.sink.add(message);
    } catch (e) {
      print('Erro ao enviar mensagem: $e');
      _handleConnectionError();
    }
  }

  void sendMessagePickingList(String tipo, dynamic dados, String? bytes) {
    if (!_isConnected || _channel == null) {
      print('WebSocket não está conectado. Tentando reconectar...');
      _handleConnectionError();
      return;
    }
    
    try {
      print('Preparando envio de mensagem picking list do tipo: $tipo');
      // Adicionar um log do tamanho dos dados
      print('Tamanho dos dados: ${dados.length} registros');
      
      final message = jsonEncode({"tipo": tipo, "dados": dados, "picking_list": bytes});
      
      // Verificar se o tamanho da mensagem não é muito grande
      print('Enviando mensagem...');
      _channel!.sink.add(message);
      print('Mensagem enviada com sucesso');
    } catch (e) {
      print('Erro ao enviar mensagem picking list: $e');
      if (e.toString().contains('closed')) {
        print('Conexão websocket fechada durante o envio. Tentando reconexão...');
      }
      _handleConnectionError();
    }
  }

  void selecionarLinha(String tipo, dynamic dados) {
    if (!_isConnected || _channel == null) {
      print('WebSocket não está conectado. Tentando reconectar...');
      _handleConnectionError();
      return;
    }
    
    try {
      final message = jsonEncode({
        "tipo": tipo,
        "dados": {"linha_id": dados}
      });
      _channel!.sink.add(message);
    } catch (e) {
      print('Erro ao selecionar linha: $e');
      _handleConnectionError();
    }
  }

  void sendItemEdit(String tipo, dynamic dados) {
    if (!_isConnected || _channel == null) {
      print('WebSocket não está conectado. Tentando reconectar...');
      _handleConnectionError();
      return;
    }
    print("tipo: $tipo, dados: $dados");
    try {
      final message = jsonEncode({
        "tipo": tipo,
        "dados": dados
      });
      _channel!.sink.add(message);
    } catch (e) {
      print('Erro ao enviar item edit: $e');
      _handleConnectionError();
    }
  }

  void sendItemToEdit(dynamic dados) {
    selected = dados;
  }

  void disconnect() {
    print('Desconectando WebSocket...');
    _pingTimer?.cancel();
    _reconnectTimer?.cancel();
    
    // Garantir que o canal está limpo antes de fechar
    if (_channel != null) {
      try {
        _channel!.sink.close();
        print('Canal WebSocket fechado com sucesso');
      } catch (e) {
        print('Erro ao fechar canal WebSocket: $e');
      }
    }
    
    // Resetar o estado
    _channel = null;
    _isConnected = false;
    _isReconnecting = false;
    _reconnectAttempts = 0;
    
    // Notificar sobre a desconexão em vez de fechar os controllers
    // Isso evita problemas com streams que ainda estão sendo usadas
    _connectionStatusController.add(false);
    print('WebSocket desconectado');
  }

  void dispose() {
    disconnect();
    _connectionStatusController.close();
  }
}
