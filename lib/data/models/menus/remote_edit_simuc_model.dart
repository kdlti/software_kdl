import '../../../../../../domain/entities/entities.dart';

class RemoteEditSimucModel {
  final String id;
  final String numberSerie;
  final String defectRelated;
  final String inspEntrance;
  final String defectFound;
  final String arId;

  const RemoteEditSimucModel({
    required this.id,
    required this.numberSerie,
    required this.defectRelated,
    required this.inspEntrance,
    required this.defectFound,
    required this.arId,
  });

  factory RemoteEditSimucModel.fromDomain(EditSimucEntity params) =>
      RemoteEditSimucModel(
        id: params.id,
        numberSerie: params.numberSerie,
        defectRelated: params.defectRelated,
        inspEntrance: params.inspEntrance,
        defectFound: params.defectFound,
        arId: params.arId
      );

  factory RemoteEditSimucModel.fromJson(Map? json) {
    return RemoteEditSimucModel(
      id: json?['id'] ?? '',
      numberSerie: json?['number_serie'] ?? '',
      defectRelated: json?['defect_related'] ?? '',
      inspEntrance: json?['insp_entrance'] ?? '',
      defectFound: json?['defect_found'] ?? '',
      arId: json?['ar_id'] ?? '',
    );
  }

  EditSimucEntity toEntity() => EditSimucEntity(
        id: id,
        numberSerie: numberSerie,
        defectRelated: defectRelated,
        inspEntrance: inspEntrance,
        defectFound: defectFound,
        arId: arId
      );

  Map toJson() => {
        'id': id,
        'number_serie': numberSerie,
        'defect_related': defectRelated,
        'insp_entrance': inspEntrance,
        'defect_found': defectFound,
        'ar_id': arId
      };
}
