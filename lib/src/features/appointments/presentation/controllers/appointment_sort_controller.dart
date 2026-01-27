import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/sort_config.dart';

part 'appointment_sort_controller.g.dart';

/// Default sort configuration for appointments (newest first by date).
const appointmentDefaultSort = SortConfig(field: 'date', descending: true);

/// Available sortable fields for appointments.
const appointmentSortableFields = <SortableField>[
  (key: 'date', label: 'Date'),
  (key: 'created', label: 'Date Created'),
  (key: 'status', label: 'Status'),
];

/// Provider for managing appointment list sort configuration.
@riverpod
class AppointmentSortController extends _$AppointmentSortController {
  @override
  SortConfig build() => appointmentDefaultSort;

  /// Sets the sort configuration.
  void setSort(SortConfig config) => state = config;

  /// Sets only the sort field, keeping the current direction.
  void setSortField(String field) {
    state = state.copyWith(field: field);
  }

  /// Toggles the sort direction.
  void toggleDirection() {
    state = state.toggleDirection();
  }

  /// Resets to default sort.
  void reset() => state = appointmentDefaultSort;
}
