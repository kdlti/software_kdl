import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../presentation/presenters.dart';
import '../../../../../../widgets/widget.dart';

class NavigatePagesAtom extends StatefulWidget {
  const NavigatePagesAtom({Key? key}) : super(key: key);

  @override
  State<NavigatePagesAtom> createState() => _NavigatePagesAtomState();
}

class _NavigatePagesAtomState extends State<NavigatePagesAtom> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxArPresenter>(context);
    return Container(
      height: 30,
      decoration: const BoxDecoration(
          color: Color(0xffd9d9d9),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          IconButtonWidget(
            tooltip: "Voltar",
            onPressed: () => controller.backPage(controller),
            highlightColor: Colors.transparent,
            icon: const Icon(Icons.arrow_back_ios, size: 16),
            padding: const EdgeInsets.symmetric(horizontal: 15),
          ),
          IconButtonWidget(
            tooltip: "Próximo",
            onPressed: () => controller.nextPage(controller),
            highlightColor: Colors.transparent,
            icon: const Icon(Icons.arrow_forward_ios, size: 16),
            padding: const EdgeInsets.symmetric(horizontal: 15),
          ),
        ],
      ),
    );
  }
}
