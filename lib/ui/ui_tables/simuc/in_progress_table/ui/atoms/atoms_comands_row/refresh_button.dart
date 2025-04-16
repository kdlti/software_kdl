import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../presentation/presenters.dart';

class RefreshButton extends StatelessWidget {
  final String arId;
  const RefreshButton({super.key, required this.arId});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxTableSimucPresenter>(context);
    return IconButton(
      tooltip: "Atualizar",
      onPressed: () => controller.initializeData(arId, button: "Refresh"),
      icon: const Icon(Icons.refresh),
    );
  }
}
