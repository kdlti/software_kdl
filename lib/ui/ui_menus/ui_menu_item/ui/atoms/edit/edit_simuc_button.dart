import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../forms/edit/edit.dart';

class EditSimucButton extends StatelessWidget {
  const EditSimucButton({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<CreateEditPresenter>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: ElevatedButton(
        onPressed: () => presenter.imprimir(),
        style: Theme.of(context).elevatedButtonTheme.style,
        child: Text('Editar'.toUpperCase()),
      ),
    );
  }
}
