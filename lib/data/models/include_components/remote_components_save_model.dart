
import '../../../domain/entities/include_components/components_record.dart';

class RemoteComponentsSaveModel {
  final String arId;
  final String itemId;
  final List<String?> componentsId;
  final String quantity;

  const RemoteComponentsSaveModel({
    required this.arId,
    required this.itemId,
    required this.componentsId,
    required this.quantity,
  });

  factory RemoteComponentsSaveModel.fromDomain(ComponentsRecordEntity params) =>
      RemoteComponentsSaveModel(
        arId: params.arId,
        itemId: params.itemId,
        componentsId: params.componentsId,
        quantity: params.quantity,
      );

  factory RemoteComponentsSaveModel.fromJson(Map? json) {
    return RemoteComponentsSaveModel(
      arId: json?['ar_id'] ?? '',
      itemId: json?['item_id'] ?? '',
      componentsId: json?['components_id'] ?? '',
      quantity: json?['quantity'] ?? '',
    );
  }

  ComponentsRecordEntity toEntity() => ComponentsRecordEntity(
        arId: arId,
        itemId: itemId,
        componentsId: componentsId,
        quantity: quantity,
      );

  Map toJson() => {
        'ar_id': arId,
        'item_id': itemId,
        'components_id': componentsId,
        'quantity': quantity,
      };
}
