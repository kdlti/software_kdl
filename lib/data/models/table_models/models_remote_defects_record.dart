
import '../../../domain/entities/entities.dart';

class ModelsRemoteDefectsRecord {
  final String arId;
  final String itemId;
  final List<String?> defectsId;
  final String? obs;

  const ModelsRemoteDefectsRecord({
    required this.arId,
    required this.itemId,
    required this.defectsId,
    required this.obs,
  });

  factory ModelsRemoteDefectsRecord.fromDomain(DefectsRecordEntity params) =>
      ModelsRemoteDefectsRecord(
        arId: params.arId,
        itemId: params.itemId,
        defectsId: params.defectsId,
        obs: params.obs
      );

  factory ModelsRemoteDefectsRecord.fromJson(Map? json) {
    return ModelsRemoteDefectsRecord(
      arId: json?['ar_id'] ?? '',
      itemId: json?['item_id'] ?? '',
      defectsId: json?['defects_id'] ?? '',
      obs: json?['obs'] ?? '',
    );
  }

  DefectsRecordEntity toEntity() => DefectsRecordEntity(
        arId: arId,
        itemId: itemId,
        defectsId: defectsId,
        obs: obs
      );

  Map toJson() => {
        'ar_id': arId,
        'item_id': itemId,
        'defects_id': defectsId,
        'obs': obs,
      };
}
