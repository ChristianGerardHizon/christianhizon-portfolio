import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/appointments.routes.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../../patients/domain/patient_record.dart';
import '../../../patients/presentation/controllers/patient_records_controller.dart';
import '../../domain/appointment_schedule.dart';
import '../controllers/appointments_controller.dart';
import '../controllers/paginated_appointments_controller.dart';
import '../utils/appointment_reschedule_handler.dart';
import 'appointment_list_panel.dart';
import 'empty_appointment_detail_state.dart';
import 'dialogs/create_appointment_dialog.dart';
import 'dialogs/edit_appointment_dialog.dart';

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
              onReschedule: (appointment) =>
                  AppointmentRescheduleHandler.showRescheduleFlow(
                context: context,
                ref: ref,
                appointment: appointment,
              ),
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
    showCreateAppointmentDialog(
      context,
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
    );
  }

  void _showEditAppointmentSheet(
    BuildContext context,
    WidgetRef ref,
    AppointmentSchedule appointment,
  ) {
    showEditAppointmentDialog(
      context,
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
  ) async {
    // Special handling for completing an appointment
    if (status == AppointmentScheduleStatus.completed) {
      // Fetch the appointment to check if it has a treatment type
      final appointment = await ref.read(appointmentProvider(id).future);
      if (appointment != null && context.mounted) {
        _showCompletionDialog(context, ref, appointment);
      }
      return;
    }

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

  /// Shows a dialog when completing an appointment, asking if user wants to
  /// create a treatment record.
  void _showCompletionDialog(
    BuildContext context,
    WidgetRef ref,
    AppointmentSchedule appointment,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Complete Appointment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Would you like to create a treatment record for this appointment?',
            ),
            if (appointment.hasTreatments) ...[
              const SizedBox(height: 12),
              ...appointment.patientTreatmentName.map((name) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(dialogContext).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.medical_services_outlined,
                        size: 20,
                        color: Theme.of(dialogContext).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          name,
                          style: Theme.of(dialogContext).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          OutlinedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await _completeAppointment(context, ref, appointment, createRecord: false);
            },
            child: const Text('Complete Only'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await _completeAppointment(context, ref, appointment, createRecord: true);
            },
            child: const Text('Create Record'),
          ),
        ],
      ),
    );
  }

  /// Completes the appointment and optionally creates a treatment record.
  Future<void> _completeAppointment(
    BuildContext context,
    WidgetRef ref,
    AppointmentSchedule appointment, {
    required bool createRecord,
  }) async {
    // Update appointment status first
    final success = await ref
        .read(paginatedAppointmentsControllerProvider.notifier)
        .updateStatus(appointment.id, AppointmentScheduleStatus.completed);

    if (!success) {
      if (context.mounted) {
        showErrorSnackBar(context, message: 'Failed to complete appointment');
      }
      return;
    }

    // Invalidate to refresh the appointment
    ref.invalidate(appointmentsControllerProvider);

    // Create treatment record if requested
    if (createRecord && appointment.patient != null) {
      final patientRecord = PatientRecord(
        id: '', // Will be assigned by PocketBase
        patientId: appointment.patient!,
        date: DateTime.now(),
        diagnosis: appointment.purpose ?? '',
        weight: '',
        temperature: '',
        treatment: appointment.hasTreatments ? appointment.treatmentNamesDisplay : null,
        notes: appointment.notes,
        appointment: appointment.id,
      );

      final createdRecord = await ref
          .read(patientRecordsControllerProvider(appointment.patient!).notifier)
          .createRecordAndReturn(patientRecord);

      if (createdRecord != null) {
        // Link the record to the appointment
        final updatedAppointment = appointment.copyWith(
          status: AppointmentScheduleStatus.completed,
          patientRecords: [...appointment.patientRecords, createdRecord.id],
        );
        await ref
            .read(paginatedAppointmentsControllerProvider.notifier)
            .updateAppointment(updatedAppointment);
      }

      if (context.mounted) {
        if (createdRecord != null) {
          showSuccessSnackBar(
            context,
            message: 'Appointment completed and treatment record created',
          );
        } else {
          showWarningSnackBar(
            context,
            message: 'Appointment completed, but failed to create treatment record',
          );
        }
      }
    } else {
      if (context.mounted) {
        showSuccessSnackBar(context, message: 'Appointment marked as completed');
      }
    }
  }
}
