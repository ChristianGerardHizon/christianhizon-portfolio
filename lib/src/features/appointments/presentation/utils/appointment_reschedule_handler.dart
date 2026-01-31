import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/widgets/form_feedback.dart';
import '../../../messages/domain/message.dart';
import '../../../messages/presentation/controllers/messages_controller.dart';
import '../../../patients/presentation/controllers/patient_provider.dart';
import '../../domain/appointment_schedule.dart';
import '../controllers/appointments_controller.dart';
import '../controllers/paginated_appointments_controller.dart';
import '../widgets/dialogs/reschedule_appointment_dialog.dart';

/// Handles standalone appointment rescheduling.
///
/// This utility updates an existing appointment's date (instead of creating
/// a new one), resets its status to scheduled, cancels pending SMS reminders,
/// and optionally creates a new SMS reminder for the new date.
class AppointmentRescheduleHandler {
  const AppointmentRescheduleHandler._();

  /// Shows the reschedule dialog and updates the appointment in-place.
  ///
  /// Flow:
  /// 1. Resolves patient data for the SMS section
  /// 2. Opens [RescheduleAppointmentDialog]
  /// 3. Updates the existing appointment's date + resets status to scheduled
  /// 4. Cancels any existing pending SMS reminders
  /// 5. Creates a new SMS reminder if enabled
  /// 6. Invalidates providers and calls [onComplete]
  static Future<void> showRescheduleFlow({
    required BuildContext context,
    required WidgetRef ref,
    required AppointmentSchedule appointment,
    VoidCallback? onComplete,
  }) async {
    // Resolve patient for SMS section
    final patient = appointment.patientExpanded ??
        await ref.read(patientProvider(appointment.patient!).future);

    if (!context.mounted) return;

    final result = await showRescheduleAppointmentDialog(
      context,
      appointment: appointment,
      patient: patient,
    );

    if (result == null || !context.mounted) return;

    // Update the existing appointment with new date and reset status
    final updated = appointment.copyWith(
      date: result.newDate,
      hasTime: result.hasTime,
      status: AppointmentScheduleStatus.scheduled,
    );

    final success = await ref
        .read(paginatedAppointmentsControllerProvider.notifier)
        .updateAppointment(updated);

    if (!success) {
      if (context.mounted) {
        showErrorSnackBar(context,
            message: 'Failed to reschedule appointment');
      }
      return;
    }

    // Cancel existing pending SMS reminders for this appointment
    await _cancelPendingReminders(ref, appointment.id);

    // Create new SMS reminder if enabled
    if (result.sendReminder &&
        result.reminderMessage != null &&
        result.reminderMessage!.isNotEmpty &&
        patient?.contactNumber != null &&
        patient!.contactNumber!.isNotEmpty) {
      final message = Message(
        id: '',
        phone: patient.contactNumber!,
        content: result.reminderMessage!,
        sendDateTime: result.reminderDateTime ??
            DateTime(
              result.newDate.year,
              result.newDate.month,
              result.newDate.day - 1,
              9,
              0,
            ),
        patient: patient.id,
        appointment: appointment.id,
        notes: 'Appointment reminder (rescheduled)',
      );

      await ref
          .read(messagesControllerProvider.notifier)
          .createMessage(message);
    }

    // Invalidate providers to refresh data
    ref.invalidate(appointmentsControllerProvider);
    ref.invalidate(appointmentProvider(appointment.id));
    ref.invalidate(messagesByAppointmentProvider(appointment.id));

    if (context.mounted) {
      showSuccessSnackBar(
        context,
        message: result.sendReminder
            ? 'Appointment rescheduled with reminder'
            : 'Appointment rescheduled successfully',
      );
    }

    onComplete?.call();
  }

  /// Cancels all pending SMS reminders for the given appointment.
  static Future<void> _cancelPendingReminders(
    WidgetRef ref,
    String appointmentId,
  ) async {
    try {
      final messages = await ref
          .read(messagesByAppointmentProvider(appointmentId).future);

      final unsentMessages = messages.where(
          (m) => m.status == MessageStatus.pending || m.status == MessageStatus.failed);

      for (final message in unsentMessages) {
        await ref
            .read(messagesControllerProvider.notifier)
            .cancelMessage(message.id);
      }
    } catch (_) {
      // Non-critical: if we can't cancel old reminders, still proceed
    }
  }
}
