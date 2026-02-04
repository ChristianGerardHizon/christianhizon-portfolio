import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/routing/routes/sales_history.routes.dart';
import '../controllers/new_customers_controller.dart';
import '../controllers/todays_sales_controller.dart';
import 'kpi_card.dart';

/// Section displaying KPI summary cards on the dashboard.
///
/// Shows:
/// - Today's sales count and total
/// - New customers registered today
class KpiSummarySection extends ConsumerWidget {
  const KpiSummarySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salesSummaryAsync = ref.watch(todaySalesSummaryProvider);
    final newCustomersAsync = ref.watch(todaysNewCustomersCountProvider);

    const spacing = 12.0;

    final cards = <Widget>[
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
      // New customers today
      Expanded(
        child: newCustomersAsync.when(
          data: (count) => KpiCard(
            title: 'New Customers',
            value: count.toString(),
            icon: Icons.person_add_outlined,
            subtitle: 'Registered today',
            compact: true,
            color: Colors.blue,
          ),
          loading: () => _buildLoadingCard(),
          error: (_, __) => _buildErrorCard(
            context,
            'New Customers',
            Icons.person_add_outlined,
          ),
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: cards),
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
