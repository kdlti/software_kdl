import 'package:equatable/equatable.dart';

class CostumersEntity extends Equatable {
  final String id;
  final String costumer;
  final String address;
  final String email;
  final String number;

  @override
  List get props => [id, costumer, address, email, number];

  const CostumersEntity({
    required this.id,
    required this.costumer,
    required this.address,
    required this.email,
    required this.number,
  });
}
