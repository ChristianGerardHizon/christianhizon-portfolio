import 'package:flutter/material.dart';

import '../../../domain/appointment_schedule.dart';
import '../components/appointment_status_chip.dart';
import '../components/linked_items_section.dart';

/// Card widget displaying an appointment with actions.
class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.appointment,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onStatusChange,
    this.showPatientInfo = true,
  });

  final AppointmentSchedule appointment;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final void Function(AppointmentScheduleStatus)? onStatusChange;
  final bool showPatientInfo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with date/time and status
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      appointment.displayDate,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Linked items indicator
                  if (appointment.hasLinkedItems) ...[
                    LinkedItemsIndicator(
                      recordCount: appointment.patientRecords.length,
                      treatmentCount: appointment.treatmentRecords.length,
                    ),
                    const SizedBox(width: 8),
                  ],
                  AppointmentStatusChip(status: appointment.status),
                  if (onEdit != null || onDelete != null || onStatusChange != null)
                    _buildPopupMenu(context),
                ],
              ),

              const SizedBox(height: 12),

              // Patient info (if shown)
              if (showPatientInfo) ...[
                Row(
                  children: [
                    Icon(
                      Icons.pets,
                      size: 16,
                      color: theme.colorScheme.outline,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        appointment.patientDisplayName,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 16,
                      color: theme.colorScheme.outline,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _ownerDisplayText,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],

              // Purpose
              if (appointment.purpose != null && appointment.purpose!.isNotEmpty) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.description_outlined,
                      size: 16,
                      color: theme.colorScheme.outline,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        appointment.purpose!,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],

              // Notes (if any)
              if (appointment.notes != null && appointment.notes!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.notes,
                      size: 16,
                      color: theme.colorScheme.outline,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        appointment.notes!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String get _ownerDisplayText {
    final owner = appointment.ownerDisplayName;
    final contact = appointment.ownerContactDisplay;
    if (owner.isEmpty) return 'No owner info';
    if (contact.isEmpty) return owner;
    return '$owner - $contact';
  }

  Widget _buildPopupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => [
        if (onEdit != null)
          const PopupMenuItem(
            value: 'edit',
            child: ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit'),
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
          ),
        if (onStatusChange != null) ...[
          const PopupMenuDivider(),
          const PopupMenuItem(
            enabled: false,
            child: Text('Change Status'),
          ),
          ...AppointmentScheduleStatus.values.map(
            (status) => PopupMenuItem(
              value: 'status_${status.name}',
              child: ListTile(
                leading: Icon(
                  _getStatusIcon(status),
                  color: _getStatusColor(context, status),
                ),
                title: Text(_getStatusLabel(status)),
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ),
          ),
        ],
        if (onDelete != null) ...[
          const PopupMenuDivider(),
          const PopupMenuItem(
            value: 'delete',
            child: ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text('Delete', style: TextStyle(color: Colors.red)),
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
          ),
        ],
      ],
      onSelected: (value) {
        if (value == 'edit') {
          onEdit?.call();
        } else if (value == 'delete') {
          onDelete?.call();
        } else if (value.startsWith('status_')) {
          final statusName = value.substring(7);
          final status = AppointmentScheduleStatus.values.firstWhere(
            (s) => s.name == statusName,
          );
          onStatusChange?.call(status);
        }
      },
    );
  }

  IconData _getStatusIcon(AppointmentScheduleStatus status) {
    switch (status) {
      case AppointmentScheduleStatus.scheduled:
        return Icons.schedule;
      case AppointmentScheduleStatus.completed:
        return Icons.check_circle;
      case AppointmentScheduleStatus.missed:
        return Icons.warning;
      case AppointmentScheduleStatus.cancelled:
        return Icons.cancel;
    }
  }

  Color _getStatusColor(BuildContext context, AppointmentScheduleStatus status) {
    final theme = Theme.of(context);
    switch (status) {
      case AppointmentScheduleStatus.scheduled:
        return theme.colorScheme.primary;
      case AppointmentScheduleStatus.completed:
        return Colors.green;
      case AppointmentScheduleStatus.missed:
        return Colors.orange;
      case AppointmentScheduleStatus.cancelled:
        return theme.colorScheme.outline;
    }
  }

  String _getStatusLabel(AppointmentScheduleStatus status) {
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
