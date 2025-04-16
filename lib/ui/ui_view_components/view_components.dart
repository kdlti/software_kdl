import 'package:flutter/material.dart';

import 'molecules/molecules.dart';
import '../../main/factories/form/view_components/form_factory.dart';

class ViewComponents extends StatelessWidget {
  final String id;
  final String arid;
  final String simuc;
  const ViewComponents({
    super.key,
    required this.id,
    required this.arid,
    required this.simuc,
  });

  @override
  Widget build(BuildContext context) {
    return TableComponentsView(
      presenter: makeGetxComponentsPresenter(id, arid, simuc),
    );
  }
}
