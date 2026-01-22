import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/treatment_plan_item.dart';
import '../../../domain/treatment_plan_item_status.dart';

/// A tile displaying a single treatment plan item (session).
class TreatmentPlanItemTile extends StatelessWidget {
  const TreatmentPlanItemTile({
    super.key,
    required this.item,
    this.onMarkCompleted,
    this.onMarkSkipped,
    this.onReschedule,
    this.onBookAppointment,
    this.onViewAppointment,
    this.compact = false,
  });

  final TreatmentPlanItem item;
  final VoidCallback? onMarkCompleted;
  final VoidCallback? onMarkSkipped;
  final VoidCallback? onReschedule;
  final VoidCallback? onBookAppointment;
  final VoidCallback? onViewAppointment;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOverdue = item.isOverdue;

    return Container(
      decoration: BoxDecoration(
        color: isOverdue
            ? theme.colorScheme.errorContainer.withValues(alpha: 0.3)
            : null,
        borderRadius: BorderRadius.circular(8),
        border: isOverdue
            ? Border.all(
                color: theme.colorScheme.error.withValues(alpha: 0.5),
              )
            : null,
      ),
      child: ListTile(
        contentPadding: compact
            ? const EdgeInsets.symmetric(horizontal: 8)
            : const EdgeInsets.symmetric(horizontal: 16),
        leading: _buildSequenceBadge(context),
        title: _buildTitle(context),
        subtitle: _buildSubtitle(context),
        trailing: _buildTrailing(context),
      ),
    );
  }

  Widget _buildSequenceBadge(BuildContext context) {
    final theme = Theme.of(context);
    final isCompleted = item.status == TreatmentPlanItemStatus.completed;
    final isOverdue = item.isOverdue;

    Color backgroundColor;
    Color foregroundColor;
    IconData? icon;

    if (isCompleted) {
      backgroundColor = theme.colorScheme.primaryContainer;
      foregroundColor = theme.colorScheme.onPrimaryContainer;
      icon = Icons.check;
    } else if (item.status == TreatmentPlanItemStatus.skipped) {
      backgroundColor = theme.colorScheme.surfaceContainerHighest;
      foregroundColor = theme.colorScheme.onSurfaceVariant;
      icon = Icons.skip_next;
    } else if (item.status == TreatmentPlanItemStatus.missed) {
      backgroundColor = theme.colorScheme.errorContainer;
      foregroundColor = theme.colorScheme.onErrorContainer;
      icon = Icons.close;
    } else if (isOverdue) {
      backgroundColor = theme.colorScheme.errorContainer;
      foregroundColor = theme.colorScheme.onErrorContainer;
      icon = Icons.warning_amber_rounded;
    } else if (item.status == TreatmentPlanItemStatus.booked) {
      backgroundColor = theme.colorScheme.secondaryContainer;
      foregroundColor = theme.colorScheme.onSecondaryContainer;
      icon = Icons.event;
    } else {
      backgroundColor = theme.colorScheme.surfaceContainerHighest;
      foregroundColor = theme.colorScheme.onSurfaceVariant;
    }

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: icon != null
            ? Icon(icon, size: 20, color: foregroundColor)
            : Text(
                '${item.sequence}',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('EEE, MMM d, yyyy');

    return Text(
      dateFormat.format(item.expectedDate),
      style: theme.textTheme.bodyLarge?.copyWith(
        fontWeight: item.isPending ? FontWeight.w500 : FontWeight.normal,
        decoration:
            item.status == TreatmentPlanItemStatus.skipped ||
            item.status == TreatmentPlanItemStatus.missed
                ? TextDecoration.lineThrough
                : null,
        color: item.isFinalized
            ? theme.colorScheme.onSurfaceVariant
            : theme.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    final theme = Theme.of(context);
    final parts = <String>[];

    // Status
    parts.add(item.statusDisplay);

    // Overdue indicator
    if (item.isOverdue) {
      parts.add('OVERDUE');
    }

    // Linked appointment
    if (item.appointmentId != null && item.appointmentId!.isNotEmpty) {
      parts.add('Appointment linked');
    }

    // Completed date
    if (item.completedDate != null) {
      final completedFormat = DateFormat('MMM d');
      parts.add('Done: ${completedFormat.format(item.completedDate!)}');
    }

    return Text(
      parts.join(' • '),
      style: theme.textTheme.bodySmall?.copyWith(
        color: item.isOverdue
            ? theme.colorScheme.error
            : theme.colorScheme.onSurfaceVariant,
        fontWeight: item.isOverdue ? FontWeight.w500 : FontWeight.normal,
      ),
    );
  }

  Widget? _buildTrailing(BuildContext context) {
    // If item is finalized or in the past, don't show actions
    if (item.isFinalized || item.isPast) return null;

    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        switch (value) {
          case 'complete':
            onMarkCompleted?.call();
          case 'skip':
            onMarkSkipped?.call();
          case 'reschedule':
            onReschedule?.call();
          case 'book':
            onBookAppointment?.call();
          case 'view_appointment':
            onViewAppointment?.call();
        }
      },
      itemBuilder: (context) => [
        if (item.status == TreatmentPlanItemStatus.scheduled) ...[
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
            value: 'book',
            child: Row(
              children: [
                Icon(Icons.event, size: 20),
                SizedBox(width: 8),
                Text('Book Appointment'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'reschedule',
            child: Row(
              children: [
                Icon(Icons.schedule, size: 20),
                SizedBox(width: 8),
                Text('Reschedule'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'skip',
            child: Row(
              children: [
                Icon(Icons.skip_next, size: 20),
                SizedBox(width: 8),
                Text('Skip'),
              ],
            ),
          ),
        ],
        if (item.status == TreatmentPlanItemStatus.booked) ...[
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
          if (item.appointmentId != null && item.appointmentId!.isNotEmpty)
            const PopupMenuItem(
              value: 'view_appointment',
              child: Row(
                children: [
                  Icon(Icons.event, size: 20),
                  SizedBox(width: 8),
                  Text('View Appointment'),
                ],
              ),
            ),
          const PopupMenuItem(
            value: 'reschedule',
            child: Row(
              children: [
                Icon(Icons.schedule, size: 20),
                SizedBox(width: 8),
                Text('Reschedule'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'skip',
            child: Row(
              children: [
                Icon(Icons.skip_next, size: 20),
                SizedBox(width: 8),
                Text('Skip'),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
