import 'package:flutter/material.dart';
import '../domain/entities/abstract_dialogs_messages.dart';
import 'global_keys.dart';

class DialogsNotifier extends ErrorNotifier {
  // Store the current loading key
  GlobalKey<State>? _currentLoadingKey;

  @override
  void showErrorMessage(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text('Erro: $errorMessage'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void showConfirmationMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Componentes salvos com sucesso!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Future<void> showLoading(BuildContext context) async {
    _currentLoadingKey = createLoadingKey(); // Create a new key each time
    await Future.delayed(Duration.zero);
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleDialog(
        elevation: 0,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        key: _currentLoadingKey,
        children: const <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      strokeWidth: 8,
                      backgroundColor: Colors.orange,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Aguarde",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.orange, fontSize: 25),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  @override
  void hideLoading(BuildContext context) {
    if (_currentLoadingKey?.currentContext != null) {
      Navigator.of(_currentLoadingKey!.currentContext!, rootNavigator: true).pop();
    } else {
      // Fallback to the provided context if the key context is not available
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
