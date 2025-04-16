import 'package:flutter/material.dart';

import '../../../main/factories/form/table/in_progress_table/ar/form.dart';
import '../../ui_tables/ar/ui/organism/organism.dart';

class Manutencao extends StatefulWidget {
  const Manutencao({
    Key? key,
  }) : super(key: key);
  @override
  ManutencaoState createState() => ManutencaoState();
}

class ManutencaoState extends State<Manutencao> {
  @override
  Widget build(BuildContext context) {
    return InitTableAr(controller: makeGetxCreateArPresenter());
  }
}
