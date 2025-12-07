import 'package:flutter/material.dart';
import 'package:magic_slide/core/helper/route_handler.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
//Using this URL as hardcoded response for now
//https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf

class PdfViewerScreen extends StatefulWidget {
  final String pdfUrl;
  const PdfViewerScreen({super.key, required this.pdfUrl});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => RouteHandler.pop(),
        ),
      ),
      body: Center(child: SfPdfViewer.network(widget.pdfUrl)),
    );
  }
}
