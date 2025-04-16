import '../../../../data/usecases/usecases.dart';
import '../../../../domain/usecases/usecases.dart';
import '../../../../infra/infra.dart';
import '../../http/http.dart';

LoadDefectsView makeRemoteDefects(String id) => RemoteLoadDefectsData(
      id: id,
      url: RouteManager().makeApiUrl("defectsById"),
      httpClient: makeHttpAdapter(),
    );
