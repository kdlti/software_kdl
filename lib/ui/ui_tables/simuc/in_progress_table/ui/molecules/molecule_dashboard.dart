import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../presentation/presenters.dart';
import '../atoms/atoms.dart';

class DashboardMolecule extends StatefulWidget {
  const DashboardMolecule({super.key});

  @override
  State<DashboardMolecule> createState() => _DashboardMoleculeState();
}

class _DashboardMoleculeState extends State<DashboardMolecule> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxTableSimucPresenter>(context);

    return Row(
      children: [
        DashboardAtom(
          widthIternal: MediaQuery.of(context).size.width * 0.080,
          widthExternal: MediaQuery.of(context).size.width * 0.090,
          label: "Manutenção: ${controller.status0.length.toString()}",
          color: Colors.red.withOpacity(0.3),
          colorInternal: Colors.red.withOpacity(0.5),
        ),
        const SizedBox(width: 10),
        DashboardAtom(
          widthIternal: MediaQuery.of(context).size.width * 0.080,
          widthExternal: MediaQuery.of(context).size.width * 0.090,
          label: "Diagnóstico: ${controller.status2.length.toString()}",
          color: Colors.purple.withOpacity(0.3),
          colorInternal: Colors.purple.withOpacity(0.5),
        ),
        const SizedBox(width: 10),
        DashboardAtom(
          widthIternal: MediaQuery.of(context).size.width * 0.080,
          widthExternal: MediaQuery.of(context).size.width * 0.090,
          label: "Concluídas: ${controller.status1.length.toString()}",
          color: Colors.green.withOpacity(0.3),
          colorInternal: Colors.green.withOpacity(0.5),
        ),
        const SizedBox(width: 10),
        DashboardAtom(
          widthIternal: MediaQuery.of(context).size.width * 0.090,
          widthExternal: MediaQuery.of(context).size.width * 0.1,
          label: "Rom. Gerado: ${controller.status4.length.toString()}",
          color: const Color.fromARGB(255, 139, 189, 255),
          colorInternal: const Color.fromARGB(255, 70, 154, 250),
        ),
      ],
    );
  }
}
