import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../page_presenter.dart';

class DropdownRomaneio extends StatefulWidget {
  const DropdownRomaneio({super.key});

  @override
  State<DropdownRomaneio> createState() => _DropdownRomaneioState();
}

class _DropdownRomaneioState extends State<DropdownRomaneio> {
  String selectedValue = 'normal';

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<PagePresenter>(context);
    
    return LayoutBuilder(
      builder: (context, constraints) {
        return DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Tipo de Romaneio',
            border: OutlineInputBorder(),
          ),
          value: selectedValue,
          items: const [
            DropdownMenuItem(
              value: 'normal',
              child: Text('Romaneio normal'),
            ),
            DropdownMenuItem(
              value: 'sem_recuperacao',
              child: Text('Romaneio sem recuperação'),
            ),
          ],
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedValue = newValue;
              });
              presenter.setTipoRomaneio(newValue);
            }
          },
        );
      },
    );
  }
} 