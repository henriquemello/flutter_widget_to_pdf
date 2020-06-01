import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class VisualizaPDF extends StatelessWidget {
  final String path;
  const VisualizaPDF({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      path: path,
    );
  }
}