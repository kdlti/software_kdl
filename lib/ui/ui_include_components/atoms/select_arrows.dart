import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../components_presenter.dart';


class SelectArrows extends StatelessWidget {
  const SelectArrows({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<ComponentsPresenter>(context);
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: presenter.selectedLeftItems.isNotEmpty
                ? () {
                    presenter.rightTableData
                        .addAll(presenter.selectedLeftItems);
                    presenter.leftTableData.removeWhere((item) =>
                        presenter.selectedLeftItems.contains(item));
                    presenter.selectedLeftItems.clear();
                  }
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: presenter.selectedRightItems.isNotEmpty
                ? () {
                    presenter.leftTableData
                        .addAll(presenter.selectedRightItems);
                    presenter.rightTableData.removeWhere((item) =>
                        presenter.selectedRightItems.contains(item));
                    presenter.selectedRightItems.clear();
                  }
                : null,
          ),
          const SizedBox(height: 10),
        ],
      );
    });
  }
}
