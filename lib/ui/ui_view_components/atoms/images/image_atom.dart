import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dialogs/cam_dialog.dart';

class ImageAtom extends StatefulWidget {
  final Stream<Uint8List?>? image;
  final String title;
  const ImageAtom({super.key, this.image, required this.title});

  @override
  State<ImageAtom> createState() => _ImageAtomState();
}

class _ImageAtomState extends State<ImageAtom> {
  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<Uint8List?>(
        stream: widget.image,
        builder: (context, snapshot) {
          return snapshot.data != null && snapshot.data!.isNotEmpty
              ? InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => CamDialog(
                        title: widget.title,
                        snapshot: snapshot.data,
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    width: 200,
                    height: 150,
                    child: snapshot.data != null && snapshot.data!.isNotEmpty
                        ? Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(3.14159),
                            child: Image.memory(snapshot.data!).marginAll(2),
                          )
                        : const Center(child: Icon(Icons.hide_image_outlined)),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  width: 200,
                  height: 150,
                  child: const Center(child: Icon(Icons.hide_image_outlined)),
                );
        },);
  }
}
