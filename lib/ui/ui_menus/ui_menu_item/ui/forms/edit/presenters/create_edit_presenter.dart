import 'package:flutter/material.dart';
// import 'package:websocket_service_package/export.dart';

import '../../../../../../../domain/entities/entities.dart';
import '../../../../../../../infra/infra.dart';
import '../../../../../../../main/factories/http/http.dart';

abstract class CreateEditPresenter implements Listenable {
  // Stream<UIError?>? get numberSerieErrorStream;
Future<SimucEditReceivedEntity> fetchData(WebSocketService service);
  void editDefectFound(String defectFound);
  void editInspEntrance(String inspEntrance);
  void editDefectRelated(String defectRelated);
  void editNumberSerie(String numberSerie);
  void imprimir();
}
