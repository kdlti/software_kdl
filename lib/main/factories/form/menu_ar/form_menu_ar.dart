import '../../../../presentation/presenters.dart';
import '../../../../ui/ui_menus/ui_menu_ar/forms/create/create.dart';
import '../../usecases/usecases_costumers/load_costumers_factory.dart';
import '../../usecases/usecases_menu_ar/usecases.dart';
import 'form_validation_factory.dart';

CreateArPresenter makeGetxCreatePresenter() => GetxCreatePresenter(
      loadCostumers: makeRemoteLoadCostumers(),
      loadAr: makeRemoteLoadAr(),
      recordAr: makeRemoteRecordAr(),
      validation: makeFormValidation(),
    );
