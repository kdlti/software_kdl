import 'package:equatable/equatable.dart';

class ComponentsRecordEntity extends Equatable {
  final String arId;
  final String itemId;
  final List<String?> componentsId;
  final String quantity;

  @override
  List get props => [arId ,itemId, componentsId, quantity];

  const ComponentsRecordEntity({
    required this.arId,
    required this.itemId,
    required this.componentsId,
    required this.quantity
  });
}
