import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/routing/routes/appointments.routes.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../../../core/routing/routes/patients.routes.dart';
import '../../../appointments/domain/appointment_schedule.dart';
import '../../../appointments/presentation/controllers/appointments_controller.dart';
import '../../../appointments/presentation/utils/appointment_completion_handler.dart';
import '../../../appointments/presentation/widgets/components/appointment_status_chip.dart';
import '../../../appointments/presentation/widgets/dialogs/edit_appointment_dialog.dart';

/// Quick summary view for an appointment on the dashboard.
///
/// Shows essential information without full detail page navigation.
class AppointmentQuickSummary extends ConsumerWidget {
  const AppointmentQuickSummary({
    super.key,
    required this.appointment,
  });

  final AppointmentSchedule appointment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Appointment Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditSheet(context, ref),
            tooltip: 'Edit',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status and time header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppointmentStatusChip(status: appointment.status),
                        const Spacer(),
                        _buildRelativeTimeIndicator(context),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _formatDateTime(),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Patient quick info
            Card(
              child: InkWell(
                onTap: () => _navigateToPatient(context),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
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
              ),
            ),
            const SizedBox(height: 16),

            // Purpose
            if (appointment.purpose?.isNotEmpty == true)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.description_outlined,
                            size: 18,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Purpose',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        appointment.purpose!,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 24),

            // Quick actions
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
                    onPressed: () => _updateStatus(
                      context,
                      ref,
                      AppointmentScheduleStatus.completed,
                    ),
                    icon: const Icon(Icons.check),
                    label: const Text('Mark Complete'),
                  ),
                OutlinedButton.icon(
                  onPressed: () => _showEditSheet(context, ref),
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _navigateToFullDetails(context),
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('View Full Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelativeTimeIndicator(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final appointmentTime = appointment.date;

    String text;
    Color color;
    IconData icon;

    if (appointment.status == AppointmentScheduleStatus.completed) {
      text = 'Done';
      color = Colors.green;
      icon = Icons.check_circle;
    } else if (appointmentTime.isBefore(now)) {
      final diff = now.difference(appointmentTime);
      if (diff.inMinutes < 60) {
        text = '${diff.inMinutes}m ago';
      } else {
        text = '${diff.inHours}h ago';
      }
      color = Colors.orange;
      icon = Icons.history;
    } else {
      final diff = appointmentTime.difference(now);
      if (diff.inMinutes < 60) {
        text = 'In ${diff.inMinutes}m';
      } else {
        text = 'In ${diff.inHours}h';
      }
      color = theme.colorScheme.primary;
      icon = Icons.schedule;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime() {
    final dateFormat = DateFormat('EEEE, MMMM d');
    final timeFormat = DateFormat('h:mm a');

    final dateStr = dateFormat.format(appointment.date);
    final timeStr = appointment.hasTime
        ? timeFormat.format(appointment.date)
        : 'All day';

    return '$dateStr at $timeStr';
  }

  String get _ownerDisplayText {
    final owner = appointment.ownerDisplayName;
    final contact = appointment.ownerContactDisplay;
    if (owner.isEmpty) return 'No owner info';
    if (contact.isEmpty) return owner;
    return '$owner - $contact';
  }

  void _showEditSheet(BuildContext context, WidgetRef ref) {
    showEditAppointmentDialog(
      context,
      appointment: appointment,
      onSave: (updated) => ref
          .read(appointmentsControllerProvider.notifier)
          .updateAppointment(updated),
    );
  }

  Future<void> _updateStatus(
    BuildContext context,
    WidgetRef ref,
    AppointmentScheduleStatus status,
  ) async {
    // Special handling for completing an appointment
    if (status == AppointmentScheduleStatus.completed) {
      await AppointmentCompletionHandler.showCompletionFlowAndComplete(
        context: context,
        ref: ref,
        appointment: appointment,
      );
      return;
    }

    // For other status changes, update directly
    final success = await ref
        .read(appointmentsControllerProvider.notifier)
        .updateStatus(appointment.id, status);

    if (context.mounted) {
      if (success) {
        showSuccessSnackBar(context, message: 'Status updated to ${status.name}');
      } else {
        showErrorSnackBar(context, message: 'Failed to update status');
      }
    }
  }

  void _navigateToPatient(BuildContext context) {
    final patientId = appointment.patient;
    if (patientId != null && patientId.isNotEmpty) {
      PatientDetailRoute(id: patientId).go(context);
    }
  }

  void _navigateToFullDetails(BuildContext context) {
    AppointmentDetailRoute(id: appointment.id).go(context);
  }
}

/// Empty state for when no appointment is selected.
class EmptyDashboardDetailState extends StatelessWidget {
  const EmptyDashboardDetailState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.touch_app_outlined,
            size: 64,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'Select an appointment',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap on an appointment to see details',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
