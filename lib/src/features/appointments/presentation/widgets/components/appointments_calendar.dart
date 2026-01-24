import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../core/routing/routes/appointments.routes.dart';
import '../../../domain/appointment_schedule.dart';
import '../../controllers/appointments_controller.dart';
import '../cards/appointment_card.dart';
import '../sheets/edit_appointment_sheet.dart';

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
              .read(appointmentsControllerProvider.notifier)
              .updateAppointment(updated);
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
                  .read(appointmentsControllerProvider.notifier)
                  .deleteAppointment(appointment.id);
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
                  .read(appointmentsControllerProvider.notifier)
                  .updateStatus(id, status);

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
