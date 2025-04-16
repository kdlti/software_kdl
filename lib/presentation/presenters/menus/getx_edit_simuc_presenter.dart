import 'package:get/get.dart';
// import 'package:websocket_service_package/export.dart';
import '../../../data/models/models.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import '../../../infra/infra.dart';
import '../../../main/factories/http/http.dart';
import '../../../ui/ui_menus/ui_menu_item/ui/forms/edit/edit.dart';

class GetxEditSimucPresenter extends GetxController
    implements CreateEditPresenter {
  final RecordEditItem record;
  GetxEditSimucPresenter({required this.record});

  String? _numberSerie;
  String? _defectRelated;
  String? _inspEntrance;
  String? _defectFound;
  Map<String, String>? teste;

  @override
  Future<SimucEditReceivedEntity> fetchData(WebSocketService service) async {
    await Future.delayed(const Duration(seconds: 1));
    Map<String, String> selectedData =
        RemoteEditReceivedSimucModel.convertToMap(service.selected);
    teste = RemoteEditReceivedSimucModel.convertToMap(service.selected);
    return SimucEditReceivedEntity(
      id: selectedData['id'] ?? '',
      numberSerie: selectedData['numberSerie'] ?? '',
      item: selectedData['item'] ?? '',
      dateRegister: selectedData['dateRegister'] ?? '',
      defectRelated: selectedData['defectRelated'] ?? '',
      inspEntrance: selectedData['inspEntrance'] ?? '',
      defectFound: selectedData['defectFound'] ?? '',
      status: selectedData['status'] ?? '',
      user: selectedData['user'] ?? '',
      arId: selectedData['arId'] ?? '',
    );
  }

  @override
  void editNumberSerie(String numberSerie) {
    _numberSerie = numberSerie;
  }

  @override
  void editDefectRelated(String defectRelated) {
    _defectRelated = defectRelated;
  }

  @override
  void editInspEntrance(String inspEntrance) {
    _inspEntrance = inspEntrance;
  }

  @override
  void editDefectFound(String defectFound) {
    _defectFound = defectFound;
  }

  @override
  void imprimir() async {
    final package = RemoteEditSimucModel(
      id: teste!["id"] ?? '',
      numberSerie: _numberSerie!,
      defectRelated: _defectRelated!,
      inspEntrance: _inspEntrance!,
      defectFound: _defectFound!,
      arId: teste!["arId"] ?? '',
    ).toEntity();

    await record.recordEditItem(package);
  }
}
