import 'package:flutter/material.dart';
import 'package:menu_modular/export.dart';


import '../../../../utils/enums/enums.dart';

class MenuButtons extends StatefulWidget {
  final ValueChanged<EnumMenuItem> onPressed;
  const MenuButtons({
    super.key,
    required this.onPressed,
  });

  @override
  State<MenuButtons> createState() => _MenuButtonsState();
}

class _MenuButtonsState extends State<MenuButtons> {
  @override
  Widget build(BuildContext context) {
    return MenuButtonsBody(
      data: MenuButtonsData(
        buttons: [
          MenuButtonsItemDataTile(
            itemHeight: 40,
            title: "Gerar SIMUC",
            icon: const Icon(Icons.add_box_outlined, size: 25),
            onTap: () {
              widget.onPressed(EnumMenuItem.createSimuc);
            },
          ),
          //  MenuButtonsItemDataTile(
          //   itemHeight: 40,
          //   title: "Gerar ROMANEIO",
          //   icon: const Icon(Icons.list, size: 25),
          //   onTap: () {
          //     widget.onPressed(EnumMenuItem.createRelatory);
          //   },
          // ),
        ],
      ),
    );
  }
}
