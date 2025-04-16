import '../../../../../../data/usecases/usecases.dart';
import '../../../../../../domain/usecases/usecases.dart';
import '../../../../../../infra/infra.dart';
import '../../../../http/http.dart';

LoadDefects makeRemoteLoadDefects() => RemoteLoadDefects(
      url: RouteManager().makeApiUrl("defects"),
      httpClient: makeHttpAdapter(),
    );

