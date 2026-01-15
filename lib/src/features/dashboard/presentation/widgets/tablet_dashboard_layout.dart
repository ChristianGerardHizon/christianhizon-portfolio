import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../appointments/domain/appointment_schedule.dart';
import '../../../appointments/presentation/controllers/appointments_controller.dart';
import 'appointment_quick_summary.dart';
import 'today_appointment_list_panel.dart';

/// Two-pane tablet layout for the dashboard.
///
/// Left pane: Today's appointments list
/// Right pane: Appointment quick summary or empty state
class TabletDashboardLayout extends HookConsumerWidget {
  const TabletDashboardLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Local state for selected appointment (not URL-based)
    final selectedAppointmentId = useState<String?>(null);

    // Get the appointment data for the selected item
    final appointmentsAsync = ref.watch(appointmentsControllerProvider);

    // Find the selected appointment
    final selectedAppointment = appointmentsAsync.whenOrNull(
      data: (appointments) {
        if (selectedAppointmentId.value == null) return null;
        try {
          return appointments.firstWhere(
            (a) => a.id == selectedAppointmentId.value,
          );
        } catch (_) {
          return null;
        }
      },
    );

    return Row(
      children: [
        // Left pane: Today's appointments list
        SizedBox(
          width: 400,
          child: TodayAppointmentListPanel(
            selectedId: selectedAppointmentId.value,
            onAppointmentTap: (appointment) {
              selectedAppointmentId.value = appointment.id;
            },
            onStatusChange: (id, status) async {
              await _handleStatusChange(context, ref, id, status);
              // If status changed to something other than scheduled/completed,
              // the item might disappear from the list, so clear selection
              if (status != AppointmentScheduleStatus.scheduled &&
                  status != AppointmentScheduleStatus.completed) {
                if (selectedAppointmentId.value == id) {
                  selectedAppointmentId.value = null;
                }
              }
            },
          ),
        ),
        const VerticalDivider(width: 1),
        // Right pane: Appointment quick summary or empty state
        Expanded(
          child: selectedAppointment != null
              ? AppointmentQuickSummary(appointment: selectedAppointment)
              : const EmptyDashboardDetailState(),
        ),
      ],
    );
  }

  Future<void> _handleStatusChange(
    BuildContext context,
    WidgetRef ref,
    String id,
    AppointmentScheduleStatus status,
  ) async {
    final success = await ref
        .read(appointmentsControllerProvider.notifier)
        .updateStatus(id, status);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'Status updated to ${status.name}'
                : 'Failed to update status',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
