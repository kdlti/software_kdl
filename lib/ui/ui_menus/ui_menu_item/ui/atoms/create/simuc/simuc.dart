import 'package:flutter/material.dart';
import 'package:menu_modular/export.dart';
import '../../../../../../../utils/menus/utils.dart';
import 'create_simuc_button.dart';
import 'create_simuc_cam.dart';
import 'create_simuc_insp_entrance.dart';
import 'create_simuc_number_serie.dart';
import 'create_simuc_related_defect.dart';
import 'create_simuc_user.dart';

class CreateSimucSubForm extends StatelessWidget {
  const CreateSimucSubForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Spacing.verticalSpaceX,
        CreateSimucNumberSerie(),
        Spacing.verticalSpaceX,
        CreateSimucRelatedDefect(),
        Spacing.verticalSpaceX,
        CreateSimucInspEntrance(),
        Spacing.verticalSpaceX,
        CreateSimucUser(),
        Spacing.verticalSpaceX,
        CreateSimucCam(),
        Spacing.verticalSpaceX,
        CreateSimucButton()
      ],
    );
  }
}
