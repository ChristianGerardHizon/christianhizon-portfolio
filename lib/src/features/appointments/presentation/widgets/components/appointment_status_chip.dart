import 'package:flutter/material.dart';

import '../../../domain/appointment_schedule.dart';

/// A chip widget displaying the appointment status with appropriate colors.
class AppointmentStatusChip extends StatelessWidget {
  const AppointmentStatusChip({
    super.key,
    required this.status,
    this.compact = false,
  });

  final AppointmentScheduleStatus status;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 12,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: _getBackgroundColor(theme),
        borderRadius: BorderRadius.circular(compact ? 4 : 8),
      ),
      child: Text(
        _getLabel(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: _getTextColor(theme),
          fontWeight: FontWeight.w600,
          fontSize: compact ? 10 : 12,
        ),
      ),
    );
  }

  Color _getBackgroundColor(ThemeData theme) {
    switch (status) {
      case AppointmentScheduleStatus.scheduled:
        return theme.colorScheme.primaryContainer;
      case AppointmentScheduleStatus.completed:
        return Colors.green.shade100;
      case AppointmentScheduleStatus.missed:
        return Colors.orange.shade100;
      case AppointmentScheduleStatus.cancelled:
        return theme.colorScheme.surfaceContainerHighest;
    }
  }

  Color _getTextColor(ThemeData theme) {
    switch (status) {
      case AppointmentScheduleStatus.scheduled:
        return theme.colorScheme.onPrimaryContainer;
      case AppointmentScheduleStatus.completed:
        return Colors.green.shade800;
      case AppointmentScheduleStatus.missed:
        return Colors.orange.shade800;
      case AppointmentScheduleStatus.cancelled:
        return theme.colorScheme.onSurfaceVariant;
    }
  }

  String _getLabel() {
    switch (status) {
      case AppointmentScheduleStatus.scheduled:
        return 'Scheduled';
      case AppointmentScheduleStatus.completed:
        return 'Completed';
      case AppointmentScheduleStatus.missed:
        return 'Missed';
      case AppointmentScheduleStatus.cancelled:
        return 'Cancelled';
    }
  }
}
