import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sannjosevet/src/core/assets/assets.gen.dart';
import 'package:sannjosevet/src/core/extensions/date_time_extension.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/utils/file_utils/file_utils.dart';
import 'package:sannjosevet/src/features/patients/prescriptions/domain/patient_prescription_item.dart';
import 'package:sannjosevet/src/features/patients/records/domain/patient_record.dart';
import 'package:sannjosevet/src/features/patients/core/domain/patient.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PatientPdfGenerator {
  final List<PatientPrescriptionItem> items;
  final Patient patient;
  final PatientRecord record;

  PatientPdfGenerator({
    required this.items,
    required this.patient,
    required this.record,
  });

  String buildFileName() {
    final fileName = 'prescription-${DateTime.now().yyyyMMdd()}.pdf';
    return fileName;
  }

  Future<bool> share() async {
    if (kIsWeb)
      throw PresentationFailure('this feature is not available in web');

    final pdfData = await _generatePdf();
    await Printing.sharePdf(bytes: pdfData, filename: buildFileName());
    return true;
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
  Future<String?> save() async {
    if (kIsWeb)
      throw PresentationFailure('this feature is not available in web');

    final pdfData = await _generatePdf();

    final filePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: buildFileName(),
      bytes: pdfData,
      type: FileType.custom,
    );
    return filePath;
  }

  /// Generates the prescription PDF
  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document();
    final header = await _buildHeader();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              header,
              pw.SizedBox(height: 10),
              _buildPatient(),
              pw.SizedBox(height: 40),
              _buildMedications(),
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
                          "Visit Date: ${record.visitDate.fullDateTime}",
                          style: pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          "Printed: ${DateTime.now().fullDateTime}",
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
              pw.Row(children: [
                pw.Text(
                  "Patient: ",
                  style: pw.TextStyle(
                    fontSize: 10,
                  ),
                ),
                _underlineText(pw.Text(
                  "${patient.name}",
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                )),
              ]),
              pw.SizedBox(width: 10),
              pw.Row(children: [
                pw.Text(
                  "Species: ",
                  style: pw.TextStyle(
                    fontSize: 10,
                  ),
                ),
                _underlineText(pw.Text(
                  (patient.expand.species?.name).optional(placeholder: ''),
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                )),
              ]),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            children: [
              pw.Row(children: [
                pw.Text(
                  "Breed: ",
                  style: pw.TextStyle(
                    fontSize: 10,
                  ),
                ),
                _underlineText(pw.Text(
                  (patient.expand.breed?.name).optional(placeholder: ''),
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                )),
              ]),
              pw.SizedBox(width: 10),
              pw.Row(children: [
                pw.Text(
                  "Date of Birth: ",
                  style: pw.TextStyle(
                    fontSize: 10,
                  ),
                ),
                _underlineText(pw.Text(
                  (patient.dateOfBirth?.fullDate)
                      .optional(placeholder: ' ', checkNullString: true),
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                )),
              ])
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _underlineText(pw.Text widget) {
    return pw.Column(children: [
      widget,
      pw.SizedBox(height: 5, width: 130, child: pw.Divider()),
    ]);
  }

  Future<List<pw.Widget>> _loadLogo(String path) async {
    try {
      final ByteData data = await rootBundle.load(path);
      final Uint8List bytes = data.buffer.asUint8List();
      return [pw.Image(pw.MemoryImage(bytes), height: 120)];
    } catch (e) {
      return []; // If the logo is missing, return an empty list
    }
  }

  Future<pw.Widget> _buildHeader() async {
    final logoPath = Assets.icons.appIconTransparent.path;

    final logo = await _loadLogo(logoPath);

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        ...logo,
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
  pw.Widget _buildMedications() {
    return pw.TableHelper.fromTextArray(
      headerDecoration: pw.BoxDecoration(
        border:
            pw.Border(bottom: pw.BorderSide(width: 1, color: PdfColors.black)),
      ),
      headerStyle: pw.TextStyle(
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      headers: ["#", "Medication", "Dosage", "Instructions"],

      textStyleBuilder: (index, data, rowNum) => pw.TextStyle(
        fontSize: 10,
        fontWeight: pw.FontWeight.normal,
      ),
      headerAlignment: pw.Alignment.topLeft,
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
      return saveBytesToFile(bytes: pdfData, filename: 'prescription.pdf');
    } catch (e) {
      return null;
    }
  }
}
