import 'package:teste_git_hub/domain/usecases/usecases.dart';

import '../../../../data/usecases/components_view/remote_load_components.dart';
import '../../../../infra/infra.dart';
import '../../http/http.dart';

LoadComponentsComponentsView makeRemoteComponents(String id) => RemoteLoadComponents(
      id: id,
      url: RouteManager().makeApiUrl("componentsById"),
      httpClient: makeHttpAdapter(),
    );
