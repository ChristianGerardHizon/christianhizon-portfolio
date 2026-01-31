import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/widgets/form_feedback.dart';
import '../../../patients/presentation/controllers/patient_provider.dart';
import '../../domain/appointment_schedule.dart';
import '../controllers/appointments_controller.dart';
import '../controllers/paginated_appointments_controller.dart';
import '../widgets/dialogs/create_appointment_dialog.dart';

/// Handles the missed appointment flow with optional rescheduling.
///
/// This utility provides a consistent experience for marking appointments
/// as missed, with the option to create a new rescheduled appointment
/// using the [CreateAppointmentDialog] in reschedule mode.
class AppointmentRescheduleHandler {
  const AppointmentRescheduleHandler._();

  /// Shows a confirm dialog, then either marks as missed or opens the
  /// [CreateAppointmentDialog] in reschedule mode.
  ///
  /// Flow:
  /// 1. Shows confirm dialog: "Cancel" / "Just Mark Missed" / "Reschedule"
  /// 2. If cancelled, does nothing
  /// 3. If "Just Mark Missed", updates status to missed
  /// 4. If "Reschedule", opens [CreateAppointmentDialog] pre-filled with
  ///    original data (read-only), empty date, editable SMS section.
  ///    The onSave callback creates the new appointment and marks old as missed.
  static Future<void> showRescheduleFlowAndMarkMissed({
    required BuildContext context,
    required WidgetRef ref,
    required AppointmentSchedule appointment,
    VoidCallback? onComplete,
  }) async {
    final choice = await _showConfirmDialog(context, appointment);

    if (choice == null || !context.mounted) return;

    if (choice == _RescheduleChoice.justMarkMissed) {
      await _markAsMissed(
        context: context,
        ref: ref,
        appointment: appointment,
      );
      onComplete?.call();
      return;
    }

    // Reschedule: resolve patient, then open CreateAppointmentDialog
    final patient = appointment.patientExpanded ??
        await ref.read(patientProvider(appointment.patient!).future);

    if (patient == null) {
      if (context.mounted) {
        showErrorSnackBar(context, message: 'Could not load patient data');
      }
      return;
    }

    if (!context.mounted) return;

    showCreateAppointmentDialog(
      context,
      initialPatient: patient,
      rescheduleFrom: appointment,
      onSave: (newAppointment) async {
        // Create the new appointment
        final created = await ref
            .read(paginatedAppointmentsControllerProvider.notifier)
            .createAppointmentAndReturn(newAppointment);

        if (created == null) return null;

        // Mark old appointment as missed
        final missedSuccess = await ref
            .read(paginatedAppointmentsControllerProvider.notifier)
            .updateStatus(appointment.id, AppointmentScheduleStatus.missed);

        if (!missedSuccess && context.mounted) {
          showWarningSnackBar(context,
              message:
                  'New appointment created but failed to mark old one as missed');
        }

        ref.invalidate(appointmentsControllerProvider);
        ref.invalidate(appointmentProvider(appointment.id));

        onComplete?.call();

        return created;
      },
    );
  }

  /// Shows the initial confirm dialog with three choices.
  static Future<_RescheduleChoice?> _showConfirmDialog(
    BuildContext context,
    AppointmentSchedule appointment,
  ) {
    final theme = Theme.of(context);
    return showDialog<_RescheduleChoice>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Missed Appointment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.pets,
                          size: 20,
                          color: theme.colorScheme.onSurfaceVariant),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          appointment.patientDisplayName,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 20,
                          color: theme.colorScheme.onSurfaceVariant),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          appointment.displayDate,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Would you like to reschedule this appointment?',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          OutlinedButton(
            onPressed: () =>
                Navigator.pop(ctx, _RescheduleChoice.justMarkMissed),
            child: const Text('Just Mark Missed'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(ctx, _RescheduleChoice.reschedule),
            child: const Text('Reschedule'),
          ),
        ],
      ),
    );
  }

  /// Marks an appointment as missed.
  static Future<void> _markAsMissed({
    required BuildContext context,
    required WidgetRef ref,
    required AppointmentSchedule appointment,
  }) async {
    final success = await ref
        .read(paginatedAppointmentsControllerProvider.notifier)
        .updateStatus(appointment.id, AppointmentScheduleStatus.missed);

    if (!success) {
      if (context.mounted) {
        showErrorSnackBar(context,
            message: 'Failed to mark appointment as missed');
      }
      return;
    }

    ref.invalidate(appointmentsControllerProvider);
    ref.invalidate(appointmentProvider(appointment.id));

    if (context.mounted) {
      showSuccessSnackBar(context,
          message: 'Appointment marked as missed');
    }
  }
}

enum _RescheduleChoice { justMarkMissed, reschedule }
