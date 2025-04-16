import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../../../widgets/widget.dart';
import '../../../dialogs/dialogs.dart';
import '../../../forms/create/create.dart';

class CreateSimucGallery extends StatefulWidget {
  const CreateSimucGallery({super.key});

  @override
  State<CreateSimucGallery> createState() => _CreateSimucGalleryState();
}

class _CreateSimucGalleryState extends State<CreateSimucGallery> {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<CreateSimucPresenter>(context);
    var width = MediaQuery.of(context).size.width;

    return width < 1500
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<Uint8List?>(
                stream: presenter.firstImageErrorStream,
                builder: (context, snapshot) => snapshot.data != null
                    ? InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => CamDialog(
                              title: "FOTO 1",
                              snapshot: snapshot.data,
                              onPressed: () {
                                presenter.deleteImage("1");
                                Navigator.of(context).pop();
                              },
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          width: 100,
                          height: 100,
                          child: snapshot.data != null
                              ? Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(3.14159),
                                  child:
                                      Image.memory(snapshot.data!).marginAll(2),
                                )
                              : const Center(child: Icon(Icons.camera_enhance)),
                        ),
                      )
                    : const CamTemplate(),
              ),
              const SizedBox(height: 20),
              StreamBuilder<Uint8List?>(
                  stream: presenter.secondImageErrorStream,
                  builder: (context, snapshot) => snapshot.data != null
                      ? InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => CamDialog(
                                title: "FOTO 2",
                                snapshot: snapshot.data,
                                onPressed: () {
                                  presenter.deleteImage("2");
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.5),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            width: 100,
                            height: 100,
                            child: snapshot.data != null
                                ? Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(3.14159),
                                    child: Image.memory(snapshot.data!)
                                        .marginAll(2),
                                  )
                                : const Center(
                                    child: Icon(Icons.camera_enhance)),
                          ),
                        )
                      : const CamTemplate())
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<Uint8List?>(
                  stream: presenter.firstImageErrorStream,
                  builder: (context, snapshot) => snapshot.data != null
                      ? InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => CamDialog(
                                title: "FOTO 1",
                                snapshot: snapshot.data,
                                onPressed: () {
                                  presenter.deleteImage("1");
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.5),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            width: 100,
                            height: 100,
                            child: snapshot.data != null
                                ? Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(3.14159),
                                    child: Image.memory(snapshot.data!)
                                        .marginAll(2),
                                  )
                                : const Center(
                                    child: Icon(Icons.camera_enhance)),
                          ),
                        )
                      : const CamTemplate()),
              StreamBuilder<Uint8List?>(
                  stream: presenter.secondImageErrorStream,
                  builder: (context, snapshot) => snapshot.data != null
                      ? InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => CamDialog(
                                title: "FOTO 2",
                                snapshot: snapshot.data,
                                onPressed: () {
                                  presenter.deleteImage("2");
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.5),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            width: 100,
                            height: 100,
                            child: snapshot.data != null
                                ? Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(3.14159),
                                    child: Image.memory(snapshot.data!)
                                        .marginAll(2),
                                  )
                                : const Center(
                                    child: Icon(Icons.camera_enhance)),
                          ),
                        )
                      : const CamTemplate())
            ],
          );
  }
}
