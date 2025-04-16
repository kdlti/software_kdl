import '../../../../presentation/presenters.dart';
import '../../../../ui/ui_view_components/components_presenter.dart';
import '../../usecases/usecases_view_components/usecases_factory.dart';

ComponentsPresenter makeGetxComponentsPresenter(
  String id,
  String arid,
  String simuc,
) =>
    GetxComponentesPresenterComponentsView(
      loadDefects: makeRemoteDefects(id),
      loadComponents: makeRemoteComponents(id),
      loadImages: makeRemoteLoadImages(arid, simuc),
    );
