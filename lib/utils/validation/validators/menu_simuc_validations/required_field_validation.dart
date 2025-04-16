import 'package:equatable/equatable.dart';

import '../../validation.dart';
import '../../protocols/protocols.dart';

class RequiredFieldValidationItem extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const RequiredFieldValidationItem(this.field);

  @override
  ValidationError? validate(Map input, bool? isInList) {
    if (input.containsKey('Defeito Relatado')) {
      if (input['Defeito Relatado'] == 'Defeito Relatado') {
        return ValidationError.requiredField;
      }
    }
     if (input.containsKey('Insp Entrada')) {
      if (input['Insp Entrada'] == 'Inspeção de Entrada') {
        return ValidationError.requiredField;
      }
    }
    return input[field]?.isNotEmpty == true
        ? null
        : ValidationError.requiredField;
  }
}
