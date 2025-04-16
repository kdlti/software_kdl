import 'package:equatable/equatable.dart';

class ClientAddressEntity extends Equatable {
  final String? client;
  final String? address;
  final String? email;
  final String? contato;

  @override
  List get props => [client, address, email, contato];

  const ClientAddressEntity({
    this.client,
    this.address,
    this.email,
    this.contato,
  });
}
