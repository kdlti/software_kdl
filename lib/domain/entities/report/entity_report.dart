import 'package:equatable/equatable.dart';

class ReportEntity extends Equatable {
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

  const ReportEntity({
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
}
