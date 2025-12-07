import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:magic_slide/feature/pdf_viewer/data/model/pdf_download_model_res_imp.dart';
import 'package:path_provider/path_provider.dart';

class PdfDownloadService {
  Future<PdfDownloadModelResImp> downloadPdf(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final fileName = url.split('/').last.split('?').first;
        final filePath = '${directory.path}/$fileName';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return PdfDownloadModelResImp(filePath: filePath, message: "success");
      } else {
        debugPrint('Failed to download PDF. Status code: ${response.statusCode}');
        return PdfDownloadModelResImp(
          filePath: null,
          message: 'Failed to download PDF. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('Error downloading PDF: $e');
      return PdfDownloadModelResImp(filePath: null, message: 'Error downloading PDF: $e');
    }
  }
}
