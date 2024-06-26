import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PDFViewPage extends StatelessWidget {
  final String pdfUrl;

  PDFViewPage({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: pdfUrl,
        enableSwipe: true,
        fitEachPage: true,
      ),
    );
  }
}
