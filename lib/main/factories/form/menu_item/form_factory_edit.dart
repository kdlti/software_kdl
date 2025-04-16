import '../../../../presentation/presenters/menus/getx_edit_simuc_presenter.dart';
import '../../../../ui/ui_menus/ui_menu_item/ui/forms/edit/edit.dart';
import '../../usecases/usecases_menu_item/create_edit_presenter_usecase/presenter.dart';

CreateEditPresenter makeGetxEditSimucPresenter(String? id) =>
    GetxEditSimucPresenter(record: makeRemoteEditSimuc());
