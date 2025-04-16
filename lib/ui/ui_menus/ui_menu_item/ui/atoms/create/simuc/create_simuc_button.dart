import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../forms/create/create.dart';

class CreateSimucButton extends StatelessWidget {
  const CreateSimucButton({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<CreateSimucPresenter>(context);
    return StreamBuilder<bool?>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: ElevatedButton(
            onPressed: snapshot.data == true ? presenter.record : null,
            style: snapshot.data != true
                ? const ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 70, 70, 70)),
                    backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 214, 214, 214)),
                  )
                : Theme.of(context).elevatedButtonTheme.style,
            child: Text('Criar'.toUpperCase()),
          ),
        );
      }
    );
  }
}
