import 'package:magic_slide/feature/pdf_viewer/domain/model/pdf_download_res_model.dart';

class PdfDownloadModelResImp implements PdfDownloadModel {
  @override
  final String? filePath;
  @override
  final String? message;

  PdfDownloadModelResImp({this.filePath, this.message});
}
