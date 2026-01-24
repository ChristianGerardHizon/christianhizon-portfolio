import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../settings/domain/branch.dart';
import '../../domain/patient.dart';
import '../../domain/patient_record.dart';
import '../../domain/prescription.dart';

/// Data container for prescription PDF generation.
class PrescriptionPdfData {
  const PrescriptionPdfData({
    required this.prescriptions,
    required this.patient,
    required this.record,
    required this.prescriptionDate,
    this.prescriptionNumber,
    this.branch,
  });

  final List<Prescription> prescriptions;
  final Patient patient;
  final PatientRecord record;
  final DateTime prescriptionDate;
  final String? prescriptionNumber;
  final Branch? branch;
}

/// Generates A4 prescription PDF documents.
class PrescriptionPdfGenerator {
  PrescriptionPdfGenerator(this.data);

  final PrescriptionPdfData data;

  /// Generates and shows print dialog.
  Future<void> printPrescription() async {
    await Printing.layoutPdf(
      onLayout: (format) async => _generatePdf(),
      format: PdfPageFormat.a4,
      name: 'Prescription_${_formatFilename()}',
    );
  }

  /// Generates PDF and opens share dialog to save/share.
  Future<void> sharePrescription() async {
    final pdfBytes = await _generatePdf();
    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: 'Prescription_${_formatFilename()}.pdf',
    );
  }

  /// Saves PDF via save dialog (desktop) or to downloads (mobile/web).
  Future<String?> savePrescription() async {
    final pdfBytes = await _generatePdf();
    final filename = 'Prescription_${_formatFilename()}';

    // On web, use sharePdf which triggers a download
    if (kIsWeb) {
      await Printing.sharePdf(
        bytes: pdfBytes,
        filename: '$filename.pdf',
      );
      return filename;
    }

    // On other platforms, use save dialog
    final result = await FileSaver.instance.saveAs(
      name: filename,
      bytes: pdfBytes,
      ext: 'pdf',
      mimeType: MimeType.pdf,
    );

    return result;
  }

  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document();

    // Load logo image from assets
    final logoData = await rootBundle.load('assets/icons/app_icon_transparent.png');
    final logoImage = pw.MemoryImage(logoData.buffer.asUint8List());

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _buildHeader(logoImage),
            pw.SizedBox(height: 20),
            _buildPrescriptionInfo(),
            pw.SizedBox(height: 20),
            _buildPatientInfo(),
            pw.SizedBox(height: 20),
            _buildMedicationsTable(),
            pw.Spacer(),
            _buildPhysicianSection(),
            pw.SizedBox(height: 20),
            _buildFooter(),
          ],
        ),
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildHeader(pw.MemoryImage logo) {
    final branch = data.branch;
    final clinicName = branch?.displayName ?? branch?.name ?? 'Veterinary Clinic';

    return pw.Column(
      children: [
        // Logo and clinic info row
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Image(logo, width: 60, height: 60),
            pw.SizedBox(width: 16),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    clinicName,
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  if (branch?.address != null && branch!.address!.isNotEmpty)
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(top: 2),
                      child: pw.Text(
                        branch.address!,
                        style: const pw.TextStyle(fontSize: 9),
                      ),
                    ),
                  if (branch?.contactNumber != null &&
                      branch!.contactNumber!.isNotEmpty)
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(top: 2),
                      child: pw.Text(
                        'Tel: ${branch.contactNumber}',
                        style: const pw.TextStyle(fontSize: 9),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 12),
        pw.Divider(thickness: 1.5, color: PdfColors.grey600),
        pw.SizedBox(height: 8),
        pw.Center(
          child: pw.Text(
            'VETERINARY PRESCRIPTION',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Divider(thickness: 0.5, color: PdfColors.grey400),
      ],
    );
  }

  pw.Widget _buildPrescriptionInfo() {
    final dateFormat = DateFormat('MMMM d, yyyy');
    final prescriptionNo = data.prescriptionNumber ??
        'RX-${DateFormat('yyyyMMdd').format(data.prescriptionDate)}-${data.record.id.substring(0, 4).toUpperCase()}';

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text('Prescription No: $prescriptionNo'),
        pw.Text('Date: ${dateFormat.format(data.prescriptionDate)}'),
      ],
    );
  }

  pw.Widget _buildPatientInfo() {
    final speciesBreed = [
      data.patient.species,
      data.patient.breed,
    ].where((s) => s != null && s.isNotEmpty).join(' - ');

    final ageSex = [
      data.patient.age,
      data.patient.sex?.name.capitalize(),
    ].where((s) => s != null && s.isNotEmpty).join(' / ');

    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'PATIENT INFORMATION',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
          ),
          pw.SizedBox(height: 8),
          _buildInfoRow('Name', data.patient.name),
          _buildInfoRow('Species/Breed', speciesBreed),
          _buildInfoRow('Age/Sex', ageSex),
          _buildInfoRow('Owner', data.patient.owner ?? ''),
          _buildInfoRow('Contact', data.patient.contactNumber ?? ''),
          _buildInfoRow('Weight', data.record.weight),
        ],
      ),
    );
  }

  pw.Widget _buildInfoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 100,
            child: pw.Text('$label:', style: const pw.TextStyle(fontSize: 10)),
          ),
          pw.Expanded(
            child: pw.Text(value, style: const pw.TextStyle(fontSize: 10)),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildMedicationsTable() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'LIST OF PRESCRIBED MEDICATIONS',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
        ),
        pw.SizedBox(height: 8),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey400),
          columnWidths: {
            0: const pw.FixedColumnWidth(30), // #
            1: const pw.FlexColumnWidth(3), // Medication
            2: const pw.FlexColumnWidth(2), // Dosage
            3: const pw.FlexColumnWidth(4), // Instructions
          },
          children: [
            // Header row
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey200),
              children: [
                _tableCell('#', isHeader: true),
                _tableCell('Medication Name', isHeader: true),
                _tableCell('Dosage', isHeader: true),
                _tableCell('Instructions', isHeader: true),
              ],
            ),
            // Data rows
            ...data.prescriptions.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final prescription = entry.value;
              return pw.TableRow(
                children: [
                  _tableCell('$index'),
                  _tableCell(prescription.medication),
                  _tableCell(prescription.dosage ?? '-'),
                  _tableCell(prescription.instructions ?? '-'),
                ],
              );
            }),
          ],
        ),
      ],
    );
  }

  pw.Widget _tableCell(String text, {bool isHeader = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: isHeader ? pw.FontWeight.bold : null,
        ),
      ),
    );
  }

  pw.Widget _buildPhysicianSection() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'ATTENDING VETERINARIAN',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
          ),
          pw.SizedBox(height: 16),
          _buildSignatureLine('Name'),
          pw.SizedBox(height: 12),
          _buildSignatureLine('License No'),
          pw.SizedBox(height: 12),
          _buildSignatureLine('Signature'),
        ],
      ),
    );
  }

  pw.Widget _buildSignatureLine(String label) {
    return pw.Row(
      children: [
        pw.SizedBox(
          width: 80,
          child: pw.Text('$label:', style: const pw.TextStyle(fontSize: 10)),
        ),
        pw.Expanded(
          child: pw.Container(
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(color: PdfColors.grey400),
              ),
            ),
            height: 20,
          ),
        ),
      ],
    );
  }

  pw.Widget _buildFooter() {
    return pw.Center(
      child: pw.Text(
        'This prescription is valid for 7 days from the date of issue.',
        style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
      ),
    );
  }

  String _formatFilename() {
    final date = DateFormat('yyyy-MM-dd').format(data.prescriptionDate);
    final name = data.patient.name.replaceAll(' ', '_');
    return '${name}_$date';
  }
}

/// Extension to capitalize first letter of a string.
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
