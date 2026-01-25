import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../core/routing/routes/system.routes.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../settings/presentation/controllers/printer_config_provider.dart';
import '../../domain/sale.dart';
import '../../domain/sale_item.dart';
import '../services/thermal_print_service.dart';

/// Shows the receipt bottom sheet after successful checkout.
Future<void> showReceiptSheet(
  BuildContext context, {
  required Sale sale,
  List<SaleItem> saleItems = const [],
}) {
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
        saleItems: saleItems,
        scrollController: scrollController,
      ),
    ),
  );
}

/// Receipt sheet displaying sale details.
class ReceiptSheet extends HookConsumerWidget {
  const ReceiptSheet({
    super.key,
    required this.sale,
    this.saleItems = const [],
    this.scrollController,
  });

  final Sale sale;
  final List<SaleItem> saleItems;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy hh:mm a');
    final isPrinting = useState(false);
    final hasAutoPrinted = useState(false);
    final printCashierCopy = useState(true);
    final defaultPrinterAsync = ref.watch(defaultPrinterProvider);
    final currentAuth = ref.watch(currentAuthProvider);

    Future<void> handleThermalPrint({bool showSuccessMessage = true}) async {
      // Get printer before async operations to avoid ref disposal issues
      final printer = defaultPrinterAsync.value;
      if (printer == null) {
        showErrorSnackBar(context, message: 'No default printer configured');
        return;
      }

      isPrinting.value = true;

      final printService = ref.read(thermalPrintServiceProvider.notifier);

      // Print customer copy
      final result = await printService.printReceipt(
        printer: printer,
        sale: sale,
        items: saleItems,
        cashierName: currentAuth?.user.name,
      );

      if (result is PrintFailure) {
        isPrinting.value = false;
        if (context.mounted) {
          showErrorSnackBar(context, message: result.message);
        }
        return;
      }

      // Print cashier copy if enabled
      if (printCashierCopy.value) {
        // Small delay between prints to ensure printer is ready
        await Future.delayed(const Duration(milliseconds: 500));

        final cashierResult = await printService.printReceipt(
          printer: printer,
          sale: sale,
          items: saleItems,
          cashierName: currentAuth?.user.name,
        );

        if (cashierResult is PrintFailure) {
          isPrinting.value = false;
          if (context.mounted) {
            showErrorSnackBar(
              context,
              message: 'Customer copy printed, but cashier copy failed',
            );
          }
          return;
        }
      }

      isPrinting.value = false;

      if (!context.mounted) return;

      if (showSuccessMessage) {
        final copies = printCashierCopy.value ? '2 copies' : '1 copy';
        showSuccessSnackBar(context, message: 'Receipt printed ($copies)');
      }
    }

    // Auto-print when sheet opens if default printer is configured
    useEffect(() {
      final defaultPrinter = defaultPrinterAsync.value;
      if (defaultPrinter != null && !hasAutoPrinted.value && !isPrinting.value) {
        hasAutoPrinted.value = true;
        // Slight delay to ensure UI is ready
        Future.delayed(const Duration(milliseconds: 300), () {
          handleThermalPrint(showSuccessMessage: true);
        });
      }
      return null;
    }, [defaultPrinterAsync.value]);

    Future<void> handlePdfPrint() async {
      final dateFormat = DateFormat('MMM dd, yyyy hh:mm a');
      // Use 'P' instead of '₱' for PDF compatibility (Helvetica doesn't support ₱)
      final currencyFormat =
          NumberFormat.currency(symbol: 'P', decimalDigits: 2);

      await Printing.layoutPdf(
        onLayout: (format) async {
          final pdf = pw.Document();
          pdf.addPage(
            pw.Page(
              pageFormat: PdfPageFormat.a4,
              margin: const pw.EdgeInsets.all(40),
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
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Total:',
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        currencyFormat.format(sale.totalAmount),
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (sale.notes != null && sale.notes!.isNotEmpty) ...[
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
    }

    final hasDefaultPrinter = defaultPrinterAsync.value != null;

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
                  color:
                      theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
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
          const SizedBox(height: 16),

          // Cashier copy option (only show if printer configured)
          if (hasDefaultPrinter)
            CheckboxListTile(
              value: printCashierCopy.value,
              onChanged: (value) => printCashierCopy.value = value ?? true,
              title: const Text('Print cashier copy'),
              subtitle: const Text('Prints 2 copies: customer + business'),
              dense: true,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
            ),
          const SizedBox(height: 16),

          // Actions
          Row(
            children: [
              // Thermal print button (primary if configured)
              if (hasDefaultPrinter) ...[
                Expanded(
                  child: FilledButton.icon(
                    onPressed: isPrinting.value ? null : handleThermalPrint,
                    icon: isPrinting.value
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.print),
                    label: Text(isPrinting.value ? 'Printing...' : 'Print'),
                  ),
                ),
                const SizedBox(width: 8),
                // PDF print as secondary
                IconButton.outlined(
                  onPressed: handlePdfPrint,
                  icon: const Icon(Icons.picture_as_pdf),
                  tooltip: 'Print as PDF',
                ),
                const SizedBox(width: 8),
              ] else ...[
                // No printer configured - show PDF print with configure option
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: handlePdfPrint,
                    icon: const Icon(Icons.print_outlined),
                    label: const Text('Print PDF'),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    context.pop();
                    const PrinterSettingsRoute().go(context);
                  },
                  child: const Text('Setup Printer'),
                ),
                const SizedBox(width: 8),
              ],
              // Done button
              Expanded(
                child: hasDefaultPrinter
                    ? OutlinedButton(
                        onPressed: () => context.pop(),
                        child: const Text('Done'),
                      )
                    : FilledButton(
                        onPressed: () => context.pop(),
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
