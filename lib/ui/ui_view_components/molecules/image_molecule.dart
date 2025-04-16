import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../atoms/atoms.dart';
import '../components_presenter.dart';

class ImageMolecume extends StatefulWidget {
  final ComponentsPresenter presenter;
  const ImageMolecume({super.key, required this.presenter});

  @override
  State<ImageMolecume> createState() => _ImageMolecumeState();
}

class _ImageMolecumeState extends State<ImageMolecume> {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<ComponentsPresenter>(context);
    return SizedBox(
      width: 500,
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ImageAtom(image: presenter.imageA, title: "FOTO 1"),
          ImageAtom(image: presenter.imageB, title: "FOTO 2"),
        ],
      ),
    );
  }
}
