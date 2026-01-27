import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../core/routing/routes/appointments.routes.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../../patients/domain/patient_record.dart';
import '../../../../patients/presentation/controllers/patient_records_controller.dart';
import '../../../domain/appointment_schedule.dart';
import '../../controllers/appointments_controller.dart';
import '../cards/appointment_card.dart';
import '../dialogs/edit_appointment_dialog.dart';

/// Calendar view for appointments using table_calendar.
class AppointmentsCalendar extends HookConsumerWidget {
  const AppointmentsCalendar({
    super.key,
    required this.appointments,
    required this.onCreateAppointment,
  });

  final List<AppointmentSchedule> appointments;
  final VoidCallback onCreateAppointment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final focusedDay = useState(DateTime.now());
    final selectedDay = useState<DateTime?>(DateTime.now());
    final calendarFormat = useState(CalendarFormat.week);

    // Get appointments for a specific day
    List<AppointmentSchedule> getAppointmentsForDay(DateTime day) {
      return appointments.where((appointment) {
        return isSameDay(appointment.date, day);
      }).toList();
    }

    // Get selected day's appointments
    final selectedAppointments = selectedDay.value != null
        ? getAppointmentsForDay(selectedDay.value!)
        : <AppointmentSchedule>[];

    return Column(
      children: [
        // Calendar
        TableCalendar<AppointmentSchedule>(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: focusedDay.value,
          selectedDayPredicate: (day) => isSameDay(selectedDay.value, day),
          calendarFormat: calendarFormat.value,
          eventLoader: getAppointmentsForDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            selectedDecoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            todayTextStyle: TextStyle(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          headerStyle: HeaderStyle(
            formatButtonVisible: true,
            titleCentered: true,
            formatButtonShowsNext: false,
            formatButtonDecoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            formatButtonTextStyle: TextStyle(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          onDaySelected: (selected, focused) {
            selectedDay.value = selected;
            focusedDay.value = focused;
          },
          onFormatChanged: (format) {
            calendarFormat.value = format;
          },
          onPageChanged: (focused) {
            focusedDay.value = focused;
          },
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              if (events.isEmpty) return null;
              return Positioned(
                bottom: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${events.length}',
                    style: TextStyle(
                      color: theme.colorScheme.onTertiary,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const Divider(height: 1),

        // Selected day's appointments
        Expanded(
          child: selectedAppointments.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event_available,
                        size: 48,
                        color: theme.colorScheme.outline,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'No appointments',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: onCreateAppointment,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Appointment'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: selectedAppointments.length,
                  itemBuilder: (context, index) {
                    final appointment = selectedAppointments[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: AppointmentCard(
                        appointment: appointment,
                        onTap: () {
                          AppointmentDetailRoute(id: appointment.id).go(context);
                        },
                        onEdit: () => _showEditAppointmentSheet(
                          context,
                          ref,
                          appointment,
                        ),
                        onDelete: () => _confirmDelete(
                          context,
                          ref,
                          appointment,
                        ),
                        onStatusChange: (status) => _updateStatus(
                          context,
                          ref,
                          appointment.id,
                          status,
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
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
            .read(appointmentsControllerProvider.notifier)
            .updateAppointment(updated);
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
                  .read(appointmentsControllerProvider.notifier)
                  .deleteAppointment(appointment.id);
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
                  .read(appointmentsControllerProvider.notifier)
                  .updateStatus(id, status);

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
        .read(appointmentsControllerProvider.notifier)
        .updateStatus(appointment.id, AppointmentScheduleStatus.completed);

    if (!success) {
      if (context.mounted) {
        showErrorSnackBar(context, message: 'Failed to complete appointment');
      }
      return;
    }

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
            .read(appointmentsControllerProvider.notifier)
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
