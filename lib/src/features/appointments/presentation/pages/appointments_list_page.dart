import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/appointments.routes.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../../patients/domain/patient_record.dart';
import '../../../patients/presentation/controllers/patient_records_controller.dart';
import '../../domain/appointment_schedule.dart';
import '../controllers/appointments_controller.dart';
import '../controllers/paginated_appointments_controller.dart';
import '../widgets/appointment_list_panel.dart';
import '../widgets/dialogs/create_appointment_dialog.dart';
import '../widgets/dialogs/edit_appointment_dialog.dart';

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
    showCreateAppointmentDialog(
      context,
      onSave: (appointment) async {
        final created = await ref
            .read(paginatedAppointmentsControllerProvider.notifier)
            .createAppointmentAndReturn(appointment);
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
            if (appointment.patientTreatmentName != null) ...[
              const SizedBox(height: 12),
              Container(
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
                        appointment.patientTreatmentName!,
                        style: Theme.of(dialogContext).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
        treatment: appointment.patientTreatmentName,
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
