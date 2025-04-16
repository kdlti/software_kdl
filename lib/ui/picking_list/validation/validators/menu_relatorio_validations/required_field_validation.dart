import 'package:equatable/equatable.dart';

import '../../presentation/protocols/protocols.dart';
import '../../protocols/protocols.dart';

class RequiredFieldValidationItem extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const RequiredFieldValidationItem(this.field);

  @override
  ValidationError? validate(Map input, bool? isInList) {
    if (input.containsKey('Cliente Selecionado')) {
      if (input['Cliente Selecionado'] == 'Selecione o Cliente') {
        return ValidationError.requiredField;
      }
    }
    return input[field]?.isNotEmpty == true
        ? null
        : ValidationError.requiredField;
  }
}
