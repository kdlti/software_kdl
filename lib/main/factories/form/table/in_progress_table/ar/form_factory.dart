import '../../../../../../presentation/presenters.dart';
import '../../../../usecases/usecases_table/in_progress_table/ar/edit_ar_factory.dart';
import '../../../../usecases/usecases_table/in_progress_table/ar/load_pdf_factory.dart';
import '../../../../usecases/usecases_table/in_progress_table/ar/load_report_factory.dart';
import '../../../../usecases/usecases_table/in_progress_table/ar/load_simuc_factory.dart';
import '../../../../usecases/usecases_table/in_progress_table/ar/usecases.dart';

GetxArPresenter makeGetxCreateArPresenter() => GetxArPresenter(
      loadPdf: makeRemoteLoadPdfs(),
      editAr: makeRemoteEditAr(),
      load: makeRemoteLoadAr(),
      loadSimuc: makeRemoteLoadSimuc(),
      loadReport: makeRemoteLoadReport()
    );
