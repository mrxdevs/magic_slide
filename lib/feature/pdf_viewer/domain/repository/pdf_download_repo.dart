import 'package:magic_slide/feature/pdf_viewer/data/model/pdf_download_res_model_imp.dart';

abstract class PdfDownloadRepo {
  Future<PdfDownloadResModelImp> downloadPdf(String url);
}
