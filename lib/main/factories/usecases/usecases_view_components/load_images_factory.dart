import '../../../../data/usecases/usecases.dart';
import '../../../../domain/usecases/usecases.dart';
import '../../../../infra/infra.dart';
import '../../http/http.dart';

LoadImages makeRemoteLoadImages(String arid, String simuc) => RemoteLoadImages(
      arid: arid,
      simuc: simuc,
      url: RouteManager().makeApiUrl("getImage"),
      httpClient: makeHttpAdapter(),
    );
