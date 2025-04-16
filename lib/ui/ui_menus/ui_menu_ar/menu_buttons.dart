import 'package:flutter/material.dart';
import 'package:menu_modular/export.dart';

import '../../../utils/utils.dart';

class MenuButtons extends StatelessWidget {
  final ValueChanged<EnumMenuAr> onPressed;
  const MenuButtons({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MenuButtonsBody(
      data: MenuButtonsData(
        buttons: [
          MenuButtonsItemDataTile(
            itemHeight: 40,
            title: "Gerar AR",
            icon: const Icon(Icons.add_box_outlined, size: 25),
            onTap: () {
              onPressed(EnumMenuAr.createAr);
            },
          ),
          // MenuFormItemDataTile(
          //   itemHeight: 40,
          //   title: "Editar AR",
          //   icon: const Icon(Icons.edit, size: 25),
          //   onTap: () {
          //     onPressed(EnumMenuAr.editAr);
          //   },
          // ),
          // MenuFormItemDataTile(
          //   itemHeight: 40,
          //   title: "Exportar Relatório",
          //   icon: const Icon(Icons.chair_alt, size: 25),
          //   onTap: () {},
          // ),
          // MenuFormItemDataTile(
          //   itemHeight: 40,
          //   title: "Excluir SIMUC",
          //   icon: const Icon(Icons.delete, size: 25),
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }
}
