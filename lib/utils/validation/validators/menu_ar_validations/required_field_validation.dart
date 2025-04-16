import 'package:equatable/equatable.dart';

import '../../validation.dart';
import '../../protocols/protocols.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const RequiredFieldValidation(this.field);

  @override
  ValidationError? validate(Map input, bool? isInList) {
    if (input.containsKey('Cliente')) {
      if (input['Cliente'] == 'Selecione um Cliente') {
        return ValidationError.requiredField;
      }
    }
    if (input.containsKey('Tipo de Documento')) {
      if (input['Tipo de Documento'] == 'Tipo de Documento') {
        return ValidationError.requiredField;
      }
    }
    return input[field]?.isNotEmpty == true
        ? null
        : ValidationError.requiredField;
  }
}
