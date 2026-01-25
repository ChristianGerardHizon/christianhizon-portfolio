import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/foundation/paginated_state.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../../../core/hooks/use_infinite_scroll.dart';
import '../../../../core/routing/routes/appointments.routes.dart';
import '../../../../core/widgets/end_of_list_indicator.dart';
import '../../domain/appointment_schedule.dart';
import '../controllers/appointments_controller.dart';
import '../controllers/paginated_appointments_controller.dart';
import '../widgets/cards/appointment_card.dart';
import '../widgets/components/appointments_calendar.dart';
import '../widgets/sheets/create_appointment_sheet.dart';
import '../widgets/sheets/edit_appointment_sheet.dart';

/// Main appointments page showing list and calendar views.
class AppointmentsPage extends HookConsumerWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Paginated data for list view
    final paginatedAsync = ref.watch(paginatedAppointmentsControllerProvider);
    // Non-paginated data for calendar view (needs all appointments)
    final appointmentsAsync = ref.watch(appointmentsControllerProvider);

    // View mode: 0 = list, 1 = calendar
    final viewMode = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(
                  value: 0,
                  icon: Icon(Icons.list, size: 18),
                ),
                ButtonSegment(
                  value: 1,
                  icon: Icon(Icons.calendar_month, size: 18),
                ),
              ],
              selected: {viewMode.value},
              onSelectionChanged: (selected) {
                viewMode.value = selected.first;
              },
              showSelectedIcon: false,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
      ),
      body: viewMode.value == 0
          ? _buildListView(context, ref, paginatedAsync)
          : _buildCalendarView(context, ref, appointmentsAsync),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateAppointmentSheet(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('New Appointment'),
      ),
    );
  }

  Widget _buildListView(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<PaginatedState<AppointmentSchedule>> paginatedAsync,
  ) {
    final theme = Theme.of(context);

    return paginatedAsync.when(
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
                  .read(paginatedAppointmentsControllerProvider.notifier)
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
                Text(
                  'Tap the button below to create one',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ],
            ),
          );
        }

        // Group appointments by date
        final grouped = _groupAppointmentsByDate(paginatedState.items);
        final groupedEntries = grouped.entries.toList();

        return _PaginatedListView(
          paginatedState: paginatedState,
          groupedEntries: groupedEntries,
          onRefresh: () => ref
              .read(paginatedAppointmentsControllerProvider.notifier)
              .refresh(),
          onLoadMore: () => ref
              .read(paginatedAppointmentsControllerProvider.notifier)
              .loadMore(),
          onEdit: (appointment) =>
              _showEditAppointmentSheet(context, ref, appointment),
          onDelete: (appointment) =>
              _confirmDelete(context, ref, appointment),
          onStatusChange: (id, status) =>
              _updateStatus(context, ref, id, status),
        );
      },
    );
  }

  Widget _buildCalendarView(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<AppointmentSchedule>> appointmentsAsync,
  ) {
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
              onPressed: () =>
                  ref.read(appointmentsControllerProvider.notifier).refresh(),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (appointments) => AppointmentsCalendar(
        appointments: appointments,
        onCreateAppointment: () => _showCreateAppointmentSheet(context, ref),
      ),
    );
  }

  Map<String, List<AppointmentSchedule>> _groupAppointmentsByDate(
    List<AppointmentSchedule> appointments,
  ) {
    final Map<String, List<AppointmentSchedule>> grouped = {};

    for (final appointment in appointments) {
      final dateKey = _formatDateHeader(appointment.date);
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(appointment);
    }

    return grouped;
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final appointmentDate = DateTime(date.year, date.month, date.day);

    if (appointmentDate == today) {
      return 'Today';
    } else if (appointmentDate == today.add(const Duration(days: 1))) {
      return 'Tomorrow';
    } else if (appointmentDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      // Format as "Monday, Jan 15"
      const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      final weekday = weekdays[date.weekday - 1];
      final month = months[date.month - 1];
      return '$weekday, $month ${date.day}';
    }
  }

  void _showCreateAppointmentSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => CreateAppointmentSheet(
        onSave: (appointment) async {
          // Create in paginated controller (for list view)
          final created = await ref
              .read(paginatedAppointmentsControllerProvider.notifier)
              .createAppointmentAndReturn(appointment);
          // Also refresh the non-paginated controller (for calendar view)
          if (created != null) {
            ref.invalidate(appointmentsControllerProvider);
          }
          return created;
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
              .read(paginatedAppointmentsControllerProvider.notifier)
              .updateAppointment(updated);
          if (success) {
            ref.invalidate(appointmentsControllerProvider);
          }
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
                  .read(paginatedAppointmentsControllerProvider.notifier)
                  .deleteAppointment(appointment.id);
              if (success) {
                ref.invalidate(appointmentsControllerProvider);
              }
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
                  .read(paginatedAppointmentsControllerProvider.notifier)
                  .updateStatus(id, status);

              if (success) {
                ref.invalidate(appointmentsControllerProvider);
              }

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
}

/// Internal widget for the paginated list view with infinite scroll.
class _PaginatedListView extends HookWidget {
  const _PaginatedListView({
    required this.paginatedState,
    required this.groupedEntries,
    required this.onRefresh,
    required this.onLoadMore,
    required this.onEdit,
    required this.onDelete,
    required this.onStatusChange,
  });

  final PaginatedState<AppointmentSchedule> paginatedState;
  final List<MapEntry<String, List<AppointmentSchedule>>> groupedEntries;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;
  final void Function(AppointmentSchedule) onEdit;
  final void Function(AppointmentSchedule) onDelete;
  final void Function(String id, AppointmentScheduleStatus status) onStatusChange;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final scrollController = useInfiniteScroll(
      onLoadMore: onLoadMore,
      hasMore: !paginatedState.hasReachedEnd,
      isLoading: paginatedState.isLoadingMore,
    );

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
        // +1 for the end indicator
        itemCount: groupedEntries.length + 1,
        itemBuilder: (context, index) {
          // Last item is the end indicator
          if (index == groupedEntries.length) {
            return EndOfListIndicator(
              isLoadingMore: paginatedState.isLoadingMore,
              hasReachedEnd: paginatedState.hasReachedEnd,
            );
          }

          final entry = groupedEntries[index];
          final dateLabel = entry.key;
          final dayAppointments = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date header
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  dateLabel,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Appointments for this date
              ...dayAppointments.map((appointment) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: AppointmentCard(
                      appointment: appointment,
                      onTap: () {
                        AppointmentDetailRoute(id: appointment.id).go(context);
                      },
                      onEdit: () => onEdit(appointment),
                      onDelete: () => onDelete(appointment),
                      onStatusChange: (status) =>
                          onStatusChange(appointment.id, status),
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }
}
