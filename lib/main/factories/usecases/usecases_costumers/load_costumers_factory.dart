import '../../../../data/usecases/usecases.dart';
import '../../../../domain/usecases/costumer/load_costumers.dart';
import '../../../../infra/infra.dart';
import '../../http/http.dart';

LoadCostumers makeRemoteLoadCostumers() => RemoteLoadCostumers(
      url: RouteManager().makeApiUrl("costumers"),
      httpClient: makeHttpAdapter(),
    );
