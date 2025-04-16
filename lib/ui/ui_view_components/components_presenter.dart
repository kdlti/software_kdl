import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';

abstract class ComponentsPresenter implements Listenable {
  Stream<bool> get isLoadingStream;
  List<ComponentsEntity> get listComponents;
  double get total;
  int get highestNivel;
  List<ComponentsEntity> get source;
  List<ImagesEntity> get sourceImages;

  Stream<Uint8List?>? get imageA;
  Stream<Uint8List?>? get imageB;

  Future<List<DefectsEntity>> fetchDefects();
  Future<List<ComponentsEntity>> fetchData();
  Future<List<ImagesEntity>> fetchImages();
  initializeData();
  sum();
}
