import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../appointments/domain/appointment_schedule.dart';
import '../../../appointments/presentation/controllers/appointments_controller.dart';
import '../../../appointments/presentation/widgets/components/appointment_status_chip.dart';
import '../../../appointments/presentation/widgets/sheets/edit_appointment_sheet.dart';

/// Section displaying today's appointments on the dashboard.
///
/// Shows upcoming and completed appointments for today with quick status change.
class TodayAppointmentsSection extends ConsumerWidget {
  const TodayAppointmentsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appointmentsAsync = ref.watch(appointmentsControllerProvider);

    return appointmentsAsync.when(
      data: (appointments) {
        // Filter to today's appointments
        final todayAppointments = appointments
            .where((a) => a.isToday)
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));

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

        if (todayAppointments.isEmpty) {
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
            const SizedBox(height: 16),

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
                      _handleStatusChange(context, ref, appointment.id, status),
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
                      _handleStatusChange(context, ref, appointment.id, status),
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
                      _handleStatusChange(context, ref, appointment.id, status),
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
    String id,
    AppointmentScheduleStatus status,
  ) async {
    final success = await ref
        .read(appointmentsControllerProvider.notifier)
        .updateStatus(id, status);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'Status updated to ${status.name}'
                : 'Failed to update status',
          ),
        ),
      );
    }
  }

  void _handleEdit(
    BuildContext context,
    WidgetRef ref,
    AppointmentSchedule appointment,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      builder: (context) => EditAppointmentSheet(
        appointment: appointment,
        onSave: (updated) => ref
            .read(appointmentsControllerProvider.notifier)
            .updateAppointment(updated),
      ),
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

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Time column
              SizedBox(
                width: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.hasTime
                          ? appointment.displayTime ?? '--:--'
                          : 'All day',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

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
                    if (appointment.purpose != null &&
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
