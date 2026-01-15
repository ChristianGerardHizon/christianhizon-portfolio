import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/appointments.routes.dart';
import '../../domain/appointment_schedule.dart';
import '../controllers/appointments_controller.dart';
import '../controllers/paginated_appointments_controller.dart';
import '../widgets/appointment_list_panel.dart';
import '../widgets/sheets/create_appointment_sheet.dart';
import '../widgets/sheets/edit_appointment_sheet.dart';

/// Mobile-only appointments list page.
///
/// Used on mobile when the shell passes through directly.
class AppointmentsListPage extends ConsumerWidget {
  const AppointmentsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paginatedAsync = ref.watch(paginatedAppointmentsControllerProvider);
    final paginatedController =
        ref.read(paginatedAppointmentsControllerProvider.notifier);

    return paginatedAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('Error: ${error.toString()}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => paginatedController.refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (paginatedState) => AppointmentListPanel(
        paginatedState: paginatedState,
        selectedId: null, // No selection on mobile
        onAppointmentTap: (appointment) {
          // Navigate to detail page on mobile (full screen)
          AppointmentDetailRoute(id: appointment.id).push(context);
        },
        onRefresh: () => paginatedController.refresh(),
        onLoadMore: () => paginatedController.loadMore(),
        onEdit: (appointment) =>
            _showEditAppointmentSheet(context, ref, appointment),
        onDelete: (appointment) => _confirmDelete(context, ref, appointment),
        onStatusChange: (id, status) => _updateStatus(context, ref, id, status),
        onCreateAppointment: () => _showCreateAppointmentSheet(context, ref),
      ),
    );
  }

  void _showCreateAppointmentSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => CreateAppointmentSheet(
        onSave: (appointment) async {
          final created = await ref
              .read(paginatedAppointmentsControllerProvider.notifier)
              .createAppointmentAndReturn(appointment);
          if (created != null) {
            ref.invalidate(appointmentsControllerProvider);
          }
          return created;
        },
      ),
    );
  }

  void _showEditAppointmentSheet(
    BuildContext context,
    WidgetRef ref,
    AppointmentSchedule appointment,
  ) {
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
          }
          return success;
        },
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    AppointmentSchedule appointment,
  ) {
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

  void _updateStatus(
    BuildContext context,
    WidgetRef ref,
    String id,
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
                  .updateStatus(id, status);

              if (success) {
                ref.invalidate(appointmentsControllerProvider);
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
}
