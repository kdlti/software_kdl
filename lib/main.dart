import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';
import 'core/app_state.dart';
import 'main/main_screens/main_router.dart';
import 'main/main_screens/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appState = AppState();
  
  try {
    const envFile = String.fromEnvironment('ENV_FILE', defaultValue: 'local.env');
    print('Carregando arquivo de ambiente: $envFile');
    await dotenv.load(fileName: "assets/$envFile").catchError((error) {
      print('Erro ao carregar arquivo de ambiente: $error');
    });
    
    await initializeDateFormatting('pt_BR', null).catchError((error) {
      print('Erro ao inicializar formatação de data: $error');
    });
    
    try {
      await appState.initializeWebSocket('ws');
      print('WebSocket inicializado com sucesso: ${appState.isWebSocketConnected ? 'Conectado' : 'Desconectado'}');
    } catch (e) {
      print('Erro ao conectar WebSocket: $e');
    }
  } catch (e) {
    print('Erro durante a inicialização da aplicação: $e');
    // Continua a execução mesmo com erros de inicialização
  }
  
  // Inicia a aplicação
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late Future<bool> _loadApp;
  final AppState _appState = AppState();

  @override
  void initState() {
    super.initState();
    _loadApp = _initializeApp();
  }
  
  Future<bool> _initializeApp() async {
    // Aguarda um tempo para a tela de splash e tenta reconectar se necessário
    await Future.delayed(const Duration(seconds: 3));
    
    // Se o WebSocket não estiver conectado, tenta reconectar uma vez mais
    if (!_appState.isWebSocketConnected) {
      try {
        print('Tentando reconectar WebSocket durante a inicialização...');
        await _appState.reconnectWebSocket('ws');
      } catch (e) {
        print('Falha ao reconectar WebSocket: $e');
        // Continua mesmo se falhar a reconexão
      }
    }
    
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: _loadApp,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SplashScreen();
          }
          if (snapshot.hasError) {
            print('Erro ao carregar aplicação: ${snapshot.error}');
          }
          
          return const MainApp();
        },
      ),
    );
  }
  
  @override
  void dispose() {
    // Não desconecta o WebSocket aqui, pois ele deve permanecer ativo durante toda a vida do app
    super.dispose();
  }
}


