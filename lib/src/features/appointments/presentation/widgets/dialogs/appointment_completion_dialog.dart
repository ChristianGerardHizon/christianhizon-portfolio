import 'package:flutter/material.dart';

import '../../../domain/appointment_schedule.dart';

/// Shows a confirmation dialog for completing an appointment.
///
/// Informs the user whether treatment records will be auto-created based on
/// the appointment's [autoCreateRecord] setting and whether it has treatments.
///
/// Returns `true` if the user confirms, `false` if cancelled.
Future<bool> showAppointmentCompletionDialog(
  BuildContext context,
  AppointmentSchedule appointment,
) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => _AppointmentCompletionDialog(
      appointment: appointment,
    ),
  );

  return result ?? false;
}

class _AppointmentCompletionDialog extends StatelessWidget {
  const _AppointmentCompletionDialog({
    required this.appointment,
  });

  final AppointmentSchedule appointment;

  @override
  Widget build(BuildContext context) {
    final willCreateRecords =
        appointment.autoCreateRecord && appointment.hasTreatments;

    return AlertDialog(
      title: const Text('Complete Appointment'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Are you sure you want to complete this appointment?'),
          const SizedBox(height: 12),
          if (willCreateRecords) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.auto_fix_high,
                    size: 20,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Treatment records will be created automatically.',
                      style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (appointment.patientTreatmentName.isNotEmpty) ...[
              const SizedBox(height: 8),
              ...appointment.patientTreatmentName.map((name) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
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
                              name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ] else ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'No treatment records will be generated.',
                      style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onSurfaceVariant,
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
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Complete'),
        ),
      ],
    );
  }
}
