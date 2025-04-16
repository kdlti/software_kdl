import '../../../../../../data/usecases/usecases.dart';
import '../../../../../../domain/usecases/usecases.dart';
import '../../../../../../infra/infra.dart';
import '../../../../http/http.dart';

LoadSimuc makeRemoteLoadSimuc() => RemoteLoadSimuc(
      url: RouteManager().makeApiUrl("simucs"),
      httpClient: makeHttpAdapter(),
    );
