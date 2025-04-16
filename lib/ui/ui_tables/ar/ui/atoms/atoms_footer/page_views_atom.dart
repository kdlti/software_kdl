import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../presentation/presenters/tables/getx_ar_presenter.dart';

class PageViewsAtom extends StatefulWidget {
  const PageViewsAtom({super.key});

  @override
  State<PageViewsAtom> createState() => _PageViewsAtomState();
}

class _PageViewsAtomState extends State<PageViewsAtom> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxArPresenter>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        "ARs: ${controller.total}",
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
