import 'package:flutter/material.dart';
import 'package:menu_modular/export.dart';
import 'package:provider/provider.dart';

import '../../../../../../../presentation/presenters.dart';
import '../../../../../../../utils/tables/tables.dart';
import 'widget_subtitle.dart';

class SubtitlesAtom extends StatelessWidget {
  const SubtitlesAtom({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxTableSimucPresenter>(context);
    return Row(
      children: [
        WidgetSubtitle(
          boxShadowColor: const Color.fromARGB(150, 255, 78, 65),
          color: const Color.fromARGB(100, 247, 72, 59),
          labelQuantity: controller.status0.length.toString(),
          label: "Em Manutenção",
        ),
        Spacing.horizontalSpaceX,
        WidgetSubtitle(
          boxShadowColor: const Color.fromARGB(150, 131, 42, 146),
          color: const Color.fromARGB(100, 156, 40, 177),
          labelQuantity: controller.status2.length.toString(),
          label: "Aguardando Diagnóstico",
        ),
        Spacing.horizontalSpaceX,
        WidgetSubtitle(
          boxShadowColor: const Color.fromARGB(150, 59, 255, 66),
          color: const Color.fromARGB(100, 59, 255, 66),
          labelQuantity: controller.status1.length.toString(),
          label: "Concluída",
        ),
        Spacing.horizontalSpaceX,
        WidgetSubtitle(
          boxShadowColor: const Color.fromARGB(150, 133, 175, 231),
          color: const Color.fromARGB(120, 59, 193, 255),
          labelQuantity: controller.status4.length.toString(),
          label: "Rom. Gerado/Enviado",
        ),
      ],
    );
  }
}
