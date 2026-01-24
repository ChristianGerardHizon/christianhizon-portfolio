import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/foundation/paginated_state.dart';
import '../../../../../core/hooks/use_infinite_scroll.dart';
import '../../../../../core/routing/routes/appointments.routes.dart';
import '../../../../../core/widgets/end_of_list_indicator.dart';
import '../../../../patients/domain/patient.dart';
import '../../../domain/appointment_schedule.dart';
import '../../controllers/patient_appointments_controller.dart';
import '../cards/appointment_card.dart';
import '../sheets/create_appointment_sheet.dart';
import '../sheets/edit_appointment_sheet.dart';

/// Appointments tab showing appointments for a specific patient.
class PatientAppointmentsTab extends HookConsumerWidget {
  const PatientAppointmentsTab({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsAsync =
        ref.watch(patientAppointmentsControllerProvider(patient.id));
    final theme = Theme.of(context);

    return appointmentsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Failed to load appointments',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: () => ref
                  .read(patientAppointmentsControllerProvider(patient.id).notifier)
                  .refresh(),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (paginatedState) {
        if (paginatedState.items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 64,
                  color: theme.colorScheme.outline,
                ),
                const SizedBox(height: 16),
                Text(
                  'No appointments yet',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
                const SizedBox(height: 8),
                FilledButton.icon(
                  onPressed: () => _showAddAppointmentSheet(context, ref),
                  icon: const Icon(Icons.add),
                  label: const Text('Add First Appointment'),
                ),
              ],
            ),
          );
        }

        return _PatientAppointmentsList(
          patient: patient,
          paginatedState: paginatedState,
          onRefresh: () => ref
              .read(patientAppointmentsControllerProvider(patient.id).notifier)
              .refresh(),
          onLoadMore: () => ref
              .read(patientAppointmentsControllerProvider(patient.id).notifier)
              .loadMore(),
          onAddAppointment: () => _showAddAppointmentSheet(context, ref),
          onEditAppointment: (appointment) =>
              _showEditAppointmentSheet(context, ref, appointment),
          onDeleteAppointment: (appointment) =>
              _confirmDelete(context, ref, appointment),
          onStatusChange: (id, status) =>
              _updateStatus(context, ref, id, status),
        );
      },
    );
  }

  void _showAddAppointmentSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => CreateAppointmentSheet(
        initialPatient: patient,
        onSave: (appointment) async {
          return await ref
              .read(patientAppointmentsControllerProvider(patient.id).notifier)
              .createAppointmentAndReturn(appointment);
        },
      ),
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
              .read(patientAppointmentsControllerProvider(patient.id).notifier)
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
        content: const Text(
          'Are you sure you want to delete this appointment?',
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
                  .read(patientAppointmentsControllerProvider(patient.id).notifier)
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
                  .read(patientAppointmentsControllerProvider(patient.id).notifier)
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

/// Internal widget for the paginated appointments list with infinite scroll.
class _PatientAppointmentsList extends HookWidget {
  const _PatientAppointmentsList({
    required this.patient,
    required this.paginatedState,
    required this.onRefresh,
    required this.onLoadMore,
    required this.onAddAppointment,
    required this.onEditAppointment,
    required this.onDeleteAppointment,
    required this.onStatusChange,
  });

  final Patient patient;
  final PaginatedState<AppointmentSchedule> paginatedState;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;
  final VoidCallback onAddAppointment;
  final void Function(AppointmentSchedule) onEditAppointment;
  final void Function(AppointmentSchedule) onDeleteAppointment;
  final void Function(String id, AppointmentScheduleStatus status) onStatusChange;

  @override
  Widget build(BuildContext context) {
    final scrollController = useInfiniteScroll(
      onLoadMore: onLoadMore,
      hasMore: !paginatedState.hasReachedEnd,
      isLoading: paginatedState.isLoadingMore,
    );

    return Column(
      children: [
        // Add button
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton.icon(
                onPressed: onAddAppointment,
                icon: const Icon(Icons.add),
                label: const Text('Add Appointment'),
              ),
            ],
          ),
        ),
        // Appointments list
        Expanded(
          child: RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView.separated(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              // +1 for the end indicator
              itemCount: paginatedState.items.length + 1,
              separatorBuilder: (context, index) {
                // No separator before the end indicator
                if (index == paginatedState.items.length - 1) {
                  return const SizedBox.shrink();
                }
                return const SizedBox(height: 8);
              },
              itemBuilder: (context, index) {
                // Last item is the end indicator
                if (index == paginatedState.items.length) {
                  return EndOfListIndicator(
                    isLoadingMore: paginatedState.isLoadingMore,
                    hasReachedEnd: paginatedState.hasReachedEnd,
                  );
                }

                final appointment = paginatedState.items[index];
                return AppointmentCard(
                  appointment: appointment,
                  showPatientInfo: false,
                  onTap: () {
                    AppointmentDetailRoute(id: appointment.id).go(context);
                  },
                  onEdit: () => onEditAppointment(appointment),
                  onDelete: () => onDeleteAppointment(appointment),
                  onStatusChange: (status) =>
                      onStatusChange(appointment.id, status),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
