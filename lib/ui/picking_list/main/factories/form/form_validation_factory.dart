import '../../../validation/composites/composites.dart';
import '../../../validation/presentation/protocols/protocols.dart';
import '../../../validation/protocols/protocols.dart';
import '../builders/builders.dart';

Validation makeFormValidation() {
  return ValidationComposite(makeFormValidations());
}

List<FieldValidation> makeFormValidations() {
  return [
    ...ValidationBuilder.field('Cliente Selecionado')!.required().build(),
  ];
}
