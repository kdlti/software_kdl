import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../presentation/presenters.dart';
import '../atoms/atoms.dart';

class DashboardMolecule extends StatelessWidget {
  const DashboardMolecule({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxArPresenter>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DashboardAtom(
            label: "Aviso de Recebimento de Consertos: ${controller.total.toString()}",
          ),
          // const DashboardAtom(
          //   label: "Teste",
          // ),
          // const DashboardAtom(
          //   label: "Teste",
          // ),
        ],
      ),
    );
  }
}
