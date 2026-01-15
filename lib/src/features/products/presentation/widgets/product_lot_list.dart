import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/product_lot.dart';
import '../controllers/product_lots_controller.dart';
import 'sheets/create_lot_sheet.dart';
import 'sheets/edit_lot_sheet.dart';

/// Widget for displaying a list of product lots.
class ProductLotList extends ConsumerWidget {
  const ProductLotList({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lotsAsync = ref.watch(productLotsControllerProvider(productId));

    return lotsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            Text('Error: $error'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => ref
                  .read(productLotsControllerProvider(productId).notifier)
                  .refresh(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (lots) {
        if (lots.isEmpty) {
          return _EmptyLotState(productId: productId);
        }

        return _LotListContent(
          productId: productId,
          lots: lots,
        );
      },
    );
  }
}

class _EmptyLotState extends StatelessWidget {
  const _EmptyLotState({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 64,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No Lots',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Add lots to track inventory by batch/lot number.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => showCreateLotSheet(context, productId),
              icon: const Icon(Icons.add),
              label: const Text('Add Lot'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LotListContent extends ConsumerWidget {
  const _LotListContent({
    required this.productId,
    required this.lots,
  });

  final String productId;
  final List<ProductLot> lots;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Calculate totals
    final totalQuantity = lots.fold<num>(0, (sum, lot) => sum + lot.quantity);
    final expiredCount = lots.where((l) => l.isExpired).length;

    return Column(
      children: [
        // Summary header
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  icon: Icons.inventory,
                  label: 'Total Qty',
                  value: totalQuantity.toStringAsFixed(0),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryCard(
                  icon: Icons.layers,
                  label: 'Lots',
                  value: lots.length.toString(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SummaryCard(
                  icon: Icons.warning_amber,
                  label: 'Expired',
                  value: expiredCount.toString(),
                  isWarning: expiredCount > 0,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),

        // Lot list
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: lots.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final lot = lots[index];
              return _LotListTile(
                lot: lot,
                onEdit: () => showEditLotSheet(context, lot),
                onDelete: () => _confirmDelete(context, ref, lot),
              );
            },
          ),
        ),

        // Add button
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => showCreateLotSheet(context, productId),
              icon: const Icon(Icons.add),
              label: const Text('Add Lot'),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    ProductLot lot,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Lot'),
        content: Text('Are you sure you want to delete lot "${lot.lotNumber}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await ref
          .read(productLotsControllerProvider(productId).notifier)
          .deleteLot(lot.id);
    }
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.value,
    this.isWarning = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isWarning ? theme.colorScheme.error : theme.colorScheme.primary;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LotListTile extends StatelessWidget {
  const _LotListTile({
    required this.lot,
    required this.onEdit,
    required this.onDelete,
  });

  final ProductLot lot;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat.yMMMd();

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: lot.isExpired
            ? theme.colorScheme.errorContainer
            : lot.isOutOfStock
                ? theme.colorScheme.surfaceContainerHighest
                : theme.colorScheme.primaryContainer,
        child: Icon(
          lot.isExpired
              ? Icons.warning
              : lot.isOutOfStock
                  ? Icons.inventory_2
                  : Icons.inventory,
          color: lot.isExpired
              ? theme.colorScheme.error
              : lot.isOutOfStock
                  ? theme.colorScheme.outline
                  : theme.colorScheme.primary,
        ),
      ),
      title: Text(
        lot.lotNumber,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          decoration: lot.isExpired ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Qty: ${lot.quantityDisplay}'),
          if (lot.expiration != null)
            Text(
              'Exp: ${dateFormat.format(lot.expiration!)}',
              style: TextStyle(
                color: lot.isExpired ? theme.colorScheme.error : null,
              ),
            ),
          if (lot.notes != null && lot.notes!.isNotEmpty)
            Text(
              lot.notes!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
      isThreeLine: lot.expiration != null ||
          (lot.notes != null && lot.notes!.isNotEmpty),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          switch (value) {
            case 'edit':
              onEdit();
              break;
            case 'delete':
              onDelete();
              break;
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit),
                SizedBox(width: 8),
                Text('Edit'),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, color: theme.colorScheme.error),
                const SizedBox(width: 8),
                Text('Delete', style: TextStyle(color: theme.colorScheme.error)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
