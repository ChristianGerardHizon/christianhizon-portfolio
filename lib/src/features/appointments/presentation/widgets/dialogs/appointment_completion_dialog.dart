import 'package:flutter/material.dart';

import '../../../domain/appointment_schedule.dart';

/// Result of the appointment completion dialog.
enum CompletionDialogResult {
  /// User cancelled the dialog.
  cancel,

  /// User chose to complete the appointment without creating a record.
  completeOnly,

  /// User chose to create a treatment record for the appointment.
  createRecord,
}

/// Shows a dialog asking the user how they want to complete an appointment.
///
/// Returns [CompletionDialogResult.cancel] if the user cancels,
/// [CompletionDialogResult.completeOnly] if they just want to mark it complete,
/// or [CompletionDialogResult.createRecord] if they want to create a treatment record.
Future<CompletionDialogResult> showAppointmentCompletionDialog(
  BuildContext context,
  AppointmentSchedule appointment,
) async {
  final result = await showDialog<CompletionDialogResult>(
    context: context,
    builder: (dialogContext) => _AppointmentCompletionDialog(
      appointment: appointment,
    ),
  );

  return result ?? CompletionDialogResult.cancel;
}

class _AppointmentCompletionDialog extends StatelessWidget {
  const _AppointmentCompletionDialog({
    required this.appointment,
  });

  final AppointmentSchedule appointment;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.medical_services_outlined,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      appointment.patientTreatmentName!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
          onPressed: () =>
              Navigator.pop(context, CompletionDialogResult.cancel),
          child: const Text('Cancel'),
        ),
        OutlinedButton(
          onPressed: () =>
              Navigator.pop(context, CompletionDialogResult.completeOnly),
          child: const Text('Complete Only'),
        ),
        FilledButton(
          onPressed: () =>
              Navigator.pop(context, CompletionDialogResult.createRecord),
          child: const Text('Create Record'),
        ),
      ],
    );
  }
}
