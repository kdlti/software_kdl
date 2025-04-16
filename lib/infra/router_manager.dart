import 'package:flutter_dotenv/flutter_dotenv.dart';

class RouteManager {
  static final RouteManager _instance = RouteManager._internal();

  factory RouteManager() {
    return _instance;
  }

  RouteManager._internal();

  final String _baseUrl = dotenv.env['BASE_URL'] ?? 'URL padrão';

  String makeApiUrl(String path) {
    return '$_baseUrl$path';
  }
}
