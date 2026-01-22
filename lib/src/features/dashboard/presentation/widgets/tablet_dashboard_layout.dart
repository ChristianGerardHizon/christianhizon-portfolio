import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../appointments/domain/appointment_schedule.dart';
import '../../../appointments/presentation/controllers/appointments_controller.dart';
import 'appointment_quick_summary.dart';
import 'inventory_alerts_section.dart';
import 'kpi_summary_section.dart';
import 'quick_actions_section.dart';
import 'today_appointment_list_panel.dart';
import 'upcoming_treatment_plans_section.dart';

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
        // Left pane: Quick actions at top, appointments list fills remaining space
        SizedBox(
          width: 420,
          child: Column(
            children: [
              // Quick Actions Section
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: QuickActionsSection(
                  onShowOverview: () => selectedAppointmentId.value = null,
                ),
              ),
              const SizedBox(height: 8),
              // Today's Appointments (fills remaining space)
              Expanded(
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
            ],
          ),
        ),
        const VerticalDivider(width: 1),
        // Right pane: Appointment quick summary or dashboard overview
        Expanded(
          child: selectedAppointment != null
              ? AppointmentQuickSummary(appointment: selectedAppointment)
              : const _DashboardOverviewPane(),
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

/// Dashboard overview pane shown when no appointment is selected.
///
/// Displays KPIs, inventory alerts and upcoming treatment plans.
class _DashboardOverviewPane extends StatelessWidget {
  const _DashboardOverviewPane();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.dashboard,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Dashboard Overview',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Select an appointment from the list to view details',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
          const SizedBox(height: 24),

          // KPI Summary Section
          const KpiSummarySection(),
          const SizedBox(height: 24),

          // Inventory Alerts Section
          const InventoryAlertsSection(),
          const SizedBox(height: 24),

          // Upcoming Treatment Plans Section
          const UpcomingTreatmentPlansSection(),
        ],
      ),
    );
  }
}
