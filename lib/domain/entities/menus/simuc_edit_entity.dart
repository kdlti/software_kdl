import 'package:equatable/equatable.dart';

class EditSimucEntity extends Equatable {
  final String id;
  final String numberSerie;
  final String defectRelated;
  final String inspEntrance;
  final String defectFound;
  final String arId;

  @override
  List get props => [
        id,
        numberSerie,
        defectRelated,
        inspEntrance,
        defectFound,
        arId
      ];

  const EditSimucEntity({
    required this.id,
    required this.numberSerie,
    required this.defectRelated,
    required this.inspEntrance,
    required this.defectFound,
    required this.arId,
  });
}
