import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../presentation/presenters.dart';


class ExportSheet extends StatelessWidget {
  const ExportSheet({super.key});

  @override
  Widget build(BuildContext context) {
  final presenter = Provider.of<GetxTableSimucPresenter>(context);
    return IconButton(
      tooltip: "Exportar Planilha",
      onPressed: () => presenter.generateAndDownloadExcel(),
      icon: const Icon(Icons.download),
    );
  }
}
