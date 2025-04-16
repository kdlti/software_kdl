import 'dart:async';
import '../infra/infra.dart';

class AppState {
  static final AppState _instance = AppState._internal();

  factory AppState() => _instance;

  final WebSocketService webSocketService = WebSocketService();

  bool isWebSocketConnected = false;

  final _stateController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get stateChanges => _stateController.stream;

  AppState._internal() {
    webSocketService.connectionStatus.listen((isConnected) {
      isWebSocketConnected = isConnected;
      _notifyStateChange('websocket_connection', isConnected);
    });
  }

  Future<bool> initializeWebSocket(String url) async {
    try {
      await webSocketService.connect(url);
      isWebSocketConnected = webSocketService.isConnected;
      return isWebSocketConnected;
    } catch (e) {
      print('Erro ao inicializar WebSocket: $e');
      isWebSocketConnected = false;
      return false;
    }
  }

  Future<bool> reconnectWebSocket(String url) async {
    if (webSocketService.isConnected) return true;

    try {
      await webSocketService.connect(url);
      isWebSocketConnected = webSocketService.isConnected;
      return isWebSocketConnected;
    } catch (e) {
      print('Erro ao reconectar WebSocket: $e');
      isWebSocketConnected = false;
      return false;
    }
  }

  void _notifyStateChange(String key, dynamic value) {
    _stateController.add({key: value});
  }

  void dispose() {
    _stateController.close();
  }
}
