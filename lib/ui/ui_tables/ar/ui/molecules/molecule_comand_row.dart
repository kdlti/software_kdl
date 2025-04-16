import 'package:flutter/material.dart';
import 'package:menu_modular/export.dart';
import 'package:provider/provider.dart';

import '../../../../../presentation/presenters.dart';
import '../../../../../widgets/widget.dart';
import '../atoms/atoms.dart';

class RowAction extends StatelessWidget {
  const RowAction({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxArPresenter>(context);
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Color(0xffd9d9d9),
      ),
      child: DefaultTabController(
        length: 3,
        child: Row(
          children: [
            CheckboxWidget(
              value: controller.selecteds.length == controller.source.length &&
                  controller.source.isNotEmpty,
              onChanged: (value) => controller.onSelectAll(value),
            ),
            Spacing.horizontalSpaceV,
            const SearchBarArAtom(),
            const Spacer(),
            const FilterData(),
            const RefreshButton(),
            Spacing.horizontalSpaceX,
            const RemovePosition()
          ],
        ),
      ),
    );
  }
}
