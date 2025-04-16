import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../presentation/presenters.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxArPresenter>(context);
    return IconButton(
      tooltip: "Atualizar",
      onPressed: () => controller.initializeData(),
      icon: const Icon(Icons.refresh),
    );
  }
}
