import '../../../../../../data/usecases/table_usecases/remote_load/remote_load_simuc.dart';
import '../../../../../../domain/usecases/usecases.dart';
import '../../../../../../infra/infra.dart';
import '../../../../http/http.dart';

LoadSimuc makeRemoteLoadSimuc() => RemoteLoadSimuc(
  url: RouteManager().makeApiUrl("simucs"),
  httpClient: makeHttpAdapter()
);