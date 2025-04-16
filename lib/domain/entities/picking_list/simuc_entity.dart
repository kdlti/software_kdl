import 'package:equatable/equatable.dart';

class SimucEntity extends Equatable {
  final String? id;
  final String numberSerie;
  final String? item;
  final String? dateRegister;
  final String defectRelated;
  final String inspEntrance;
  final String defectFound;
  final String? docExit;
  final String? status;
  final String? user;
  final String? arId;
  final String? imageA;
  final String? imageB;
  final String? box;

  @override
  List get props => [
        id,
        numberSerie,
        item,
        dateRegister,
        defectRelated,
        inspEntrance,
        defectFound,
        docExit,
        status,
        user,
        arId,
        imageA,
        imageB,
        box,
      ];

  const SimucEntity({
    this.id,
    required this.numberSerie,
    this.item,
    this.dateRegister,
    required this.defectRelated,
    required this.inspEntrance,
    required this.defectFound,
    this.docExit,
    this.status,
    this.user,
    this.arId,
    this.imageA,
    this.imageB,
    this.box,
  });

  factory SimucEntity.fromJson(Map<String, dynamic> json) {
    return SimucEntity(
      id: json['id'],
      numberSerie: json['number_serie'],
      item: json['item'],
      dateRegister: json['date_register'],
      defectRelated: json['defect_related'],
      inspEntrance: json['insp_entrance'],
      defectFound: json['defect_found'],
      docExit: json['doc_exit'],
      status: json['status'],
      user: json['user'],
      arId: json['ar_id'],
      imageA: json['imageA'],
      imageB: json['imageB'],
      box: json['box'],
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
        return defectFound;
      case 4:
        return inspEntrance;
      case 5:
        return inspEntrance;
      case 6:
        return arId!;
      case 7:
        return inspEntrance;
      default:
        throw Exception('Index out of range');
    }
  }
}
