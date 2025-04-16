import '../../../../presentation/presenters.dart';
import '../../../../ui/ui_menus/ui_menu_item/ui/forms/create/create.dart';
import '../../usecases/usecases_menu_item/record_simuc_factory.dart';
import '../../usecases/usecases_menu_item/usecases.dart';
import 'form_validation_factory.dart';

CreateSimucPresenter makeGetxCreateSimucPresenter(String? id) => GetxCreateSimucPresenter(
  id: id,
  loadSimuc: makeRemoteLoadSimuc(id),
  validation: makeFormValidation(), 
  recordItem: makeRemoteRecordSimuc()
);