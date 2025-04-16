import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../../../../../utils/errors/ui_error.dart';



abstract class CreateSimucPresenter implements Listenable {
  Stream<UIError?>? get numberSerieErrorStream;
  Stream<String?>? get itemErrorStream;
  Stream<UIError?>? get relatedDefectErrorStream;
  Stream<UIError?>? get inspEntranceErrorStream;
  Stream<Uint8List?>? get firstImageErrorStream;
  Stream<Uint8List?>? get secondImageErrorStream;
  Stream<bool?>? get isCameraInitializedStream;
  Stream<UIError?>? get userErrorStream;
  Stream<bool?>? get isFormValidStream;
  Stream<bool> get isLoadingStream;
  Stream<bool> get isLoadingMessageStream;

  CameraController? controller;
  XFile? image;

  void receiveDataFromTable();
  Future<bool> loadListSimucValidation(BuildContext context);
  Future<void> initializeCamera();
  void deleteImage(String numberImage);
  Future<void> captureImage(String cam);
  void validateNumberSerie(String numberSerie);
  void validateItem(String item);
  void validateRelatedDefect(String relatedDefect);
  void validateInspEntrance(String inspEntrance);
  void validateUser(String user);
  Future<void> record();
}
