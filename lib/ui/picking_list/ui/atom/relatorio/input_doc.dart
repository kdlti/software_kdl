import 'package:flutter/material.dart';

import '../../input_controllers.dart';

class InputDoc extends StatefulWidget {
  const InputDoc({Key? key}) : super(key: key);

  @override
  State<InputDoc> createState() => _InputDocState();
}

class _InputDocState extends State<InputDoc> {
  bool enabled = true;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: inputDoc,
            enabled: enabled,
            decoration: const InputDecoration(
              labelText: 'Inserir Documento',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: enabled
              ? const Icon(Icons.lock_open)
              : const Icon(Icons.lock_outline),
          onPressed: () {
            setState(() {
              enabled = !enabled;
            });
          },
        ),
      ],
    );
  }
}
