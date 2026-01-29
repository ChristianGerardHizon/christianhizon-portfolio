import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../core/utils/permission_service.dart';
import '../../domain/report_period.dart';

/// Data container for report PDF generation.
class ReportPdfData {
  const ReportPdfData({
    required this.reportTitle,
    required this.period,
    required this.generatedAt,
    required this.kpiData,
    this.tableHeaders,
    this.tableRows,
    this.additionalNotes,
  });

  /// Title of the report (e.g., "Sales Report").
  final String reportTitle;

  /// The time period of the report.
  final ReportPeriod period;

  /// When the report was generated.
  final DateTime generatedAt;

  /// KPI data as key-value pairs.
  final Map<String, String> kpiData;

  /// Optional table headers.
  final List<String>? tableHeaders;

  /// Optional table rows (list of lists).
  final List<List<String>>? tableRows;

  /// Optional additional notes.
  final String? additionalNotes;
}

/// Generates A4 report PDF documents.
class ReportPdfGenerator {
  ReportPdfGenerator(this.data);

  final ReportPdfData data;

  /// Generates and shows print dialog.
  Future<void> printReport() async {
    await Printing.layoutPdf(
      onLayout: (format) async => _generatePdf(),
      format: PdfPageFormat.a4,
      name: '${data.reportTitle}_${_formatFilename()}',
    );
  }

  /// Generates PDF and opens share dialog to save/share.
  Future<void> shareReport() async {
    final pdfBytes = await _generatePdf();
    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: '${data.reportTitle.replaceAll(' ', '_')}_${_formatFilename()}.pdf',
    );
  }

  /// Saves PDF via save dialog (desktop) or to downloads (mobile/web).
  ///
  /// Requests storage permissions on Android if needed.
  /// Throws [PermissionDeniedException] if permission is permanently denied.
  Future<String?> saveReport() async {
    await PermissionService.ensureStoragePermissions();

    final pdfBytes = await _generatePdf();
    final filename =
        '${data.reportTitle.replaceAll(' ', '_')}_${_formatFilename()}';

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
    final logoData =
        await rootBundle.load('assets/icons/app_icon_transparent.png');
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
            _buildReportInfo(),
            pw.SizedBox(height: 20),
            _buildKpiSection(),
            if (data.tableHeaders != null && data.tableRows != null) ...[
              pw.SizedBox(height: 20),
              _buildDataTable(),
            ],
            if (data.additionalNotes != null) ...[
              pw.SizedBox(height: 20),
              _buildNotes(),
            ],
            pw.Spacer(),
            _buildFooter(),
          ],
        ),
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildHeader(pw.MemoryImage logo) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Image(logo, width: 50, height: 50),
            pw.SizedBox(width: 16),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    data.reportTitle.toUpperCase(),
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    'Generated Report',
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 12),
        pw.Divider(thickness: 1.5, color: PdfColors.grey600),
      ],
    );
  }

  pw.Widget _buildReportInfo() {
    final dateFormat = DateFormat('MMMM d, yyyy h:mm a');

    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Period: ${data.period.displayName}',
                style: const pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                'From: ${DateFormat('MMM d, y').format(data.period.startDate)}',
                style: const pw.TextStyle(fontSize: 10),
              ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                'Generated:',
                style: const pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                dateFormat.format(data.generatedAt),
                style: const pw.TextStyle(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildKpiSection() {
    final entries = data.kpiData.entries.toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'KEY METRICS',
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 12),
        pw.Wrap(
          spacing: 16,
          runSpacing: 8,
          children: entries.map((entry) {
            return pw.Container(
              width: 150,
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.grey300),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    entry.value,
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    entry.key,
                    style: const pw.TextStyle(
                      fontSize: 9,
                      color: PdfColors.grey600,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  pw.Widget _buildDataTable() {
    final headers = data.tableHeaders!;
    final rows = data.tableRows!;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'DETAILED DATA',
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey400),
          children: [
            // Header row
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey200),
              children:
                  headers.map((h) => _tableCell(h, isHeader: true)).toList(),
            ),
            // Data rows
            ...rows.map((row) {
              return pw.TableRow(
                children: row.map((cell) => _tableCell(cell)).toList(),
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
          fontSize: 9,
          fontWeight: isHeader ? pw.FontWeight.bold : null,
        ),
      ),
    );
  }

  pw.Widget _buildNotes() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Notes',
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            data.additionalNotes!,
            style: const pw.TextStyle(fontSize: 9),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildFooter() {
    return pw.Column(
      children: [
        pw.Divider(thickness: 0.5, color: PdfColors.grey400),
        pw.SizedBox(height: 8),
        pw.Center(
          child: pw.Text(
            'This report was automatically generated. Data is accurate as of the generation date.',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
          ),
        ),
      ],
    );
  }

  String _formatFilename() {
    return DateFormat('yyyy-MM-dd_HHmmss').format(data.generatedAt);
  }
}
