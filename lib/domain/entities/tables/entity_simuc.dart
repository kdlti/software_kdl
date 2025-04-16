import 'package:equatable/equatable.dart';

class SimucEntityTables extends Equatable {
  final String id;
  final String numberSerie;
  final String item;
  final String dateRegister;
  final String lastUpdate;
  final String defectRelated;
  final String inspEntrance;
  final String defectFound;
  final String status;
  final String user;
  final String arId;

  @override
  List get props => [
        id,
        numberSerie,
        item,
        dateRegister,
        lastUpdate,
        defectRelated,
        inspEntrance,
        defectFound,
        status,
        user,
        arId
      ];

  const SimucEntityTables({
    required this.id,
    required this.numberSerie,
    required this.item,
    required this.dateRegister,
    required this.lastUpdate,
    required this.defectRelated,
    required this.inspEntrance,
    required this.defectFound,
    required this.status,
    required this.user,
    required this.arId,
  });

  dynamic getProperty(String key) {
    switch (key) {
      case 'id':
        return id;
      case 'number_serie':
        return numberSerie;
      case 'item':
        return item;
      case 'date_register':
        return dateRegister;
      case 'last_update':
        return lastUpdate;
      case 'defect_related':
        return defectRelated;
      case 'insp_entrance':
        return inspEntrance;
      case 'status':
        return status;
      case 'user':
        return user;
      case 'ar_id':
        return arId;
      default:
        throw ArgumentError('Invalid property key');
    }
  }

}
