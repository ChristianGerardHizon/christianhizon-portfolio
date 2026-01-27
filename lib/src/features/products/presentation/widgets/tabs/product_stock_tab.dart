import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/product.dart';
import '../product_lot_list.dart';
import '../product_stock_badge.dart';
import '../dialogs/stock_adjustment_dialog.dart';

/// Stock tab for product detail page.
///
/// Shows different content based on whether the product uses lot tracking:
/// - If trackByLot is true: Shows lot list with lot management
/// - If trackByLot is false: Shows simple stock overview
class ProductStockTab extends StatelessWidget {
  const ProductStockTab({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    if (product.trackByLot) {
      return ProductLotList(productId: product.id);
    }

    return _SimpleStockView(product: product);
  }
}

/// Simple stock view for products not tracked by lot.
class _SimpleStockView extends StatelessWidget {
  const _SimpleStockView({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat.yMMMd();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Stock status card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ProductStockBadge(
                    status: product.stockStatus,
                    showLabel: true,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.quantityDisplay,
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'In Stock',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Stock details
          Card(
            child: Column(
              children: [
                _DetailRow(
                  icon: Icons.inventory,
                  label: 'Current Quantity',
                  value: product.quantityDisplay,
                ),
                const Divider(height: 1),
                _DetailRow(
                  icon: Icons.warning_amber,
                  label: 'Low Stock Threshold',
                  value: product.stockThreshold?.toStringAsFixed(0) ??
                      'Not set',
                ),
                const Divider(height: 1),
                _DetailRow(
                  icon: Icons.calendar_today,
                  label: 'Expiration Date',
                  value: product.expiration != null
                      ? dateFormat.format(product.expiration!)
                      : 'Not set',
                  isWarning: product.isExpired,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Adjust stock button
          FilledButton.icon(
            onPressed: () => showProductStockAdjustmentDialog(context, product),
            icon: const Icon(Icons.tune),
            label: const Text('Adjust Stock'),
          ),
          const SizedBox(height: 24),

          // Lot tracking info
          Card(
            color: theme.colorScheme.surfaceContainerHighest,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lot Tracking Disabled',
                          style: theme.textTheme.titleSmall,
                        ),
                        Text(
                          'Enable "Track by Lot" in product settings to manage inventory by batch/lot numbers.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
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
    final color = isWarning ? theme.colorScheme.error : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color ?? theme.colorScheme.outline),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
