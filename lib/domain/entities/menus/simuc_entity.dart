import 'package:equatable/equatable.dart';

class SimucEntityMenus extends Equatable {
  final String numberSerie;
  final String item;
  final String dateRegister;
  final String defectRelated;
  final String inspEntrance;
  final String defectFound;
  final String status;
  final String user;
  final String arId;
  final String imageA;
  final String? imageB;

  @override
  List get props => [
        numberSerie,
        item,
        dateRegister,
        defectRelated,
        inspEntrance,
        defectFound,
        status,
        user,
        arId,
        imageA,
        imageB
      ];

  const SimucEntityMenus({
    required this.numberSerie,
    required this.item,
    required this.dateRegister,
    required this.defectRelated,
    required this.inspEntrance,
    required this.defectFound,
    required this.status,
    required this.user,
    required this.arId,
    required this.imageA,
    required this.imageB,
  });
}
