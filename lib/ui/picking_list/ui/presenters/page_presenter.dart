import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/entities/entities.dart';
import '../errors/errors.dart';

abstract class PagePresenter implements Listenable {
  var costumer = const ClientAddressEntity();
  final simucEntity = RxList<EntitySimucsPiclingList>([]);
  Stream<List<EntitySimucsPiclingList>> get simucEntityStream;
  final quantity = RxInt(0);
  Stream<Uint8List?>? get bytesPackingList;
  String get quantityInvoice;
  String get box;
  String get receiveArId;
  String get receiveArDoc;
  String get receiveClient;
  Stream<int> get quantityStream;
  Stream<bool?>? get isFormValidStream;
  Stream<UIError?>? get selectClientErrorStream;
  FocusNode get focusNode;

  printBytes(Uint8List bytes);
  savePackingList();
  initializeData(BuildContext context);
  void inputBox(String index);
  void removerDado(int index);
  void getNserlum(String value, BuildContext context);
  void generateAndDownloadExcel();
  cleanList();
} 