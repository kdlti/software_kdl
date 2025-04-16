import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../presentation/presenters/tables/getx_ar_presenter.dart';

class RowsPerPageAtom extends StatefulWidget {
  const RowsPerPageAtom({super.key});

  @override
  State<RowsPerPageAtom> createState() => _RowsPerPageAtomState();
}

class _RowsPerPageAtomState extends State<RowsPerPageAtom> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxArPresenter>(context);
    return Container(
      height: 30,
      decoration: const BoxDecoration(
          color: Color(0xffd9d9d9),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: DropdownButton<int>(
        borderRadius: BorderRadius.circular(5),
        value: controller.currentPerPage,
        items: controller.perPages
            .map((e) => DropdownMenuItem<int>(
                  value: e,
                  child: Text("$e"),
                ))
            .toList(),
        onChanged: (dynamic value) {
          setState(() {
            controller.currentPerPage = value;
            controller.currentPage = 1;
            controller.resetData();
          });
        },
        isExpanded: false,
      ),
    );
  }
}
