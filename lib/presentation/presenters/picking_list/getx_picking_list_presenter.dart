import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ui/picking_list/ui/picking_list_presenter.dart';

class GetxPickingListPresenter extends GetxController
    implements PickingListPresenter {
  @override
  showPrintedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Documento impresso com sucesso'),
      ),
    );
  }
}
