import 'package:equatable/equatable.dart';

class ComponentsEntityTable extends Equatable {
  final String code;
  final String description;
  final String value;

  @override
  List get props => [code, description, value];

  const ComponentsEntityTable({
    required this.code,
    required this.description,
    required this.value
  });
}
