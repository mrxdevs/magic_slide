import 'package:magic_slide/feature/pdf_viewer/domain/model/pdf_download_res_model.dart';

class PdfDownloadResModelImp implements PdfDownloadResModel {
  @override
  final String? filePath;
  @override
  final String? message;

  PdfDownloadResModelImp({this.filePath, this.message});
}
