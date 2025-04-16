import '../../../../utils/validation/composites/composites.dart';
import '../../../../utils/validation/presentation/protocols/protocols.dart';
import '../../../../utils/validation/protocols/protocols.dart';
import '../../builders/menu_item/builders.dart';

Validation makeFormValidation() {
  return ValidationComposite(makeFormValidations());
}

List<FieldValidation> makeFormValidations() {
  return [
    ...ValidationBuilder.field("Numero de Serie")!.required().numberSerie().build(),
    ...ValidationBuilder.field('Defeito Relatado')!.required().build(),
    ...ValidationBuilder.field('Insp Entrada')!.required().build(),
    ...ValidationBuilder.field('Usuário')!.required().build()
  ];
}
