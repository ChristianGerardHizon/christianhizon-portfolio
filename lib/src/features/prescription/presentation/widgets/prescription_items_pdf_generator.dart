import 'dart:io';
import 'dart:typed_data';
import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/features/prescription/presentation/widgets/logo_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:gym_system/src/features/prescription/domain/prescription_item.dart';

class PrescriptionItemsPdfGenerator {
  final List<PrescriptionItem> items;

  PrescriptionItemsPdfGenerator({required this.items});

  /// Static method to print the prescription items
  static Future<bool> printStatic(List<PrescriptionItem> items) async {
    return PrescriptionItemsPdfGenerator(items: items).print();
  }

  /// Static method to share the prescription items
  static Future<bool> shareStatic(List<PrescriptionItem> items) async {
    return PrescriptionItemsPdfGenerator(items: items).share();
  }

  String buildFileName() {
    final fileName = 'prescription-${DateTime.now().yyyyMMdd()}.pdf';
    return fileName;
  }

  Future<bool> share() async {
    try {
      final pdfData = await _generatePdf();
      await Printing.sharePdf(bytes: pdfData, filename: buildFileName());
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Generates and prints the PDF
  Future<bool> print() async {
    final pdfData = await _generatePdf();
    await Printing.layoutPdf(
      onLayout: (format) async => pdfData,
      name: buildFileName(),
    );
    return true;
  }

  /// Saves the generated PDF to local storage
  Future<bool> save() async {
    final pdfData = await _generatePdf();
    final filePath = await _savePdfToFile(pdfData);
    return filePath != null;
  }

  /// Generates the prescription PDF
  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              _buildHeader(),
              _buildPatient(),
              pw.SizedBox(height: 20),
              _buildTable(),
              pw.SizedBox(height: 30),
              pw.Container(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Doctor: __________________________________",
                          style: pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          "Printed: ${DateTime.now().yyyyMMddHHmmA()}",
                          style: pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ])),
              pw.SizedBox(height: 10),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildPatient() {
    return pw.Container(
      alignment: pw.Alignment.topLeft,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Text(
                "Patient: _________________________",
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              ),
              pw.SizedBox(width: 10),
              pw.Text(
                "Species: _________________________",
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            children: [
              pw.Text(
                "Breed: _________________________",
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              ),
              pw.SizedBox(width: 10),
              pw.Text(
                "Age: ___________",
                style: pw.TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildHeader() {
    // final logoPath = Assets.icons.appIconTransparent.path;

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.SvgImage(svg: LogoSvg.logo, width: 80),
        pw.SizedBox(width: 10),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              "Sann Jose Animal Clinic ",
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              "Door no.2 Guianao Bldg. Capitan Sabi St., ",
              style: pw.TextStyle(
                fontSize: 10,
              ),
            ),
            pw.Text(
              "Zone 12, Carmela Valley, Talisay City ",
              style: pw.TextStyle(
                fontSize: 10,
              ),
            ),
            pw.Text(
              "Tel No: (034)-4672805 / 0970-466-3344",
              style: pw.TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        )
      ],
    );
  }

  /// Builds a table for the prescription items without borders
  pw.Widget _buildTable() {
    return pw.TableHelper.fromTextArray(
      headerDecoration: pw.BoxDecoration(
        border:
            pw.Border(bottom: pw.BorderSide(width: 1, color: PdfColors.black)),
      ),
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
      headers: ["#", "Medication", "Dosage", "Instructions"],
      textStyleBuilder: (index, data, rowNum) => pw.TextStyle(
        fontSize: 12,
        fontWeight: pw.FontWeight.normal,
      ),
      data: items
          .mapWithIndex((item, index) => [
                (index + 1).toString(),
                item.medication ?? "N/A",
                item.dosage ?? "N/A",
                item.instructions ?? "N/A",
              ])
          .toList(),
      cellAlignment: pw.Alignment.centerLeft,
      border: null, // Removes the borders
    );
  }

  /// Saves the PDF to a file
  static Future<String?> _savePdfToFile(Uint8List pdfData) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/prescription_items.pdf');
      await file.writeAsBytes(pdfData);
      return file.path;
    } catch (e) {
      return null;
    }
  }
}
