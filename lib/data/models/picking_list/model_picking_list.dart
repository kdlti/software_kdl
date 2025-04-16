import '../../../domain/entities/entities.dart';

class ModelPickingList {
  final String? id;
  final String arid;
  final String box;
  final String numberSerie;
  final String defectRelated;
  final String inspEntrance;
  final String defectConst;
  final String componentsConst;
  final String nivel;
  final String obsConst;

  const ModelPickingList({
    required this.id,
    required this.arid,
    required this.box,
    required this.numberSerie,
    required this.defectRelated,
    required this.inspEntrance,
    required this.defectConst,
    required this.componentsConst,
    required this.nivel,
    required this.obsConst,
  });

  factory ModelPickingList.fromDomain(EntitySimucsPiclingList entity) {
    return ModelPickingList(
        id: entity.id,
        arid: entity.arid,
        box: entity.box,
        numberSerie: entity.numberSerie.toString(),
        defectRelated: entity.defectRelated,
        inspEntrance: entity.inspEntrance,
        defectConst: entity.componentsConst,
        componentsConst: entity.componentsConst,
        nivel: entity.nivel,
        obsConst: entity.obsConst);
  }

  factory ModelPickingList.fromJson(Map<String, dynamic>? json) {
    return ModelPickingList(
      id: json?['id'] ?? '',
      arid: json?['ar_id'] ?? '',
      box: json?['box'] ?? '',
      numberSerie: json?['number_serie'] ?? '',
      defectRelated: json?['defect_related'] ?? '',
      inspEntrance: json?['insp_entrance'] ?? '',
      defectConst: json?['defect_const'] ?? '',
      componentsConst: json?['components_const'] ?? '',
      nivel: json?['nivel'] ?? '',
      obsConst: json?['obs_const'] ?? '',
    );
  }

  EntitySimucsPiclingList toEntity() => EntitySimucsPiclingList(
      id: id,
      arid: arid,
      box: box,
      numberSerie: numberSerie,
      defectRelated: defectRelated,
      inspEntrance: inspEntrance,
      defectConst: defectConst,
      componentsConst: componentsConst,
      nivel: nivel,
      obsConst: obsConst);

  Map toJson() => {
        'id': id,
        'ar_id': arid,
        'box': box,
        'number_serie': numberSerie,
        'defect_related': defectRelated,
        'insp_entrance': inspEntrance,
        'defect_const': defectConst,
        'components_const': componentsConst,
        'nivel': nivel,
        'obs_const': obsConst
      };
}
