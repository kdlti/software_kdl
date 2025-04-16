import 'package:equatable/equatable.dart';

class SimucEditReceivedEntity extends Equatable {
  final String id;
  final String numberSerie;
  final String item;
  final String dateRegister;
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
        defectRelated,
        inspEntrance,
        defectFound,
        status,
        user,
        arId
      ];

  const SimucEditReceivedEntity({
    required this.id,
    required this.numberSerie,
    required this.item,
    required this.dateRegister,
    required this.defectRelated,
    required this.inspEntrance,
    required this.defectFound,
    required this.status,
    required this.user,
    required this.arId,
  });
}
