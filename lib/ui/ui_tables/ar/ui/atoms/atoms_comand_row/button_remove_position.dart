import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../presentation/presenters.dart';

class RemovePosition extends StatelessWidget {
  const RemovePosition({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxArPresenter>(context);
    return IconButton(
      tooltip: "Remover Posição",
      onPressed: controller.selecteds.length > 1 || controller.selecteds.isEmpty
          ? null
          : () => controller.printPosition(),
      icon: const Icon(Icons.delete),
    );
  }
}
