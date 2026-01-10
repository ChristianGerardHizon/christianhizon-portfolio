import 'dart:typed_data';
import 'package:sannjosevet/src/core/utils/file_utils/file_utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfGenerator {
  static Future<bool> print({
    pw.Widget? header,
    pw.Widget? content,
    pw.Widget? footer,
  }) async {
    return PdfGenerator()
        .createPdf(header: header, content: content, footer: footer);
  }

  final pw.Widget? header;
  final pw.Widget? content;
  final pw.Widget? footer;

  PdfGenerator({this.header, this.content, this.footer});

  Future<bool> createPdf({
    pw.Widget? header,
    pw.Widget? content,
    pw.Widget? footer,
  }) async {
    try {
      final pdfData =
          await _generatePdf(header: header, content: content, footer: footer);
      await Printing.layoutPdf(onLayout: (format) async => pdfData);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> save() async {
    try {
      final pdfData = await _generatePdf();
      final filePath = await _savePdfToFile(pdfData);
      return filePath != null;
    } catch (e) {
      return false;
    }
  }

  Future<Uint8List> _generatePdf(
      {pw.Widget? header, pw.Widget? content, pw.Widget? footer}) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              if (header != null) header,
              pw.SizedBox(height: 20),
              if (content != null) content,
              pw.SizedBox(height: 20),
              if (footer != null) footer,
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static Future<String?> _savePdfToFile(Uint8List pdfData) async {
    return saveBytesToFile(bytes: pdfData, filename: 'prescription.pdf');
  }
}
