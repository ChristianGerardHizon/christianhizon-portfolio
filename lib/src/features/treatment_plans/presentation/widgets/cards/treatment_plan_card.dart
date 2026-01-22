import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/treatment_plan.dart';
import '../../../domain/treatment_plan_item.dart';
import '../../../domain/treatment_plan_status.dart';
import 'treatment_plan_item_tile.dart';

/// Card displaying a treatment plan with progress and timeline.
class TreatmentPlanCard extends HookConsumerWidget {
  const TreatmentPlanCard({
    super.key,
    required this.plan,
    this.onEdit,
    this.onCancel,
    this.onComplete,
    this.onPutOnHold,
    this.onReactivate,
    this.onMarkItemCompleted,
    this.onMarkItemSkipped,
    this.onRescheduleItem,
    this.onBookAppointment,
    this.onViewAppointment,
    this.expanded = false,
  });

  final TreatmentPlan plan;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;
  final VoidCallback? onComplete;
  final VoidCallback? onPutOnHold;
  final VoidCallback? onReactivate;
  final void Function(TreatmentPlanItem item)? onMarkItemCompleted;
  final void Function(TreatmentPlanItem item)? onMarkItemSkipped;
  final void Function(TreatmentPlanItem item)? onRescheduleItem;
  final void Function(TreatmentPlanItem item)? onBookAppointment;
  final void Function(TreatmentPlanItem item)? onViewAppointment;
  final bool expanded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status indicator bar
          _buildStatusBar(context),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                _buildHeader(context),

                const SizedBox(height: 12),

                // Progress section
                _buildProgressSection(context),

                // Overdue warning
                if (plan.hasOverdueItems && plan.isActive) ...[
                  const SizedBox(height: 12),
                  _buildOverdueWarning(context),
                ],

                // Items timeline
                if (expanded && plan.items.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 12),
                  _buildItemsTimeline(context, ref),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBar(BuildContext context) {
    final theme = Theme.of(context);
    final color = _getStatusColor(theme);

    return Container(
      height: 4,
      color: color,
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d, yyyy');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Treatment icon
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: theme.colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.medical_services,
            color: theme.colorScheme.tertiary,
          ),
        ),
        const SizedBox(width: 12),

        // Title and meta
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plan.displayTitle,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _buildStatusChip(context),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        dateFormat.format(plan.startDate),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        // Menu
        _buildMenu(context),
      ],
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    final theme = Theme.of(context);
    final color = _getStatusColor(theme);
    final label = plan.status.displayName;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getStatusColor(ThemeData theme) {
    switch (plan.status) {
      case TreatmentPlanStatus.active:
        return theme.colorScheme.primary;
      case TreatmentPlanStatus.completed:
        return Colors.green;
      case TreatmentPlanStatus.cancelled:
        return theme.colorScheme.error;
      case TreatmentPlanStatus.onHold:
        return Colors.orange;
    }
  }

  Widget _buildMenu(BuildContext context) {
    // Don't show menu for completed/cancelled plans (past plans)
    if (plan.status == TreatmentPlanStatus.completed ||
        plan.status == TreatmentPlanStatus.cancelled) {
      return const SizedBox.shrink();
    }

    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'edit':
            onEdit?.call();
          case 'cancel':
            onCancel?.call();
          case 'complete':
            onComplete?.call();
          case 'hold':
            onPutOnHold?.call();
          case 'reactivate':
            onReactivate?.call();
        }
      },
      itemBuilder: (context) => [
        if (plan.isActive) ...[
          const PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit, size: 20),
                SizedBox(width: 8),
                Text('Edit'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'complete',
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 20),
                SizedBox(width: 8),
                Text('Mark Completed'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'hold',
            child: Row(
              children: [
                Icon(Icons.pause_circle, size: 20),
                SizedBox(width: 8),
                Text('Put on Hold'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'cancel',
            child: Row(
              children: [
                Icon(Icons.cancel, size: 20),
                SizedBox(width: 8),
                Text('Cancel'),
              ],
            ),
          ),
        ],
        if (plan.status == TreatmentPlanStatus.onHold)
          const PopupMenuItem(
            value: 'reactivate',
            child: Row(
              children: [
                Icon(Icons.play_circle, size: 20),
                SizedBox(width: 8),
                Text('Reactivate'),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              plan.progressDisplay,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: plan.progressPercentage,
            minHeight: 8,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(
              plan.hasOverdueItems
                  ? theme.colorScheme.error
                  : theme.colorScheme.primary,
            ),
          ),
        ),
        if (plan.notes != null && plan.notes!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            plan.notes!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Widget _buildOverdueWarning(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 18,
            color: theme.colorScheme.error,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '${plan.overdueCount} session${plan.overdueCount > 1 ? 's' : ''} overdue',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsTimeline(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Sort items by sequence
    final sortedItems = List<TreatmentPlanItem>.from(plan.items)
      ..sort((a, b) => a.sequence.compareTo(b.sequence));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sessions',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sortedItems.length,
          separatorBuilder: (_, __) => const SizedBox(height: 4),
          itemBuilder: (context, index) {
            final item = sortedItems[index];
            return TreatmentPlanItemTile(
              item: item,
              compact: true,
              onMarkCompleted: onMarkItemCompleted != null
                  ? () => onMarkItemCompleted!(item)
                  : null,
              onMarkSkipped: onMarkItemSkipped != null
                  ? () => onMarkItemSkipped!(item)
                  : null,
              onReschedule: onRescheduleItem != null
                  ? () => onRescheduleItem!(item)
                  : null,
              onBookAppointment: onBookAppointment != null
                  ? () => onBookAppointment!(item)
                  : null,
              onViewAppointment: item.appointmentId != null &&
                  item.appointmentId!.isNotEmpty &&
                  onViewAppointment != null
                  ? () => onViewAppointment!(item)
                  : null,
            );
          },
        ),
      ],
    );
  }
}
