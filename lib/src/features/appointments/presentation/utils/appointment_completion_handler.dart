import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/widgets/form_feedback.dart';
import '../../../patients/domain/patient_record.dart';
import '../../../patients/presentation/controllers/patient_records_controller.dart';
import '../../domain/appointment_schedule.dart';
import '../controllers/appointments_controller.dart';
import '../controllers/paginated_appointments_controller.dart';
import '../widgets/dialogs/appointment_completion_dialog.dart';

/// Handles appointment completion flow including optional treatment record creation.
///
/// This utility provides a consistent completion experience across different
/// parts of the app (dashboard, appointment detail page, etc.).
class AppointmentCompletionHandler {
  const AppointmentCompletionHandler._();

  /// Shows the completion dialog and handles the user's choice.
  ///
  /// This is the main entry point for completing an appointment.
  /// It shows the dialog, then processes the user's choice accordingly.
  ///
  /// [context] - The build context for showing dialogs and snackbars.
  /// [ref] - The Riverpod ref for reading providers.
  /// [appointment] - The appointment to complete.
  /// [onComplete] - Optional callback called after successful completion.
  static Future<void> showCompletionFlowAndComplete({
    required BuildContext context,
    required WidgetRef ref,
    required AppointmentSchedule appointment,
    VoidCallback? onComplete,
  }) async {
    final result = await showAppointmentCompletionDialog(context, appointment);

    if (result == CompletionDialogResult.cancel) {
      return;
    }

    if (!context.mounted) return;

    await completeAppointment(
      context: context,
      ref: ref,
      appointment: appointment,
      createRecord: result == CompletionDialogResult.createRecord,
      onComplete: onComplete,
    );
  }

  /// Completes an appointment and optionally creates a treatment record.
  ///
  /// [context] - The build context for showing snackbars.
  /// [ref] - The Riverpod ref for reading providers.
  /// [appointment] - The appointment to complete.
  /// [createRecord] - Whether to create a treatment record.
  /// [onComplete] - Optional callback called after successful completion.
  static Future<void> completeAppointment({
    required BuildContext context,
    required WidgetRef ref,
    required AppointmentSchedule appointment,
    required bool createRecord,
    VoidCallback? onComplete,
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

    // Invalidate providers to refresh the appointment data
    ref.invalidate(appointmentsControllerProvider);
    ref.invalidate(appointmentProvider(appointment.id));

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
          patientRecords: [...appointment.patientRecords, createdRecord.id],
        );
        await ref
            .read(paginatedAppointmentsControllerProvider.notifier)
            .updateAppointment(updatedAppointment);

        // Refresh the appointment to show the new record
        ref.invalidate(appointmentProvider(appointment.id));
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
            message:
                'Appointment completed, but failed to create treatment record',
          );
        }
      }
    } else {
      if (context.mounted) {
        showSuccessSnackBar(context,
            message: 'Appointment marked as completed');
      }
    }

    // Call the optional onComplete callback
    onComplete?.call();
  }
}
