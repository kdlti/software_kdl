import '../../../../../../presentation/presenters.dart';
import '../../../../usecases/usecases_table/in_progress_table/simuc/delete_simucs_factory.dart';
import '../../../../usecases/usecases_table/in_progress_table/simuc/send_simuc_factory.dart';
import '../../../../usecases/usecases_table/in_progress_table/simuc/usecases.dart';

GetxTableSimucPresenter makeGetxCreateSimucPresenter() =>
    GetxTableSimucPresenter(
        makeRemoteLoadSimuc(), makeRemoteSendSimuc(), makeRemoteLoadDefects(), makeRemoteDeleteSimuc());
