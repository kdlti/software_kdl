import '../../../../data/usecases/include_components/remote_load_components.dart';
import '../../../../domain/usecases/usecases.dart';
import '../../../../infra/infra.dart';
import '../../http/http.dart';

LoadComponentsInclude makeRemoteComponents() => RemoteLoadComponents(
      url: RouteManager().makeApiUrl("components"),
      httpClient: makeHttpAdapter(),
    );
