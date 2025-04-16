import 'package:flutter/material.dart';
import '../../../utils/global_keys.dart';

// Store the current key for verified loading dialog
GlobalKey<State>? _currentVerifiedKey;

Future<void> showLoadingVerified(BuildContext context) async {
  // Create a new key each time
  _currentVerifiedKey = createLoadingVerifiedKey();
  await Future.delayed(Duration.zero);
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => SimpleDialog(
      elevation: 0,
      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      key: _currentVerifiedKey,
      children: const [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.done, size: 60, color: Colors.green),
            SizedBox(height: 10),
            Text("Criado!", style: TextStyle(fontSize: 20),)
          ],
          
        ),
      ],
    ),
  );
}

void hideLoadingError(BuildContext context) {
  if (_currentVerifiedKey?.currentContext != null) {
    Navigator.of(_currentVerifiedKey!.currentContext!).pop();
  }
}
