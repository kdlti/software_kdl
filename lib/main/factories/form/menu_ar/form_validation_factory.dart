import '../../../../utils/validation/composites/composites.dart';
import '../../../../utils/validation/presentation/protocols/protocols.dart';
import '../../../../utils/validation/protocols/protocols.dart';
import '../../builders/menu_ar/builders.dart';

Validation makeFormValidation() {
  return ValidationComposite(makeFormValidations());
}

List<FieldValidation> makeFormValidations() {
  return [
    ...ValidationBuilder.field('Cliente').required().build(),
    ...ValidationBuilder.field('Tipo de Documento').required().build(),
    ...ValidationBuilder.field('Doc. Entrada').required().doc().build(),
    ...ValidationBuilder.field('Posicao').required().position().build(),
    ...ValidationBuilder.field('Qtd. Total Itens').required().build(),
    ...ValidationBuilder.field('Usuário').required().build()
  ];
}
