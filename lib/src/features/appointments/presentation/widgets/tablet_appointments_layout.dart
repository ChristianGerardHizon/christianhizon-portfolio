import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/appointments.routes.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../domain/appointment_schedule.dart';
import '../controllers/appointments_controller.dart';
import '../controllers/paginated_appointments_controller.dart';
import 'appointment_list_panel.dart';
import 'empty_appointment_detail_state.dart';
import 'sheets/create_appointment_sheet.dart';
import 'sheets/edit_appointment_sheet.dart';

/// Two-pane tablet layout for appointments.
///
/// Left pane: Appointment list with search
/// Right pane: Appointment detail from router or empty state
class TabletAppointmentsLayout extends ConsumerWidget {
  const TabletAppointmentsLayout({
    super.key,
    required this.detailChild,
  });

  /// The detail panel content from the router.
  final Widget detailChild;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paginatedAsync = ref.watch(paginatedAppointmentsControllerProvider);
    final paginatedController =
        ref.read(paginatedAppointmentsControllerProvider.notifier);

    // Get selected appointment ID from current route
    final routerState = GoRouterState.of(context);
    final selectedAppointmentId = routerState.pathParameters['id'];

    return paginatedAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
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
      data: (paginatedState) => Row(
        children: [
          // List panel
          SizedBox(
            width: 400,
            child: AppointmentListPanel(
              paginatedState: paginatedState,
              selectedId: selectedAppointmentId,
              onAppointmentTap: (appointment) {
                // Navigate using the route - this updates the URL and detail panel
                AppointmentDetailRoute(id: appointment.id).go(context);
              },
              onRefresh: () => paginatedController.refresh(),
              onLoadMore: () => paginatedController.loadMore(),
              onEdit: (appointment) =>
                  _showEditAppointmentSheet(context, ref, appointment),
              onDelete: (appointment) =>
                  _confirmDelete(context, ref, appointment),
              onStatusChange: (id, status) =>
                  _updateStatus(context, ref, id, status),
              onCreateAppointment: () =>
                  _showCreateAppointmentSheet(context, ref),
            ),
          ),
          const VerticalDivider(width: 1),
          // Detail panel from router
          Expanded(
            child: selectedAppointmentId != null
                ? detailChild
                : const EmptyAppointmentDetailState(),
          ),
        ],
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
          // Create in paginated controller (for list view)
          final created = await ref
              .read(paginatedAppointmentsControllerProvider.notifier)
              .createAppointmentAndReturn(appointment);
          // Also refresh the non-paginated controller (for calendar view)
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
                if (success) {
                  showSuccessSnackBar(context, message: 'Appointment deleted');
                } else {
                  showErrorSnackBar(context, message: 'Failed to delete appointment');
                }
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
                if (success) {
                  showSuccessSnackBar(context, message: 'Status updated to $statusLabel');
                } else {
                  showErrorSnackBar(context, message: 'Failed to update status');
                }
              }
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
