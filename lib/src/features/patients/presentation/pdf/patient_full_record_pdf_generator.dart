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
import '../../domain/patient_treatment_record.dart';
import '../../domain/prescription.dart';

/// Data container for patient full record PDF generation.
class PatientFullRecordPdfData {
  const PatientFullRecordPdfData({
    required this.patient,
    required this.records,
    required this.recordPrescriptions,
    required this.treatmentRecords,
    this.branch,
  });

  final Patient patient;

  /// Medical records sorted newest-first.
  final List<PatientRecord> records;

  /// Prescriptions keyed by record ID.
  final Map<String, List<Prescription>> recordPrescriptions;

  /// Treatment records sorted newest-first.
  final List<PatientTreatmentRecord> treatmentRecords;

  final Branch? branch;
}

/// Payload for PDF generation.
class _PatientFullRecordPdfPayload {
  _PatientFullRecordPdfPayload({
    required this.data,
    required this.logoBytes,
  });

  final PatientFullRecordPdfData data;
  final Uint8List logoBytes;
}

// ---------------------------------------------------------------------------
// Top-level PDF build function
// ---------------------------------------------------------------------------

Future<Uint8List> _buildPatientFullRecordPdfBytes(
  _PatientFullRecordPdfPayload payload,
) async {
  final data = payload.data;
  final logoImage = pw.MemoryImage(payload.logoBytes);
  final pdf = pw.Document();
  final dateFormat = DateFormat('MMMM d, yyyy');
  final generatedAt = DateFormat('MMMM d, yyyy h:mm a').format(DateTime.now());

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      header: (context) => _buildHeader(data, logoImage),
      footer: (context) => _buildPageFooter(context, generatedAt),
      build: (context) => [
        pw.SizedBox(height: 20),
        _buildPatientInfoSection(data, dateFormat),
        pw.SizedBox(height: 24),
        _buildMedicalRecordsSection(data, dateFormat),
        pw.SizedBox(height: 24),
        _buildTreatmentRecordsSection(data, dateFormat),
      ],
    ),
  );

  return await pdf.save();
}

// ---------------------------------------------------------------------------
// Header
// ---------------------------------------------------------------------------

pw.Widget _buildHeader(PatientFullRecordPdfData data, pw.MemoryImage logo) {
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
          'PATIENT FULL RECORD',
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

// ---------------------------------------------------------------------------
// Page footer
// ---------------------------------------------------------------------------

pw.Widget _buildPageFooter(pw.Context context, String generatedAt) {
  return pw.Column(
    children: [
      pw.Divider(thickness: 0.5, color: PdfColors.grey300),
      pw.SizedBox(height: 4),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Generated on $generatedAt',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
          ),
          pw.Text(
            'Page ${context.pageNumber} of ${context.pagesCount}',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
          ),
        ],
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Patient info section
// ---------------------------------------------------------------------------

pw.Widget _buildPatientInfoSection(
  PatientFullRecordPdfData data,
  DateFormat dateFormat,
) {
  final patient = data.patient;

  final speciesBreed = [
    patient.species,
    patient.breed,
  ].where((s) => s != null && s.isNotEmpty).join(' - ');

  final ageSex = [
    patient.age,
    patient.sex?.name._capitalize(),
  ].where((s) => s != null && s.isNotEmpty).join(' / ');

  final dob = patient.dateOfBirth != null
      ? dateFormat.format(patient.dateOfBirth!.toLocal())
      : '';

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
        _buildInfoRow('Name', patient.name),
        _buildInfoRow('Species/Breed', speciesBreed),
        _buildInfoRow('Age/Sex', ageSex),
        _buildInfoRow('Date of Birth', dob),
        _buildInfoRow('Color', patient.color ?? ''),
        _buildInfoRow('Owner', patient.owner ?? ''),
        _buildInfoRow('Contact', patient.contactNumber ?? ''),
        _buildInfoRow('Email', patient.email ?? ''),
        _buildInfoRow('Address', patient.address ?? ''),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Medical records section
// ---------------------------------------------------------------------------

pw.Widget _buildMedicalRecordsSection(
  PatientFullRecordPdfData data,
  DateFormat dateFormat,
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('MEDICAL RECORDS'),
      pw.SizedBox(height: 8),
      if (data.records.isEmpty)
        pw.Text(
          'No medical records found.',
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
        ),
      ...data.records.asMap().entries.map((entry) {
        final record = entry.value;
        final prescriptions = data.recordPrescriptions[record.id] ?? [];
        return pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 16),
          child: _buildRecordCard(record, prescriptions, dateFormat),
        );
      }),
    ],
  );
}

pw.Widget _buildRecordCard(
  PatientRecord record,
  List<Prescription> prescriptions,
  DateFormat dateFormat,
) {
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
          dateFormat.format(record.date.toLocal()),
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11),
        ),
        pw.SizedBox(height: 8),
        _buildInfoRow('Diagnosis', record.diagnosis),
        _buildInfoRow('Weight', record.weight),
        _buildInfoRow('Temperature', record.temperature),
        if (record.treatment != null && record.treatment!.isNotEmpty)
          _buildInfoRow('Treatment', record.treatment!),
        if (record.notes != null && record.notes!.isNotEmpty)
          _buildInfoRow('Notes', record.notes!),
        if (record.tests != null && record.tests!.isNotEmpty)
          _buildInfoRow('Tests', record.tests!),
        if (prescriptions.isNotEmpty) ...[
          pw.SizedBox(height: 12),
          pw.Text(
            'Prescriptions',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
          ),
          pw.SizedBox(height: 4),
          _buildPrescriptionsTable(prescriptions),
        ],
      ],
    ),
  );
}

pw.Widget _buildPrescriptionsTable(List<Prescription> prescriptions) {
  return pw.Table(
    border: pw.TableBorder.all(color: PdfColors.grey400),
    columnWidths: {
      0: const pw.FixedColumnWidth(24),
      1: const pw.FlexColumnWidth(3),
      2: const pw.FlexColumnWidth(2),
      3: const pw.FlexColumnWidth(4),
    },
    children: [
      pw.TableRow(
        decoration: const pw.BoxDecoration(color: PdfColors.grey200),
        children: [
          _tableCell('#', isHeader: true),
          _tableCell('Medication', isHeader: true),
          _tableCell('Dosage', isHeader: true),
          _tableCell('Instructions', isHeader: true),
        ],
      ),
      ...prescriptions.asMap().entries.map((entry) {
        final index = entry.key + 1;
        final rx = entry.value;
        return pw.TableRow(
          children: [
            _tableCell('$index'),
            _tableCell(rx.medication),
            _tableCell(rx.dosage ?? '-'),
            _tableCell(rx.instructions ?? '-'),
          ],
        );
      }),
    ],
  );
}

// ---------------------------------------------------------------------------
// Treatment records section
// ---------------------------------------------------------------------------

pw.Widget _buildTreatmentRecordsSection(
  PatientFullRecordPdfData data,
  DateFormat dateFormat,
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('TREATMENT RECORDS'),
      pw.SizedBox(height: 8),
      if (data.treatmentRecords.isEmpty)
        pw.Text(
          'No treatment records found.',
          style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
        ),
      if (data.treatmentRecords.isNotEmpty)
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey400),
          columnWidths: {
            0: const pw.FixedColumnWidth(24),
            1: const pw.FlexColumnWidth(3),
            2: const pw.FlexColumnWidth(2),
            3: const pw.FlexColumnWidth(4),
          },
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey200),
              children: [
                _tableCell('#', isHeader: true),
                _tableCell('Treatment', isHeader: true),
                _tableCell('Date', isHeader: true),
                _tableCell('Notes', isHeader: true),
              ],
            ),
            ...data.treatmentRecords.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final tr = entry.value;
              final date = tr.date != null
                  ? dateFormat.format(tr.date!.toLocal())
                  : '-';
              return pw.TableRow(
                children: [
                  _tableCell('$index'),
                  _tableCell(tr.treatmentName),
                  _tableCell(date),
                  _tableCell(tr.notes ?? '-'),
                ],
              );
            }),
          ],
        ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Shared helpers
// ---------------------------------------------------------------------------

pw.Widget _buildSectionTitle(String title) {
  return pw.Text(
    title,
    style: pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: 12,
      letterSpacing: 0.5,
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

// ---------------------------------------------------------------------------
// Generator class
// ---------------------------------------------------------------------------

/// Generates a multi-page A4 PDF with full patient details, medical records,
/// prescriptions, and treatment records.
class PatientFullRecordPdfGenerator {
  PatientFullRecordPdfGenerator(this.data);

  final PatientFullRecordPdfData data;

  /// Generates and shows print dialog.
  Future<void> printRecord(BuildContext context) async {
    final result = await _runTask(context);
    if (result is! PdfTaskSuccess) return;

    await Printing.layoutPdf(
      onLayout: (_) async => result.bytes,
      format: PdfPageFormat.a4,
      name: 'PatientRecord_${_formatFilename()}',
    );
  }

  /// Generates PDF and opens share dialog.
  Future<void> shareRecord(BuildContext context) async {
    final result = await _runTask(context);
    if (result is! PdfTaskSuccess) return;

    await Printing.sharePdf(
      bytes: result.bytes,
      filename: 'PatientRecord_${_formatFilename()}.pdf',
    );
  }

  /// Saves PDF via save dialog (desktop) or to downloads (mobile/web).
  Future<String?> saveRecord(BuildContext context) async {
    await PermissionService.ensureStoragePermissions();

    final result = await _runTask(context);
    if (result is! PdfTaskSuccess) return null;

    final filename = 'PatientRecord_${_formatFilename()}';

    if (kIsWeb) {
      await Printing.sharePdf(
        bytes: result.bytes,
        filename: '$filename.pdf',
      );
      return filename;
    }

    final saveResult = await FileSaver.instance.saveAs(
      name: filename,
      bytes: result.bytes,
      ext: 'pdf',
      mimeType: MimeType.pdf,
    );

    return saveResult;
  }

  Future<PdfTaskResult> _runTask(BuildContext context) {
    return runPdfTask<_PatientFullRecordPdfPayload>(
      context: context,
      message: 'Generating patient record...',
      preload: () async {
        final logoData =
            await rootBundle.load('assets/icons/app_icon_transparent.png');
        return _PatientFullRecordPdfPayload(
          data: data,
          logoBytes: logoData.buffer.asUint8List(),
        );
      },
      generate: _buildPatientFullRecordPdfBytes,
    );
  }

  String _formatFilename() {
    final date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final name = data.patient.name.replaceAll(' ', '_');
    return '${name}_$date';
  }
}

extension _StringCapitalize on String {
  String _capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
