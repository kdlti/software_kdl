import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../atoms/atoms.dart';
import '../components_presenter.dart';
import 'molecules.dart';

class TableComponentsView extends StatelessWidget {
  final ComponentsPresenter presenter;
  const TableComponentsView({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (_) => presenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AtomsTableComponent(presenter: presenter),
          AtomsSideData(presenter: presenter),
          const SizedBox(width: 100),
          TableDefectsAtoms(presenter: presenter),
          const SizedBox(width: 100),
          ImageMolecume(presenter: presenter)
        ],
      ),
    );
  }
}
