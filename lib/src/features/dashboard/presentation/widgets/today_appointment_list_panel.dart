import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/widgets/form_feedback.dart';
import '../../../appointments/domain/appointment_schedule.dart';
import '../../../appointments/presentation/controllers/appointments_controller.dart';
import '../../../appointments/presentation/utils/appointment_completion_handler.dart';
import '../../../appointments/presentation/utils/appointment_reschedule_handler.dart';
import '../../../appointments/presentation/widgets/dialogs/edit_appointment_dialog.dart';

/// List panel showing today's appointments for the dashboard.
///
/// Used in the tablet two-pane layout.
class TodayAppointmentListPanel extends HookConsumerWidget {
  const TodayAppointmentListPanel({
    super.key,
    this.selectedId,
    this.onAppointmentTap,
    this.onStatusChange,
  });

  final String? selectedId;
  final ValueChanged<AppointmentSchedule>? onAppointmentTap;
  final void Function(String id, AppointmentScheduleStatus status)?
      onStatusChange;

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

        final totalToday = todayAppointments.length;

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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              color: theme.colorScheme.surfaceContainerHighest,
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
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.all(8.0),
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

            // Appointments list
            Expanded(
              child: todayAppointments.isEmpty
                  ? totalToday == 0
                      ? _buildEmptyState(context)
                      : _buildNoSearchResults(context)
                  : RefreshIndicator(
                      onRefresh: () => ref
                          .read(appointmentsControllerProvider.notifier)
                          .refresh(),
                      child: ListView(
                        padding: const EdgeInsets.only(bottom: 16),
                        children: [
                          // Upcoming section
                          if (upcoming.isNotEmpty) ...[
                            _buildSubsectionHeader(
                              context,
                              'Upcoming',
                              upcoming.length,
                              Icons.schedule,
                              theme.colorScheme.primary,
                            ),
                            ...upcoming.map((appointment) => _AppointmentTile(
                                  appointment: appointment,
                                  isSelected: appointment.id == selectedId,
                                  onTap: () =>
                                      onAppointmentTap?.call(appointment),
                                  onStatusChange: (status) =>
                                      _handleStatusChange(
                                          context, ref, appointment, status),
                                  onEdit: () =>
                                      _handleEdit(context, ref, appointment),
                                  onReschedule: () =>
                                      _handleReschedule(
                                          context, ref, appointment),
                                )),
                          ],

                          // Completed section
                          if (completed.isNotEmpty) ...[
                            _buildSubsectionHeader(
                              context,
                              'Completed',
                              completed.length,
                              Icons.check_circle,
                              Colors.green,
                            ),
                            ...completed.map((appointment) => _AppointmentTile(
                                  appointment: appointment,
                                  isSelected: appointment.id == selectedId,
                                  onTap: () =>
                                      onAppointmentTap?.call(appointment),
                                  onStatusChange: (status) =>
                                      _handleStatusChange(
                                          context, ref, appointment, status),
                                  onEdit: () =>
                                      _handleEdit(context, ref, appointment),
                                  onReschedule: () =>
                                      _handleReschedule(
                                          context, ref, appointment),
                                )),
                          ],

                          // Other section
                          if (other.isNotEmpty) ...[
                            _buildSubsectionHeader(
                              context,
                              'Other',
                              other.length,
                              Icons.info_outline,
                              theme.colorScheme.outline,
                            ),
                            ...other.map((appointment) => _AppointmentTile(
                                  appointment: appointment,
                                  isSelected: appointment.id == selectedId,
                                  onTap: () =>
                                      onAppointmentTap?.call(appointment),
                                  onStatusChange: (status) =>
                                      _handleStatusChange(
                                          context, ref, appointment, status),
                                  onEdit: () =>
                                      _handleEdit(context, ref, appointment),
                                  onReschedule: () =>
                                      _handleReschedule(
                                          context, ref, appointment),
                                )),
                          ],
                        ],
                      ),
                    ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text('Failed to load appointments'),
            const SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: () =>
                  ref.read(appointmentsControllerProvider.notifier).refresh(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoSearchResults(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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

  void _handleReschedule(
    BuildContext context,
    WidgetRef ref,
    AppointmentSchedule appointment,
  ) {
    AppointmentRescheduleHandler.showRescheduleFlow(
      context: context,
      ref: ref,
      appointment: appointment,
    );
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

/// A compact tile for displaying an appointment with selection state.
class _AppointmentTile extends StatelessWidget {
  const _AppointmentTile({
    required this.appointment,
    required this.isSelected,
    this.onTap,
    this.onStatusChange,
    this.onEdit,
    this.onReschedule,
  });

  final AppointmentSchedule appointment;
  final bool isSelected;
  final VoidCallback? onTap;
  final void Function(AppointmentScheduleStatus)? onStatusChange;
  final VoidCallback? onEdit;
  final VoidCallback? onReschedule;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected
            ? BorderSide(color: theme.colorScheme.primary, width: 2)
            : BorderSide.none,
      ),
      color: isSelected
          ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
          : null,
      child: InkWell(
        onTap: onTap,
        onLongPress: onEdit,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Time column
              SizedBox(
                width: 60,
                child: Text(
                  appointment.hasTime
                      ? appointment.displayTime ?? '--:--'
                      : 'All day',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
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
                    ] else if (appointment.purpose?.isNotEmpty == true) ...[
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

              // More actions popup with reschedule + status change
              _TileActionsPopup(
                appointment: appointment,
                onReschedule: onReschedule,
                onStatusChange: onStatusChange,
              ),
            ],
          ),
        ),
      ),
    );
  }

}

/// Popup menu for appointment tile with reschedule + status change.
class _TileActionsPopup extends StatelessWidget {
  const _TileActionsPopup({
    required this.appointment,
    this.onReschedule,
    this.onStatusChange,
  });

  final AppointmentSchedule appointment;
  final VoidCallback? onReschedule;
  final void Function(AppointmentScheduleStatus)? onStatusChange;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, size: 20),
      tooltip: 'More actions',
      position: PopupMenuPosition.under,
      itemBuilder: (context) => [
        // Reschedule (non-completed only)
        if (onReschedule != null &&
            appointment.status != AppointmentScheduleStatus.completed)
          const PopupMenuItem(
            value: 'reschedule',
            child: ListTile(
              leading: Icon(Icons.event_repeat),
              title: Text('Reschedule'),
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
          ),
        // Change Status section
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
                trailing: status == appointment.status
                    ? Icon(
                        Icons.check,
                        size: 18,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ),
          ),
        ],
      ],
      onSelected: (value) {
        if (value == 'reschedule') {
          onReschedule?.call();
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
