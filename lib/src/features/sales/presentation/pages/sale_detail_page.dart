import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/routing/routes/sales_history.routes.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../../../core/utils/breakpoints.dart';
import '../../../patients/presentation/controllers/patient_provider.dart';
import '../../../pos/domain/sale.dart';
import '../controllers/sale_items_provider.dart';
import '../controllers/sale_provider.dart';
import '../widgets/sale_status_card.dart';
import '../widgets/sale_status_chip.dart';

/// Sale detail page showing sale information and items.
class SaleDetailPage extends ConsumerWidget {
  const SaleDetailPage({
    super.key,
    required this.saleId,
  });

  final String saleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saleAsync = ref.watch(saleProvider(saleId));
    final isTablet = Breakpoints.isTabletOrLarger(context);

    return saleAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(
          leading: isTablet
              ? null
              : IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => const SalesHistoryRoute().go(context),
                ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('Error loading sale: ${error.toString()}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(saleProvider(saleId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (sale) {
        if (sale == null) {
          return Scaffold(
            appBar: AppBar(
              leading: isTablet
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => const SalesHistoryRoute().go(context),
                    ),
            ),
            body: const Center(
              child: Text('Sale not found'),
            ),
          );
        }

        return _SaleDetailContent(
          sale: sale,
          isTablet: isTablet,
        );
      },
    );
  }
}

class _SaleDetailContent extends ConsumerWidget {
  const _SaleDetailContent({
    required this.sale,
    required this.isTablet,
  });

  final Sale sale;
  final bool isTablet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final saleItemsAsync = ref.watch(saleItemsProvider(sale.id));
    final dateFormat = DateFormat('MMM dd, yyyy hh:mm a');
    final currencyFormat = NumberFormat.currency(symbol: '₱');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !isTablet,
        leading: isTablet
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => const SalesHistoryRoute().go(context),
              ),
        title: Text(sale.receiptNumber),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              showWarningSnackBar(context, message: 'Print functionality coming soon');
            },
            tooltip: 'Print Receipt',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(saleProvider(sale.id));
          ref.invalidate(saleItemsProvider(sale.id));
          await Future.wait([
            ref.read(saleProvider(sale.id).future),
            ref.read(saleItemsProvider(sale.id).future),
          ]);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sale.receiptNumber,
                                style: theme.textTheme.titleLarge,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                sale.created != null
                                    ? dateFormat.format(sale.created!)
                                    : 'Unknown date',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SaleStatusChip(status: sale.status),
                      ],
                    ),
                    const Divider(height: 24),
                    _InfoRow(
                      icon: Icons.payment,
                      label: 'Payment Method',
                      value: _formatPaymentMethod(sale.paymentMethod),
                    ),
                    if (sale.patient != null && sale.patient!.isNotEmpty)
                      _PatientInfoRow(patientId: sale.patient!)
                    else if (sale.customerName != null && sale.customerName!.isNotEmpty)
                      _InfoRow(
                        icon: Icons.person,
                        label: 'Customer',
                        value: sale.customerName!,
                      ),
                    if (sale.paymentRef != null && sale.paymentRef!.isNotEmpty)
                      _InfoRow(
                        icon: Icons.receipt,
                        label: 'Reference',
                        value: sale.paymentRef!,
                      ),
                    if (sale.paymentProofUrl != null &&
                        sale.paymentProofUrl!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.image,
                            size: 18,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Payment Proof',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                GestureDetector(
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (_) => Dialog(
                                      child: InteractiveViewer(
                                        child: Image.network(
                                          sale.paymentProofUrl!,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      sale.paymentProofUrl!,
                                      height: 120,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          const SizedBox(
                                        height: 50,
                                        child: Center(
                                          child: Icon(Icons.broken_image),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (sale.notes != null && sale.notes!.isNotEmpty)
                      _InfoRow(
                        icon: Icons.note,
                        label: 'Notes',
                        value: sale.notes!,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Status Card
            SaleStatusCard(status: sale.status),
            const SizedBox(height: 16),

            // Items Section
            Text(
              'Items',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Card(
              child: saleItemsAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, _) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Error loading items: $error'),
                ),
                data: (items) => items.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('No items'),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return ListTile(
                            title: Text(item.productName),
                            subtitle: Text(
                              '${currencyFormat.format(item.unitPrice)} × ${item.quantity}',
                            ),
                            trailing: Text(
                              currencyFormat.format(item.subtotal),
                              style: theme.textTheme.titleSmall,
                            ),
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 16),

            // Total Card
            Card(
              color: theme.colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: theme.textTheme.titleLarge,
                    ),
                    Text(
                      currencyFormat.format(sale.totalAmount),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatPaymentMethod(String method) {
    switch (method.toLowerCase()) {
      case 'cash':
        return 'Cash';
      case 'card':
        return 'Card';
      case 'banktransfer':
        return 'Bank Transfer';
      case 'check':
        return 'Check';
      default:
        return method;
    }
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

/// Fetches and displays patient info for a sale.
class _PatientInfoRow extends ConsumerWidget {
  const _PatientInfoRow({required this.patientId});

  final String patientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final patientAsync = ref.watch(patientProvider(patientId));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            Icons.pets,
            size: 20,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Text(
            'Patient: ',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Expanded(
            child: patientAsync.when(
              loading: () => const SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              error: (_, __) => Text(
                'Unknown patient',
                style: theme.textTheme.bodyMedium,
              ),
              data: (patient) => Text(
                patient?.name ?? 'Unknown patient',
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
