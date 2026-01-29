import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../core/pdf/pdf_task_runner.dart';
import '../../../../core/utils/permission_service.dart';
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

/// Payload sent to the background isolate for prescription PDF generation.
class _PrescriptionPdfPayload {
  _PrescriptionPdfPayload({
    required this.data,
    required this.logoBytes,
  });

  final PrescriptionPdfData data;
  final Uint8List logoBytes;
}

/// Top-level function that builds the prescription PDF bytes in an isolate.
Future<Uint8List> _buildPrescriptionPdfBytes(_PrescriptionPdfPayload payload) async {
  final data = payload.data;
  final logoImage = pw.MemoryImage(payload.logoBytes);
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _buildHeader(data, logoImage),
          pw.SizedBox(height: 20),
          _buildPrescriptionInfo(data),
          pw.SizedBox(height: 20),
          _buildPatientInfo(data),
          pw.SizedBox(height: 20),
          _buildMedicationsTable(data),
          pw.Spacer(),
          _buildPhysicianSection(),
          pw.SizedBox(height: 20),
          _buildFooter(),
        ],
      ),
    ),
  );

  return await pdf.save();
}

pw.Widget _buildHeader(PrescriptionPdfData data, pw.MemoryImage logo) {
  final branch = data.branch;
  final clinicName = branch?.displayName ?? 'Veterinary Clinic';
  final branchName = branch?.name;
  final showBranchName =
      branchName != null && branchName.isNotEmpty && branchName != clinicName;
  final hasAddress = branch != null && branch.address.isNotEmpty;
  final hasContact = branch != null && branch.contactNumber.isNotEmpty;

  return pw.Column(
    children: [
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
                if (showBranchName)
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 2),
                    child: pw.Text(
                      branchName,
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  ),
                if (hasAddress)
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 2),
                    child: pw.Text(
                      branch.address,
                      style: const pw.TextStyle(fontSize: 9),
                    ),
                  ),
                if (hasContact)
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

pw.Widget _buildPrescriptionInfo(PrescriptionPdfData data) {
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

pw.Widget _buildPatientInfo(PrescriptionPdfData data) {
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

pw.Widget _buildMedicationsTable(PrescriptionPdfData data) {
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
          0: const pw.FixedColumnWidth(30),
          1: const pw.FlexColumnWidth(3),
          2: const pw.FlexColumnWidth(2),
          3: const pw.FlexColumnWidth(4),
        },
        children: [
          pw.TableRow(
            decoration: const pw.BoxDecoration(color: PdfColors.grey200),
            children: [
              _tableCell('#', isHeader: true),
              _tableCell('Medication Name', isHeader: true),
              _tableCell('Dosage', isHeader: true),
              _tableCell('Instructions', isHeader: true),
            ],
          ),
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

/// Generates A4 prescription PDF documents.
class PrescriptionPdfGenerator {
  PrescriptionPdfGenerator(this.data);

  final PrescriptionPdfData data;

  /// Generates and shows print dialog.
  Future<void> printPrescription(BuildContext context) async {
    final result = await _runTask(context);
    if (result is! PdfTaskSuccess) return;

    await Printing.layoutPdf(
      onLayout: (_) async => result.bytes,
      format: PdfPageFormat.a4,
      name: 'Prescription_${_formatFilename()}',
    );
  }

  /// Generates PDF and opens share dialog to save/share.
  Future<void> sharePrescription(BuildContext context) async {
    final result = await _runTask(context);
    if (result is! PdfTaskSuccess) return;

    await Printing.sharePdf(
      bytes: result.bytes,
      filename: 'Prescription_${_formatFilename()}.pdf',
    );
  }

  /// Saves PDF via save dialog (desktop) or to downloads (mobile/web).
  ///
  /// Requests storage permissions on Android if needed.
  /// Throws [PermissionDeniedException] if permission is permanently denied.
  Future<String?> savePrescription(BuildContext context) async {
    await PermissionService.ensureStoragePermissions();

    final result = await _runTask(context);
    if (result is! PdfTaskSuccess) return null;

    final filename = 'Prescription_${_formatFilename()}';

    // On web, use sharePdf which triggers a download
    if (kIsWeb) {
      await Printing.sharePdf(
        bytes: result.bytes,
        filename: '$filename.pdf',
      );
      return filename;
    }

    // On other platforms, use save dialog
    final saveResult = await FileSaver.instance.saveAs(
      name: filename,
      bytes: result.bytes,
      ext: 'pdf',
      mimeType: MimeType.pdf,
    );

    return saveResult;
  }

  Future<PdfTaskResult> _runTask(BuildContext context) {
    return runPdfTask<_PrescriptionPdfPayload>(
      context: context,
      message: 'Generating prescription...',
      preload: () async {
        final logoData =
            await rootBundle.load('assets/icons/app_icon_transparent.png');
        return _PrescriptionPdfPayload(
          data: data,
          logoBytes: logoData.buffer.asUint8List(),
        );
      },
      generate: _buildPrescriptionPdfBytes,
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
