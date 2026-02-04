import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/routing/routes/products.routes.dart';
import '../../../../core/routing/routes/sales_history.routes.dart';
import '../controllers/dashboard_kpi_provider.dart';
import '../controllers/todays_sales_controller.dart';
import 'kpi_card.dart';

/// Section displaying KPI summary cards on the dashboard.
///
/// Shows:
/// - Today's sales count and total
/// - Low stock items (warning color if > 0)
/// - Products near expiration (warning color if > 0)
/// - Expired products (error color if > 0)
class KpiSummarySection extends ConsumerWidget {
  const KpiSummarySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nearExpirationAsync = ref.watch(productsNearExpirationCountProvider);
    final expiredAsync = ref.watch(productsExpiredCountProvider);
    final lowStockAsync = ref.watch(lowStockProductsCountProvider);
    final salesSummaryAsync = ref.watch(todaySalesSummaryProvider);

    // Use Column with Rows to fill width with 2 columns per row
    const spacing = 12.0;

    final row1Cards = <Widget>[
      // Today's sales
      Expanded(
        child: salesSummaryAsync.when(
          data: (summary) => KpiCard(
            title: "Today's Sales",
            value: summary.count.toString(),
            icon: Icons.point_of_sale,
            subtitle: _formatCurrency(summary.total),
            compact: true,
            color: Colors.green,
            onTap: () => const SalesHistoryRoute().go(context),
          ),
          loading: () => _buildLoadingCard(),
          error: (_, __) => _buildErrorCard(
            context,
            "Today's Sales",
            Icons.point_of_sale,
          ),
        ),
      ),
      const SizedBox(width: spacing),
      // Low stock items
      Expanded(
        child: lowStockAsync.when(
          data: (count) => KpiCard(
            title: 'Low Stock',
            value: count.toString(),
            icon: Icons.inventory_2_outlined,
            subtitle: 'Items need restock',
            compact: true,
            color: count > 0 ? Colors.orange : null,
            onTap: () => const ProductsRoute().go(context),
          ),
          loading: () => _buildLoadingCard(),
          error: (_, __) => _buildErrorCard(
            context,
            'Low Stock',
            Icons.inventory_2_outlined,
          ),
        ),
      ),
    ];

    final row2Cards = <Widget>[
      // Products near expiration
      Expanded(
        child: nearExpirationAsync.when(
          data: (count) => KpiCard(
            title: 'Near Expiration',
            value: count.toString(),
            icon: Icons.warning_amber_rounded,
            subtitle: 'Within 30 days',
            compact: true,
            color: count > 0 ? Colors.orange : null,
            onTap: () => const ProductsRoute().go(context),
          ),
          loading: () => _buildLoadingCard(),
          error: (_, __) => _buildErrorCard(
            context,
            'Near Expiration',
            Icons.warning_amber_rounded,
          ),
        ),
      ),
      const SizedBox(width: spacing),
      // Expired products
      Expanded(
        child: expiredAsync.when(
          data: (count) => KpiCard(
            title: 'Expired Products',
            value: count.toString(),
            icon: Icons.error_outline,
            subtitle: 'Requires attention',
            compact: true,
            color: count > 0 ? Colors.red : null,
            onTap: () => const ProductsRoute().go(context),
          ),
          loading: () => _buildLoadingCard(),
          error: (_, __) => _buildErrorCard(
            context,
            'Expired Products',
            Icons.error_outline,
          ),
        ),
      ),
    ];

    return Column(
      children: [
        Row(children: row1Cards),
        const SizedBox(height: spacing),
        Row(children: row2Cards),
      ],
    );
  }

  Widget _buildLoadingCard() {
    return const Card(
      child: SizedBox(
        height: 76,
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorCard(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(icon, color: theme.colorScheme.error, size: 16),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '--',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(num amount) {
    final formatter = NumberFormat.currency(
      symbol: '₱',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }
}
