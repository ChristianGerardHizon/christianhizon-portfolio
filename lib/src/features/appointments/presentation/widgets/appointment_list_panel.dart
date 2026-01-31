import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/foundation/paginated_state.dart';
import '../../../../core/foundation/sort_config.dart';
import '../../../../core/hooks/use_infinite_scroll.dart';
import '../../../../core/i18n/strings.g.dart';
import '../../../../core/widgets/end_of_list_indicator.dart';
import '../../../../core/widgets/sort/sort_dialog.dart';
import '../../domain/appointment_schedule.dart';
import '../controllers/appointment_search_controller.dart';
import '../controllers/appointment_sort_controller.dart';
import '../controllers/appointments_controller.dart';
import '../controllers/paginated_appointments_controller.dart';
import 'cards/appointment_card.dart';
import 'dialogs/appointment_search_fields_dialog.dart';

/// Appointment list panel with view mode toggle and infinite scroll.
///
/// Used in both mobile list page and tablet two-pane layout.
class AppointmentListPanel extends HookConsumerWidget {
  const AppointmentListPanel({
    super.key,
    required this.paginatedState,
    required this.selectedId,
    required this.onAppointmentTap,
    required this.onRefresh,
    required this.onLoadMore,
    required this.onEdit,
    this.onReschedule,
    required this.onDelete,
    required this.onStatusChange,
    required this.onCreateAppointment,
  });

  final PaginatedState<AppointmentSchedule> paginatedState;
  final String? selectedId;
  final ValueChanged<AppointmentSchedule> onAppointmentTap;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;
  final void Function(AppointmentSchedule) onEdit;
  final void Function(AppointmentSchedule)? onReschedule;
  final void Function(AppointmentSchedule) onDelete;
  final void Function(String id, AppointmentScheduleStatus status) onStatusChange;
  final VoidCallback onCreateAppointment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // View mode: 0 = list, 1 = calendar
    final viewMode = useState(0);

    // Search state
    final searchController = useTextEditingController();
    final searchText = useState('');

    // For calendar view, we need non-paginated data
    final appointmentsAsync = ref.watch(appointmentsControllerProvider);
    final sortConfig = ref.watch(appointmentSortControllerProvider);

    // Watch search providers
    final searchFields = ref.watch(appointmentSearchFieldsProvider);
    final activeFieldCount = searchFields.length;
    final paginatedController =
        ref.read(paginatedAppointmentsControllerProvider.notifier);

    // Search is active from the controller
    final isSearchActive = paginatedController.isSearchActive;

    void performSearch() {
      final query = searchController.text.trim();
      if (query.isEmpty) return;

      final fields = ref.read(appointmentSearchFieldsProvider).toList();
      paginatedController.search(query, fields: fields);
    }

    void clearSearch() {
      searchController.clear();
      searchText.value = '';
      ref.read(appointmentSearchFieldsProvider.notifier).reset();
      paginatedController.clearSearch();
    }

    // Infinite scroll hook
    final scrollController = useInfiniteScroll(
      onLoadMore: onLoadMore,
      hasMore: !paginatedState.hasReachedEnd,
      isLoading: paginatedState.isLoadingMore,
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: onCreateAppointment,
        tooltip: 'New Appointment',
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Header with view mode toggle
          Container(
            padding: const EdgeInsets.all(16),
            color: theme.colorScheme.surfaceContainerHighest,
            child: Row(
              children: [
                Text('Appointments', style: theme.textTheme.titleLarge),
                const Spacer(),
                Text(
                  '${paginatedState.totalItems} total',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(width: 8),
                SegmentedButton<int>(
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
                  style: const ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),

          // Search (only in list mode)
          if (viewMode.value == 0)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: isSearchActive
                  ? _ActiveSearchChip(
                      query: paginatedController.currentSearchQuery ?? '',
                      fieldCount: activeFieldCount,
                      sortConfig: sortConfig,
                      onClear: clearSearch,
                      onSortPressed: () => _showSortDialog(context, ref),
                    )
                  : _SearchInput(
                      controller: searchController,
                      fieldCount: activeFieldCount,
                      sortConfig: sortConfig,
                      onSearch: performSearch,
                      onTextChanged: (text) => searchText.value = text,
                      searchText: searchText.value,
                      onSortPressed: () => _showSortDialog(context, ref),
                    ),
            ),

          // Content based on view mode
          Expanded(
            child: viewMode.value == 0
                ? _buildListView(context, scrollController, theme)
                : _buildCalendarView(context, ref, appointmentsAsync),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(
    BuildContext context,
    ScrollController scrollController,
    ThemeData theme,
  ) {
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

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 80),
        physics: const AlwaysScrollableScrollPhysics(),
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
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(
                  dateLabel,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Appointments for this date
              ...dayAppointments.map((appointment) {
                final isSelected = appointment.id == selectedId;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    decoration: isSelected
                        ? BoxDecoration(
                            border: Border.all(
                              color: theme.colorScheme.primary,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          )
                        : null,
                    child: AppointmentCard(
                      appointment: appointment,
                      onTap: () => onAppointmentTap(appointment),
                      onEdit: () => onEdit(appointment),
                      onReschedule: onReschedule != null
                          ? () => onReschedule!(appointment)
                          : null,
                      onDelete: () => onDelete(appointment),
                      onStatusChange: (status) =>
                          onStatusChange(appointment.id, status),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
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
      data: (appointments) => _CalendarViewWithSelection(
        appointments: appointments,
        selectedId: selectedId,
        onAppointmentTap: onAppointmentTap,
        onCreateAppointment: onCreateAppointment,
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
      const weekdays = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ];
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      final weekday = weekdays[date.weekday - 1];
      final month = months[date.month - 1];
      return '$weekday, $month ${date.day}';
    }
  }
}

class _ActiveSearchChip extends StatelessWidget {
  const _ActiveSearchChip({
    required this.query,
    required this.fieldCount,
    required this.sortConfig,
    required this.onClear,
    required this.onSortPressed,
  });

  final String query;
  final int fieldCount;
  final SortConfig sortConfig;
  final VoidCallback onClear;
  final VoidCallback onSortPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context);

    return Row(
      children: [
        Expanded(
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              isDense: true,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '"$query"',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (fieldCount > 1) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '$fieldCount fields',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
                const SizedBox(width: 8),
                InkWell(
                  onTap: onClear,
                  borderRadius: BorderRadius.circular(12),
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton.filledTonal(
          icon: Icon(
            sortConfig.descending ? Icons.arrow_downward : Icons.arrow_upward,
          ),
          onPressed: onSortPressed,
          tooltip: t.common.sort,
        ),
      ],
    );
  }
}

class _SearchInput extends StatelessWidget {
  const _SearchInput({
    required this.controller,
    required this.fieldCount,
    required this.sortConfig,
    required this.onSearch,
    required this.onTextChanged,
    required this.searchText,
    required this.onSortPressed,
  });

  final TextEditingController controller;
  final int fieldCount;
  final SortConfig sortConfig;
  final VoidCallback onSearch;
  final ValueChanged<String> onTextChanged;
  final String searchText;
  final VoidCallback onSortPressed;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onTextChanged,
            onSubmitted: (_) => onSearch(),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: '${t.common.search}...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchText.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller.clear();
                        onTextChanged('');
                      },
                      tooltip: t.common.cancel,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              isDense: true,
              filled: true,
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton.filledTonal(
          icon: Icon(
            sortConfig.descending ? Icons.arrow_downward : Icons.arrow_upward,
          ),
          onPressed: onSortPressed,
          tooltip: t.common.sort,
        ),
        const SizedBox(width: 8),
        Badge(
          isLabelVisible: fieldCount > 1,
          label: Text('$fieldCount'),
          child: IconButton.filledTonal(
            icon: const Icon(Icons.tune),
            onPressed: () => showAppointmentSearchFieldsDialog(context),
            tooltip: t.common.filter,
          ),
        ),
      ],
    );
  }
}

void _showSortDialog(BuildContext context, WidgetRef ref) {
  final t = Translations.of(context);
  final currentSort = ref.read(appointmentSortControllerProvider);

  // Build localized field labels
  final localizedFields = appointmentSortableFields.map((field) {
    final label = switch (field.key) {
      'date' => t.sort.date,
      'created' => t.sort.dateAdded,
      'status' => t.sort.status,
      _ => field.label,
    };
    return (key: field.key, label: label);
  }).toList();

  showSortDialog(
    context: context,
    title: t.sort.sortBy,
    fields: localizedFields,
    currentSort: currentSort,
    defaultSort: appointmentDefaultSort,
    onSortChanged: (config) {
      ref.read(appointmentSortControllerProvider.notifier).setSort(config);
    },
  );
}

/// Calendar view that supports selection highlighting using TableCalendar.
class _CalendarViewWithSelection extends HookConsumerWidget {
  const _CalendarViewWithSelection({
    required this.appointments,
    required this.selectedId,
    required this.onAppointmentTap,
    required this.onCreateAppointment,
  });

  final List<AppointmentSchedule> appointments;
  final String? selectedId;
  final ValueChanged<AppointmentSchedule> onAppointmentTap;
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
        // TableCalendar widget
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

        // Appointments for selected day
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
                        'No appointments for this day',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                      const SizedBox(height: 16),
                      FilledButton.tonalIcon(
                        onPressed: onCreateAppointment,
                        icon: const Icon(Icons.add),
                        label: const Text('Create Appointment'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: selectedAppointments.length,
                  itemBuilder: (context, index) {
                    final appointment = selectedAppointments[index];
                    final isSelected = appointment.id == selectedId;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        decoration: isSelected
                            ? BoxDecoration(
                                border: Border.all(
                                  color: theme.colorScheme.primary,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              )
                            : null,
                        child: AppointmentCard(
                          appointment: appointment,
                          onTap: () => onAppointmentTap(appointment),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
