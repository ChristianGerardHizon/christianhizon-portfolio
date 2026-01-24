import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../core/utils/currency_format.dart';
import '../../domain/sale.dart';

/// Shows the receipt bottom sheet after successful checkout.
Future<void> showReceiptSheet(BuildContext context, {required Sale sale}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    isDismissible: false,
    enableDrag: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => ReceiptSheet(
        sale: sale,
        scrollController: scrollController,
      ),
    ),
  );
}

/// Receipt sheet displaying sale details.
class ReceiptSheet extends ConsumerWidget {
  const ReceiptSheet({
    super.key,
    required this.sale,
    this.scrollController,
  });

  final Sale sale;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy hh:mm a');

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Success icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              size: 40,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),

          Text(
            'Sale Complete!',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          Text(
            'Receipt #${sale.receiptNumber}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Receipt details
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(
                      context,
                      'Date',
                      sale.created != null
                          ? dateFormat.format(sale.created!)
                          : dateFormat.format(DateTime.now()),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      context,
                      'Payment Method',
                      _formatPaymentMethod(sale.paymentMethod),
                    ),
                    if (sale.paymentRef != null &&
                        sale.paymentRef!.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      _buildDetailRow(
                        context,
                        'Reference',
                        sale.paymentRef!,
                      ),
                    ],
                    const Divider(height: 32),
                    _buildDetailRow(
                      context,
                      'Total Amount',
                      sale.totalAmount.toCurrency(),
                      isTotal: true,
                    ),
                    if (sale.notes != null && sale.notes!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Notes',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        sale.notes!,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final dateFormat = DateFormat('MMM dd, yyyy hh:mm a');
                    await Printing.layoutPdf(
                      onLayout: (format) async {
                        final pdf = pw.Document();
                        pdf.addPage(
                          pw.Page(
                            pageFormat: PdfPageFormat.roll80,
                            build: (context) => pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Center(
                                  child: pw.Text(
                                    'Receipt',
                                    style: pw.TextStyle(
                                      fontSize: 24,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ),
                                pw.SizedBox(height: 8),
                                pw.Center(
                                  child: pw.Text(
                                    '#${sale.receiptNumber}',
                                    style: const pw.TextStyle(fontSize: 12),
                                  ),
                                ),
                                pw.SizedBox(height: 20),
                                pw.Divider(),
                                pw.SizedBox(height: 10),
                                pw.Text(
                                  'Date: ${sale.created != null ? dateFormat.format(sale.created!) : dateFormat.format(DateTime.now())}',
                                ),
                                pw.SizedBox(height: 4),
                                pw.Text(
                                  'Payment: ${_formatPaymentMethod(sale.paymentMethod)}',
                                ),
                                if (sale.paymentRef != null &&
                                    sale.paymentRef!.isNotEmpty) ...[
                                  pw.SizedBox(height: 4),
                                  pw.Text('Reference: ${sale.paymentRef}'),
                                ],
                                pw.SizedBox(height: 10),
                                pw.Divider(),
                                pw.SizedBox(height: 10),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'Total:',
                                      style: pw.TextStyle(
                                        fontSize: 16,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      sale.totalAmount.toCurrency(),
                                      style: pw.TextStyle(
                                        fontSize: 16,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                if (sale.notes != null &&
                                    sale.notes!.isNotEmpty) ...[
                                  pw.SizedBox(height: 10),
                                  pw.Divider(),
                                  pw.SizedBox(height: 10),
                                  pw.Text(
                                    'Notes:',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.SizedBox(height: 4),
                                  pw.Text(sale.notes!),
                                ],
                                pw.SizedBox(height: 20),
                                pw.Center(
                                  child: pw.Text(
                                    'Thank you!',
                                    style: const pw.TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                        return pdf.save();
                      },
                    );
                  },
                  icon: const Icon(Icons.print_outlined),
                  label: const Text('Print'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                )
              : theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
        ),
        Text(
          value,
          style: isTotal
              ? theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                )
              : theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
        ),
      ],
    );
  }

  String _formatPaymentMethod(String method) {
    switch (method) {
      case 'cash':
        return 'Cash';
      case 'card':
        return 'Card';
      case 'bankTransfer':
        return 'Bank Transfer';
      case 'check':
        return 'Check';
      default:
        return method;
    }
  }
}
