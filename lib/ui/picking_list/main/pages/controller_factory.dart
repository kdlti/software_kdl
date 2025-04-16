import 'package:http/http.dart';
import 'package:teste_git_hub/data/usecases/usecases.dart';

import '../../../../infra/infra.dart';
import '../../../../main/factories/usecases/usecases_costumers/load_costumers_factory.dart';
import '../../../../presentation/presenters/picking_list/getx_page_presenter.dart';
import '../../ui/page_presenter.dart';
import '../factories/form/form_validation_factory.dart';
import '../factories/http/http.dart';

PagePresenter makeGetxPagePresenter(String arId, String doc, String client) => GetxPagePresenter(
      arId: arId,
      doc: doc,
      client: client,
      loadCostumers: makeRemoteLoadCostumers(),
      validation: makeFormValidation(),
      load: RemoteLoadSimucPickingList(
        url: makeApiUrl("getSimucsByArid"),
        httpClient: HttpAdapter(Client()),
      ),
    );
