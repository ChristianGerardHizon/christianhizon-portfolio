import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/widgets/form_feedback.dart';
import '../../../appointments/domain/appointment_schedule.dart';
import '../../../appointments/presentation/controllers/appointments_controller.dart';
import '../../../appointments/presentation/utils/appointment_completion_handler.dart';
import '../../../appointments/presentation/utils/appointment_reschedule_handler.dart';
import '../../../appointments/presentation/widgets/components/appointment_status_chip.dart';
import '../../../appointments/presentation/widgets/dialogs/edit_appointment_dialog.dart';

/// Section displaying today's appointments on the dashboard.
///
/// Shows upcoming and completed appointments for today with quick status change.
class TodayAppointmentsSection extends HookConsumerWidget {
  const TodayAppointmentsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appointmentsAsync = ref.watch(appointmentsControllerProvider);

    // Client-side search state
    final searchController = useTextEditingController();
    final searchQuery = useState('');

    return appointmentsAsync.when(
      data: (appointments) {
        // Filter to today's appointments
        var todayAppointments = appointments.where((a) => a.isToday).toList()
          ..sort((a, b) => a.date.compareTo(b.date));

        // Apply client-side search filter
        if (searchQuery.value.isNotEmpty) {
          final query = searchQuery.value.toLowerCase();
          todayAppointments = todayAppointments.where((a) {
            final patientName = a.patientDisplayName.toLowerCase();
            final ownerName = a.ownerDisplayName.toLowerCase();
            final purpose = (a.purpose ?? '').toLowerCase();
            final treatments = a.treatmentNamesDisplay.toLowerCase();
            return patientName.contains(query) ||
                ownerName.contains(query) ||
                purpose.contains(query) ||
                treatments.contains(query);
          }).toList();
        }

        // Split into upcoming and completed
        final upcoming = todayAppointments
            .where((a) => a.status == AppointmentScheduleStatus.scheduled)
            .toList();
        final completed = todayAppointments
            .where((a) => a.status == AppointmentScheduleStatus.completed)
            .toList();
        final other = todayAppointments
            .where((a) =>
                a.status != AppointmentScheduleStatus.scheduled &&
                a.status != AppointmentScheduleStatus.completed)
            .toList();

        if (appointments.where((a) => a.isToday).isEmpty) {
          return _buildEmptyState(context);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.today,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Today's Appointments",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${todayAppointments.length} total',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: searchController,
                onChanged: (value) => searchQuery.value = value,
                decoration: InputDecoration(
                  hintText: 'Search today\'s appointments...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchQuery.value.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            searchQuery.value = '';
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  isDense: true,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // No results for search
            if (todayAppointments.isEmpty && searchQuery.value.isNotEmpty) ...[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 48,
                        color: theme.colorScheme.outline,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'No matching appointments',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // Upcoming appointments
            if (upcoming.isNotEmpty) ...[
              _buildSubsectionHeader(
                context,
                'Upcoming',
                upcoming.length,
                Icons.schedule,
                theme.colorScheme.primary,
              ),
              const SizedBox(height: 8),
              ...upcoming.map(
                (appointment) => _TodayAppointmentTile(
                  appointment: appointment,
                  onStatusChange: (status) =>
                      _handleStatusChange(context, ref, appointment, status),
                  onEdit: () => _handleEdit(context, ref, appointment),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Completed appointments
            if (completed.isNotEmpty) ...[
              _buildSubsectionHeader(
                context,
                'Completed',
                completed.length,
                Icons.check_circle,
                Colors.green,
              ),
              const SizedBox(height: 8),
              ...completed.map(
                (appointment) => _TodayAppointmentTile(
                  appointment: appointment,
                  onStatusChange: (status) =>
                      _handleStatusChange(context, ref, appointment, status),
                  onEdit: () => _handleEdit(context, ref, appointment),
                ),
              ),
            ],

            // Other statuses (missed, cancelled)
            if (other.isNotEmpty) ...[
              if (upcoming.isNotEmpty || completed.isNotEmpty)
                const SizedBox(height: 16),
              _buildSubsectionHeader(
                context,
                'Other',
                other.length,
                Icons.info_outline,
                theme.colorScheme.outline,
              ),
              const SizedBox(height: 8),
              ...other.map(
                (appointment) => _TodayAppointmentTile(
                  appointment: appointment,
                  onStatusChange: (status) =>
                      _handleStatusChange(context, ref, appointment, status),
                  onEdit: () => _handleEdit(context, ref, appointment),
                ),
              ),
            ],
          ],
        );
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Failed to load appointments',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              FilledButton.tonal(
                onPressed: () =>
                    ref.read(appointmentsControllerProvider.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.event_available,
              size: 64,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No appointments today',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enjoy your free day!',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubsectionHeader(
    BuildContext context,
    String title,
    int count,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleStatusChange(
    BuildContext context,
    WidgetRef ref,
    AppointmentSchedule appointment,
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

    // Special handling for missed appointment with reschedule option
    if (status == AppointmentScheduleStatus.missed) {
      await AppointmentRescheduleHandler.showRescheduleFlowAndMarkMissed(
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
        showSuccessSnackBar(context,
            message: 'Status updated to ${status.name}');
      } else {
        showErrorSnackBar(context, message: 'Failed to update status');
      }
    }
  }

  void _handleEdit(
    BuildContext context,
    WidgetRef ref,
    AppointmentSchedule appointment,
  ) {
    showEditAppointmentDialog(
      context,
      appointment: appointment,
      onSave: (updated) => ref
          .read(appointmentsControllerProvider.notifier)
          .updateAppointment(updated),
    );
  }
}

/// A compact tile for displaying an appointment with quick actions.
class _TodayAppointmentTile extends StatelessWidget {
  const _TodayAppointmentTile({
    required this.appointment,
    this.onStatusChange,
    this.onEdit,
  });

  final AppointmentSchedule appointment;
  final void Function(AppointmentScheduleStatus)? onStatusChange;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final urgencyInfo = _getUrgencyInfo(context);
    final isUrgent = urgencyInfo != null &&
        appointment.status == AppointmentScheduleStatus.scheduled;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: isUrgent ? urgencyInfo.color.withValues(alpha: 0.05) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isUrgent
            ? BorderSide(
                color: urgencyInfo.color.withValues(alpha: 0.3), width: 1)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Time column with urgency indicator
              SizedBox(
                width: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.hasTime
                          ? appointment.displayTime ?? '--:--'
                          : 'All day',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isUrgent
                            ? urgencyInfo.color
                            : theme.colorScheme.primary,
                      ),
                    ),
                    if (urgencyInfo != null &&
                        appointment.status ==
                            AppointmentScheduleStatus.scheduled) ...[
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: urgencyInfo.color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          urgencyInfo.label,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: urgencyInfo.color,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Patient info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.pets,
                          size: 14,
                          color: theme.colorScheme.outline,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            appointment.patientDisplayName,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    if (appointment.hasTreatments) ...[
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.medical_services_outlined,
                            size: 12,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              appointment.treatmentNamesDisplay,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ] else if (appointment.purpose != null &&
                        appointment.purpose!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        appointment.purpose!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              // Status chip with quick change
              _QuickStatusButton(
                status: appointment.status,
                onStatusChange: onStatusChange,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns urgency information based on appointment time.
  _UrgencyInfo? _getUrgencyInfo(BuildContext context) {
    if (!appointment.hasTime) return null;

    final now = DateTime.now();
    final appointmentTime = appointment.date;
    final difference = appointmentTime.difference(now);
    final minutes = difference.inMinutes;

    if (minutes < -30) {
      // More than 30 minutes overdue
      return _UrgencyInfo(
        label: 'Overdue',
        color: Colors.red,
      );
    } else if (minutes < 0) {
      // Just started or slightly overdue
      return _UrgencyInfo(
        label: 'Started',
        color: Colors.orange,
      );
    } else if (minutes <= 5) {
      // Starting now (within 5 minutes)
      return _UrgencyInfo(
        label: 'Now',
        color: Colors.red,
      );
    } else if (minutes <= 15) {
      // Starting soon (within 15 minutes)
      return _UrgencyInfo(
        label: 'In ${minutes}m',
        color: Colors.orange,
      );
    } else if (minutes <= 30) {
      // Coming up (within 30 minutes)
      return _UrgencyInfo(
        label: 'In ${minutes}m',
        color: Colors.amber.shade700,
      );
    } else if (minutes <= 60) {
      // Within an hour
      return _UrgencyInfo(
        label: 'In ${minutes}m',
        color: Theme.of(context).colorScheme.primary,
      );
    }

    return null;
  }
}

/// Helper class for urgency display information.
class _UrgencyInfo {
  const _UrgencyInfo({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;
}

/// Quick status change button with dropdown menu.
class _QuickStatusButton extends StatelessWidget {
  const _QuickStatusButton({
    required this.status,
    this.onStatusChange,
  });

  final AppointmentScheduleStatus status;
  final void Function(AppointmentScheduleStatus)? onStatusChange;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<AppointmentScheduleStatus>(
      tooltip: 'Change status',
      onSelected: onStatusChange,
      position: PopupMenuPosition.under,
      child: AppointmentStatusChip(status: status),
      itemBuilder: (context) => AppointmentScheduleStatus.values
          .map(
            (s) => PopupMenuItem(
              value: s,
              child: Row(
                children: [
                  Icon(
                    _getStatusIcon(s),
                    size: 18,
                    color: _getStatusColor(context, s),
                  ),
                  const SizedBox(width: 8),
                  Text(_getStatusLabel(s)),
                  if (s == status) ...[
                    const Spacer(),
                    Icon(
                      Icons.check,
                      size: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ],
              ),
            ),
          )
          .toList(),
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

  Color _getStatusColor(
      BuildContext context, AppointmentScheduleStatus status) {
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
