import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../components_presenter.dart';

class ComponentButton extends StatelessWidget {
  const ComponentButton({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<ComponentsPresenter>(context);
    return Obx(() {
      return SizedBox(
        width: 100,
        height: 40,
        child: ElevatedButton(
          style: presenter.rightTableData.isNotEmpty && !presenter.isLoading
              ? ButtonStyle(
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  backgroundColor: WidgetStateProperty.all(Colors.orange),
                )
              : null,
          onPressed: presenter.rightTableData.isNotEmpty && !presenter.isLoading
              ? () => presenter.saveComponents(context)
              : null,
          child: presenter.isLoading
              ? const SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : const Text("Salvar"),
        ),
      );
    });
  }
}
