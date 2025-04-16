import 'package:equatable/equatable.dart';

class EntitySimucsPiclingList extends Equatable {
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

  @override
  List get props => [
        id,
        arid,
        box,
        numberSerie,
        defectRelated,
        inspEntrance,
        defectConst,
        componentsConst,
        nivel,
        obsConst
      ];

  const EntitySimucsPiclingList({
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

  factory EntitySimucsPiclingList.fromJson(Map<String, dynamic> json) {
    return EntitySimucsPiclingList(
      id: json['id'],
      arid: json['ar_id'],
      box: json['box'],
      numberSerie: json['number_serie'],
      defectRelated: json['defect_related'],
      inspEntrance: json['insp_entrance'],
      defectConst: json['defect_const'],
      componentsConst: json['components_const'],
      nivel: json['nivel'],
      obsConst: json['obs_const'],
    );
  }

  String getValueByIndex(int index) {
    switch (index) {
      case 0:
        return numberSerie;
      case 1:
        return defectRelated;
      case 2:
        return inspEntrance;
      case 3:
        return defectConst;
      case 4:
        return componentsConst;
      case 5:
        return nivel;
      case 6:
        return obsConst;
      default:
        throw Exception('Index out of range');
    }
  }
}
