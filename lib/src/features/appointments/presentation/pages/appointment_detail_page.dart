import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/routing/routes/appointments.routes.dart';
import '../../../../core/routing/routes/patients.routes.dart';
import '../../../../core/utils/breakpoints.dart';
import '../../../messages/domain/message.dart';
import '../../../messages/presentation/controllers/messages_controller.dart';
import '../../../patients/presentation/widgets/sheets/add_record_sheet.dart';
import '../../domain/appointment_schedule.dart';
import '../controllers/appointments_controller.dart';
import '../controllers/paginated_appointments_controller.dart';
import '../widgets/components/linked_items_section.dart';
import '../widgets/sheets/edit_appointment_sheet.dart';
import '../widgets/sheets/record_treatment_selector_sheet.dart';

/// Comprehensive appointment detail page.
///
/// Shows detailed appointment information including:
/// - Status banner with quick-change
/// - Patient info (tappable to navigate to patient)
/// - Appointment details (date, time, purpose, notes)
/// - Linked records and treatments
/// - Action buttons
class AppointmentDetailPage extends ConsumerWidget {
  const AppointmentDetailPage({
    super.key,
    required this.appointmentId,
  });

  final String appointmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentAsync = ref.watch(appointmentProvider(appointmentId));
    final isTablet = Breakpoints.isTabletOrLarger(context);

    return appointmentAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(
          leading: isTablet
              ? null
              : IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => const AppointmentsRoute().go(context),
                ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('Error loading appointment: ${error.toString()}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.invalidate(appointmentProvider(appointmentId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (appointment) {
        if (appointment == null) {
          return Scaffold(
            appBar: AppBar(
              leading: isTablet
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => const AppointmentsRoute().go(context),
                    ),
            ),
            body: const Center(
              child: Text('Appointment not found'),
            ),
          );
        }

        return _AppointmentDetailContent(
          appointment: appointment,
          isTablet: isTablet,
        );
      },
    );
  }
}

class _AppointmentDetailContent extends HookConsumerWidget {
  const _AppointmentDetailContent({
    required this.appointment,
    required this.isTablet,
  });

  final AppointmentSchedule appointment;
  final bool isTablet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final reminderMessagesAsync =
        ref.watch(messagesByAppointmentProvider(appointment.id));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !isTablet,
        leading: isTablet
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => const AppointmentsRoute().go(context),
              ),
        title: Text(appointment.patientDisplayName),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditSheet(context, ref),
            tooltip: 'Edit',
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showMoreOptions(context, ref),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(appointmentProvider(appointment.id));
          ref.invalidate(messagesByAppointmentProvider(appointment.id));
          await ref.read(appointmentProvider(appointment.id).future);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Banner
              _StatusBanner(
              key: ValueKey('status-banner-${appointment.id}'),
              appointment: appointment,
              onStatusChange: (status) => _updateStatus(context, ref, status),
            ),
            const SizedBox(height: 24),

            // Patient Info Section
            _SectionCard(
              title: 'Patient',
              icon: Icons.pets,
              child: _PatientInfoSection(
                appointment: appointment,
                onTap: () => _navigateToPatient(context),
              ),
            ),
            const SizedBox(height: 16),

            // Appointment Details Section
            _SectionCard(
              title: 'Appointment Details',
              icon: Icons.calendar_today,
              child: _AppointmentDetailsSection(appointment: appointment),
            ),
            const SizedBox(height: 16),

            // Notes Section (if any)
            if (appointment.notes?.isNotEmpty == true) ...[
              _SectionCard(
                title: 'Notes',
                icon: Icons.notes,
                child: Text(
                  appointment.notes!,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Reminder Message Section
            _ReminderMessageSection(
              messagesAsync: reminderMessagesAsync,
            ),

            // Linked Items Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: LinkedItemsSection(
                  patientRecords: appointment.patientRecordsExpanded,
                  treatmentRecords: appointment.treatmentRecordsExpanded,
                  showActions: true,
                  onAddRecordPressed: () {
                    // Show sheet to add a new patient record and link it to this appointment
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      useRootNavigator: true,
                      builder: (context) => AddRecordSheet(
                        patientId: appointment.patient!,
                        appointmentId: appointment.id,
                        onSave: (record) async {
                          // Record is already created by the sheet; just link its ID
                          final updatedIds = <String>[
                            ...appointment.patientRecords,
                            record.id
                          ];
                          final updatedAppointment = appointment.copyWith(
                            patientRecords: updatedIds,
                          );
                          final success = await ref
                              .read(paginatedAppointmentsControllerProvider
                                  .notifier)
                              .updateAppointment(updatedAppointment);
                          if (success) {
                            ref.invalidate(appointmentProvider(appointment.id));
                          }
                          return record;
                        },
                      ),
                    );
                  },
                  onAddTreatmentPressed: () {
                    // TODO: Implement create treatment
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Create treatment functionality coming soon'),
                      ),
                    );
                  },
                  onLinkExistingPressed: () {
                    // Show selector sheet to link existing records/treatments
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      useRootNavigator: true,
                      builder: (context) => RecordTreatmentSelectorSheet(
                        patientId: appointment.patient!,
                        selectedRecordIds: appointment.patientRecords,
                        selectedTreatmentIds: appointment.treatmentRecords,
                        onSave: (recordIds, treatmentIds) async {
                          final updatedAppointment = appointment.copyWith(
                            patientRecords: recordIds,
                            treatmentRecords: treatmentIds,
                          );
                          final success = await ref
                              .read(paginatedAppointmentsControllerProvider
                                  .notifier)
                              .updateAppointment(updatedAppointment);
                          if (success) {
                            ref.invalidate(appointmentProvider(appointment.id));
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions
            _QuickActionsSection(
              appointment: appointment,
              onMarkComplete: () => _updateStatus(
                context,
                ref,
                AppointmentScheduleStatus.completed,
              ),
              onEdit: () => _showEditSheet(context, ref),
              onDelete: () => _confirmDelete(context, ref),
            ),
              const SizedBox(height: 80), // Extra space for FAB
            ],
          ),
        ),
      ),
    );
  }

  void _showEditSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => EditAppointmentSheet(
        appointment: appointment,
        onSave: (updated) async {
          final success = await ref
              .read(paginatedAppointmentsControllerProvider.notifier)
              .updateAppointment(updated);
          if (success) {
            ref.invalidate(appointmentsControllerProvider);
            ref.invalidate(appointmentProvider(appointment.id));
          }
          return success;
        },
      ),
    );
  }

  void _showMoreOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Patient'),
              onTap: () {
                Navigator.pop(context);
                _navigateToPatient(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.print),
              title: const Text('Print'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Print functionality coming soon'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
              title: Text(
                'Delete',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(context, ref);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _updateStatus(
    BuildContext context,
    WidgetRef ref,
    AppointmentScheduleStatus status,
  ) {
    final statusLabel = switch (status) {
      AppointmentScheduleStatus.scheduled => 'Scheduled',
      AppointmentScheduleStatus.completed => 'Completed',
      AppointmentScheduleStatus.missed => 'Missed',
      AppointmentScheduleStatus.cancelled => 'Cancelled',
    };

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Status'),
        content: Text(
          'Are you sure you want to change the status to "$statusLabel"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await ref
                  .read(paginatedAppointmentsControllerProvider.notifier)
                  .updateStatus(appointment.id, status);

              if (success) {
                ref.invalidate(appointmentsControllerProvider);
                ref.invalidate(appointmentProvider(appointment.id));
              }

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success
                        ? 'Status updated to $statusLabel'
                        : 'Failed to update status'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Appointment'),
        content: Text(
          'Are you sure you want to delete the appointment for ${appointment.patientDisplayName}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await ref
                  .read(paginatedAppointmentsControllerProvider.notifier)
                  .deleteAppointment(appointment.id);
              if (success) {
                ref.invalidate(appointmentsControllerProvider);
                // Navigate back to list
                if (context.mounted) {
                  const AppointmentsRoute().go(context);
                }
              }
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success
                        ? 'Appointment deleted'
                        : 'Failed to delete appointment'),
                  ),
                );
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _navigateToPatient(BuildContext context) {
    final patientId = appointment.patient;
    if (patientId != null && patientId.isNotEmpty) {
      PatientDetailRoute(id: patientId).go(context);
    }
  }
}

/// Status banner with color coding and quick-change button.
class _StatusBanner extends StatelessWidget {
  const _StatusBanner({
    super.key,
    required this.appointment,
    required this.onStatusChange,
  });

  final AppointmentSchedule appointment;
  final void Function(AppointmentScheduleStatus) onStatusChange;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (color, bgColor) = _getStatusColors(theme, appointment.status);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            _getStatusIcon(appointment.status),
            color: color,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getStatusLabel(appointment.status),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _getStatusDescription(appointment.status),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: color.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<AppointmentScheduleStatus>(
            icon: Icon(Icons.arrow_drop_down, color: color),
            onSelected: onStatusChange,
            itemBuilder: (context) => AppointmentScheduleStatus.values
                .map(
                  (status) => PopupMenuItem(
                    value: status,
                    child: Row(
                      children: [
                        Icon(
                          _getStatusIcon(status),
                          size: 18,
                          color: _getStatusColors(theme, status).$1,
                        ),
                        const SizedBox(width: 8),
                        Text(_getStatusLabel(status)),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  (Color, Color) _getStatusColors(
      ThemeData theme, AppointmentScheduleStatus status) {
    switch (status) {
      case AppointmentScheduleStatus.scheduled:
        return (theme.colorScheme.primary, theme.colorScheme.primaryContainer);
      case AppointmentScheduleStatus.completed:
        return (Colors.green, Colors.green.withValues(alpha: 0.1));
      case AppointmentScheduleStatus.missed:
        return (Colors.orange, Colors.orange.withValues(alpha: 0.1));
      case AppointmentScheduleStatus.cancelled:
        return (
          theme.colorScheme.outline,
          theme.colorScheme.surfaceContainerHighest
        );
    }
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

  String _getStatusDescription(AppointmentScheduleStatus status) {
    switch (status) {
      case AppointmentScheduleStatus.scheduled:
        return 'This appointment is scheduled and awaiting';
      case AppointmentScheduleStatus.completed:
        return 'This appointment has been completed';
      case AppointmentScheduleStatus.missed:
        return 'Patient did not show up for this appointment';
      case AppointmentScheduleStatus.cancelled:
        return 'This appointment was cancelled';
    }
  }
}

/// Section card container.
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

/// Patient info section.
class _PatientInfoSection extends StatelessWidget {
  const _PatientInfoSection({
    required this.appointment,
    required this.onTap,
  });

  final AppointmentSchedule appointment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: appointment.patient?.isNotEmpty == true ? onTap : null,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Icon(
                Icons.pets,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.patientDisplayName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (appointment.patientExpanded != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      '${appointment.patientExpanded!.species ?? "Unknown"} - ${appointment.patientExpanded!.breed ?? "Unknown breed"}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 14,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          _ownerDisplayText,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (appointment.patient?.isNotEmpty == true)
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
          ],
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
}

/// Appointment details section.
class _AppointmentDetailsSection extends StatelessWidget {
  const _AppointmentDetailsSection({required this.appointment});

  final AppointmentSchedule appointment;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE, MMMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');

    return Column(
      children: [
        _DetailRow(
          icon: Icons.calendar_today,
          label: 'Date',
          value: dateFormat.format(appointment.date),
        ),
        const SizedBox(height: 8),
        _DetailRow(
          icon: Icons.access_time,
          label: 'Time',
          value: appointment.hasTime
              ? timeFormat.format(appointment.date)
              : 'All day',
        ),
        if (appointment.purpose?.isNotEmpty == true) ...[
          const SizedBox(height: 8),
          _DetailRow(
            icon: Icons.description_outlined,
            label: 'Purpose',
            value: appointment.purpose!,
          ),
        ],
      ],
    );
  }
}

/// Detail row widget.
class _DetailRow extends StatelessWidget {
  const _DetailRow({
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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

/// Quick actions section.
class _QuickActionsSection extends StatelessWidget {
  const _QuickActionsSection({
    required this.appointment,
    required this.onMarkComplete,
    required this.onEdit,
    required this.onDelete,
  });

  final AppointmentSchedule appointment;
  final VoidCallback onMarkComplete;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if (appointment.status == AppointmentScheduleStatus.scheduled)
              FilledButton.icon(
                onPressed: onMarkComplete,
                icon: const Icon(Icons.check),
                label: const Text('Mark Complete'),
              ),
            OutlinedButton.icon(
              onPressed: onEdit,
              icon: const Icon(Icons.edit),
              label: const Text('Edit'),
            ),
            OutlinedButton.icon(
              onPressed: onDelete,
              icon: Icon(Icons.delete, color: theme.colorScheme.error),
              label: Text(
                'Delete',
                style: TextStyle(color: theme.colorScheme.error),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: theme.colorScheme.error),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Reminder message section showing scheduled reminder for this appointment.
class _ReminderMessageSection extends StatelessWidget {
  const _ReminderMessageSection({
    required this.messagesAsync,
  });

  final AsyncValue<List<Message>> messagesAsync;

  @override
  Widget build(BuildContext context) {
    return messagesAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (messages) {
        // Filter for reminder messages (those with notes containing 'reminder')
        final reminderMessages = messages
            .where((m) =>
                m.notes?.toLowerCase().contains('reminder') == true ||
                m.content.toLowerCase().contains('reminder'))
            .toList();

        if (reminderMessages.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            _SectionCard(
              title: 'Reminder Message',
              icon: Icons.notifications_active,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: reminderMessages.map((message) {
                  return _ReminderMessageTile(message: message);
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}

/// Individual reminder message tile.
class _ReminderMessageTile extends StatelessWidget {
  const _ReminderMessageTile({required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d, yyyy - h:mm a');

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status and scheduled time row
          Row(
            children: [
              _MessageStatusBadge(status: message.status),
              const Spacer(),
              Icon(
                Icons.schedule,
                size: 14,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                dateFormat.format(message.sendDateTime),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Recipient phone
          Row(
            children: [
              Icon(
                Icons.phone,
                size: 14,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                message.phone,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Message content preview
          Text(
            message.content,
            style: theme.textTheme.bodyMedium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// Message status badge widget.
class _MessageStatusBadge extends StatelessWidget {
  const _MessageStatusBadge({required this.status});

  final MessageStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color, bgColor) = _getStatusInfo(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getStatusIcon(),
            size: 12,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  (String, Color, Color) _getStatusInfo(BuildContext context) {
    final theme = Theme.of(context);
    switch (status) {
      case MessageStatus.pending:
        return (
          'Pending',
          theme.colorScheme.primary,
          theme.colorScheme.primaryContainer,
        );
      case MessageStatus.sent:
        return (
          'Sent',
          Colors.green,
          Colors.green.withValues(alpha: 0.1),
        );
      case MessageStatus.failed:
        return (
          'Failed',
          theme.colorScheme.error,
          theme.colorScheme.errorContainer,
        );
      case MessageStatus.cancelled:
        return (
          'Cancelled',
          theme.colorScheme.outline,
          theme.colorScheme.surfaceContainerHighest,
        );
    }
  }

  IconData _getStatusIcon() {
    switch (status) {
      case MessageStatus.pending:
        return Icons.schedule;
      case MessageStatus.sent:
        return Icons.check_circle;
      case MessageStatus.failed:
        return Icons.error;
      case MessageStatus.cancelled:
        return Icons.cancel;
    }
  }
}
