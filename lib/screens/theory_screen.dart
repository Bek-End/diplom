import 'package:diplom/core/constants.dart';
import 'package:diplom/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class TheoryScreen extends StatelessWidget {
  const TheoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PdfView(
      controller: PdfController(
        document: PdfDocument.openAsset(Constants.theoryFile),
      ),
      errorBuilder: (error) => const LoadingWidget(),
    );
  }
}
