import 'package:flutter/material.dart';

import '../../../../../../common/dialogs/export.dart';

class DeleteItem extends StatelessWidget {
  final List<String>? simuc;
  final String? id;
  final String? arId;
  final VoidCallback onPressed;

  const DeleteItem({
    Key? key,
    required this.onPressed,
    this.id,
    this.arId,
    this.simuc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return simuc?.isNotEmpty == true
        ? InkWell(
            child: const Tooltip(
              message: "Deletar SIMUC",
              child: Icon(
                Icons.delete_outline_outlined,
                size: 25,
                color: Colors.red,
              ),
            ),
            onTap: () async => showMaterialConfirmationDialog(
              context: context,
              title: "Deletar SIMUC",
              message:
                  "Tem certeza que deseja deletar o(os) SIMUC(s)?\n\n${simuc?.join('\n')}",
              icon: Icons.warning_amber_rounded,
              iconColor: Colors.red,
              confirmButtonColor: Colors.red,
              onConfirm: onPressed,
            ),
          )
        : InkWell(
            child: const Tooltip(
              message: "Deletar SIMUC",
              child: Icon(
                Icons.delete_outline_outlined,
                size: 25,
                color: Colors.grey,
              ),
            ),
            onTap: () {},
          );
    ;
  }
}
