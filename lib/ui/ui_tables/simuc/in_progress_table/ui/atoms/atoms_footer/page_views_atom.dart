import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../presentation/presenters.dart';

class PageViewsAtom extends StatefulWidget {
  const PageViewsAtom({Key? key}) : super(key: key);

  @override
  State<PageViewsAtom> createState() => _PageViewsAtomState();
}

class _PageViewsAtomState extends State<PageViewsAtom> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxTableSimucPresenter>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        "SIMUCs: ${controller.total}",
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
