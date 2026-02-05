import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/routing/routes/sales_history.routes.dart';
import '../../../../core/utils/breakpoints.dart';
import '../../../pos/domain/order_status.dart';
import '../../../pos/domain/sale.dart';
import '../controllers/kanban_sales_controller.dart';

/// Kanban-style board showing all sales grouped by order status.
///
/// On tablet/desktop: Shows columns side-by-side in a horizontal scrollable row.
/// On mobile: Shows columns in a vertical scrollable list.
class KanbanBoardSection extends ConsumerWidget {
  const KanbanBoardSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kanbanAsync = ref.watch(kanbanSalesProvider);

    return kanbanAsync.when(
      data: (data) => _KanbanBoard(data: data),
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: _LoadingState(),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _KanbanBoard extends StatelessWidget {
  const _KanbanBoard({required this.data});

  final KanbanSalesData data;

  static const _statuses = OrderStatus.values;

  @override
  Widget build(BuildContext context) {
    final isTablet = Breakpoints.isTabletOrLarger(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            children: [
              Icon(
                Icons.view_kanban_outlined,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Order Board',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => const SalesHistoryRoute().go(context),
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Columns
          if (isTablet)
            _TabletKanbanLayout(data: data, statuses: _statuses)
          else
            _MobileKanbanLayout(data: data, statuses: _statuses),
        ],
      ),
    );
  }
}

/// Tablet: Horizontal row of columns, each taking equal width.
class _TabletKanbanLayout extends StatelessWidget {
  const _TabletKanbanLayout({
    required this.data,
    required this.statuses,
  });

  final KanbanSalesData data;
  final List<OrderStatus> statuses;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < statuses.length; i++) ...[
            if (i > 0) const SizedBox(width: 12),
            Expanded(
              child: _KanbanColumn(
                status: statuses[i],
                sales: data.salesForStatus(statuses[i]),
                isScrollable: true,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Mobile: Vertical stack of collapsed columns.
class _MobileKanbanLayout extends StatelessWidget {
  const _MobileKanbanLayout({
    required this.data,
    required this.statuses,
  });

  final KanbanSalesData data;
  final List<OrderStatus> statuses;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < statuses.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          _KanbanColumn(
            status: statuses[i],
            sales: data.salesForStatus(statuses[i]),
            isScrollable: false,
            maxItems: 5,
          ),
        ],
      ],
    );
  }
}

/// A single kanban column for one order status.
class _KanbanColumn extends StatelessWidget {
  const _KanbanColumn({
    required this.status,
    required this.sales,
    required this.isScrollable,
    this.maxItems,
  });

  final OrderStatus status;
  final List<Sale> sales;
  final bool isScrollable;
  final int? maxItems;

  Color _statusColor() => switch (status) {
        OrderStatus.pending => Colors.orange,
        OrderStatus.processing => Colors.blue,
        OrderStatus.ready => Colors.green,
        OrderStatus.pickedUp => Colors.grey,
      };

  IconData _statusIcon() => switch (status) {
        OrderStatus.pending => Icons.schedule,
        OrderStatus.processing => Icons.autorenew,
        OrderStatus.ready => Icons.check_circle_outline,
        OrderStatus.pickedUp => Icons.local_shipping_outlined,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _statusColor();
    final displayedSales =
        maxItems != null ? sales.take(maxItems!).toList() : sales;
    final remainingCount = sales.length - displayedSales.length;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Column header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(11),
              ),
            ),
            child: Row(
              children: [
                Icon(_statusIcon(), color: color, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    status.displayName,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${sales.length}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Cards list
          if (sales.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'No orders',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            )
          else if (isScrollable)
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: displayedSales.length,
                separatorBuilder: (_, __) => const SizedBox(height: 6),
                itemBuilder: (context, index) =>
                    _SaleCard(sale: displayedSales[index]),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  for (int i = 0; i < displayedSales.length; i++) ...[
                    if (i > 0) const SizedBox(height: 6),
                    _SaleCard(sale: displayedSales[i]),
                  ],
                  if (remainingCount > 0) ...[
                    const SizedBox(height: 6),
                    Text(
                      '+ $remainingCount more',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Individual sale card within a kanban column.
class _SaleCard extends StatelessWidget {
  const _SaleCard({required this.sale});

  final Sale sale;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyFormat =
        NumberFormat.currency(symbol: '₱', decimalDigits: 2);

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: InkWell(
        onTap: () => SaleDetailRoute(id: sale.id).go(context),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Receipt number & payment badge
              Row(
                children: [
                  Expanded(
                    child: Text(
                      sale.receiptNumber,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _PaymentBadge(isPaid: sale.isPaid),
                ],
              ),
              const SizedBox(height: 4),
              // Customer name
              if (sale.customerDisplay != null)
                Text(
                  sale.customerDisplay!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 6),
              // Amount & time
              Row(
                children: [
                  Text(
                    currencyFormat.format(sale.totalAmount),
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  if (sale.created != null)
                    Text(
                      _formatTime(sale.created!),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final local = dateTime.toLocal();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(local.year, local.month, local.day);

    if (date == today) {
      return DateFormat('h:mm a').format(local);
    } else if (date == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    }
    return DateFormat('MMM d').format(local);
  }
}

class _PaymentBadge extends StatelessWidget {
  const _PaymentBadge({required this.isPaid});

  final bool isPaid;

  @override
  Widget build(BuildContext context) {
    final color = isPaid ? Colors.green : Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        isPaid ? 'Paid' : 'Unpaid',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16),
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
}
