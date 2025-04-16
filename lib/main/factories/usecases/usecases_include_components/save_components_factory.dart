import '../../../../data/usecases/include_components/remote_save_components.dart';
import '../../../../domain/usecases/usecases.dart';
import '../../../../infra/infra.dart';
import '../../http/http.dart';

ComponentsRecord makeRemoteComponentsSave() => RemoteRecordSimuc(
      url: RouteManager().makeApiUrl("componentsSave"),
      httpClient: makeHttpAdapter(),
    );
