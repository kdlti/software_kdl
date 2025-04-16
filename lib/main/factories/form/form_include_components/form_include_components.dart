import '../../../../presentation/presenters.dart';
import '../../../../ui/ui_include_components/components_presenter.dart';
import '../../usecases/usecases_include_components/load_components_factory.dart';
import '../../usecases/usecases_include_components/save_components_factory.dart';

ComponentsPresenter makeGetxComponentsPresenter(String id, String arId) =>
    GetxComponentesPresenter(
      id,
      arId,
      loadComponents: makeRemoteComponents(),
      recordComponents: makeRemoteComponentsSave(),
    );
