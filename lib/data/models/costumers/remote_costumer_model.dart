import '../../../domain/entities/entities.dart';

class RemoteCostumerModel {
  final String id;
  final String costumer;
  final String address;
  final String email;
  final String number;

  const RemoteCostumerModel({
    required this.id,
    required this.costumer,
    required this.address,
    required this.email,
    required this.number,
  });

  factory RemoteCostumerModel.fromDomain(CostumersEntity params) => RemoteCostumerModel(
        id: params.id,
        costumer: params.costumer,
        address: params.address,
        email: params.email,
        number: params.number,
      );

  factory RemoteCostumerModel.fromJson(Map? json) {
    return RemoteCostumerModel(
      id: json?['id'] ?? '',
      costumer: json?['costumer'] ?? '',
      address: json?['address'] ?? '',
      email: json?['email'] ?? '',
      number: json?['number'] ?? '',
    );
  }

  CostumersEntity toEntity() => CostumersEntity(
        id: id,
        costumer: costumer,
        address: address,
        email: email,
        number: number,
      );

  Map toJson() => {
        'id': id,
        'costumer': costumer,
        'address': address,
        'email': email,
        'number': number,
      };
}
