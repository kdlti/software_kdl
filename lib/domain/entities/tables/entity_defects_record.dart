import 'package:equatable/equatable.dart';

class DefectsRecordEntity extends Equatable {
  final String arId;
  final String itemId;
  final List<String?> defectsId;
  final String? obs;

  @override
  List get props => [arId, itemId, defectsId, obs];

  const DefectsRecordEntity({
    required this.arId,
    required this.itemId,
    required this.defectsId,
    required this.obs,
  });
}
