import 'package:flutter/material.dart';
import 'package:menu_modular/export.dart';
import '../../../../../../domain/entities/entities.dart';
import '../../../../../../utils/menus/utils.dart';
import 'edit_simuc_button.dart';
import 'edit_simuc_defect_found.dart';
import 'edit_simuc_insp_entrance.dart';
import 'edit_simuc_number_serie.dart';
import 'edit_simuc_related_defect.dart';

class CreateEditSubForm extends StatelessWidget {
  final SimucEditReceivedEntity data;
  const CreateEditSubForm({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacing.verticalSpaceX,
        EditSimucNumberSerie(data: data),
        Spacing.verticalSpaceX,
        EditSimucRelatedDefect(data: data),
        Spacing.verticalSpaceX,
        EditSimucInspEntrance(data: data),
        Spacing.verticalSpaceX,
        EditSimucDefectFound(data: data),
        const EditSimucButton()
      ],
    );
  }
}
