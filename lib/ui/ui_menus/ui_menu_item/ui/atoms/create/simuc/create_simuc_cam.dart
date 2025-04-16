import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';

import '../../../../../../../widgets/widget.dart';
import '../../../forms/create/create.dart';
import 'create_simuc_gallery.dart';

class CreateSimucCam extends StatefulWidget {
  const CreateSimucCam({super.key});

  @override
  CreateSimucCamState createState() => CreateSimucCamState();
}

class CreateSimucCamState extends State<CreateSimucCam> {
  @override
  void initState() {
    super.initState();
    final presenter = Provider.of<CreateSimucPresenter>(context, listen: false);
    presenter.initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<CreateSimucPresenter>(context);
    return StreamBuilder<bool?>(
        stream: presenter.isCameraInitializedStream,
        builder: (context, snapshot) {
          return Column(
            children: [
              snapshot.data == true
                  ? Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(3.14159),
                            child: CameraPreview(presenter.controller!),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Column(
                            children: [
                              CamFloatingAction(
                                  onPressed: () => presenter.captureImage("1")),
                              const SizedBox(height: 40),
                              CamFloatingAction(
                                  onPressed: () => presenter.captureImage("2"))
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
              const SizedBox(height: 20),
              presenter.image != null
                  ? const CreateSimucGallery()
                  : const CreateSimucGallery(),
            ],
          );
        });
  }
}
