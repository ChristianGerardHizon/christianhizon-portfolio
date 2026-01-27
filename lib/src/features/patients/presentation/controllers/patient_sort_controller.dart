import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/sort_config.dart';

part 'patient_sort_controller.g.dart';

/// Default sort configuration for patients (newest first).
const patientDefaultSort = SortConfig(field: 'created', descending: true);

/// Available sortable fields for patients.
const patientSortableFields = <SortableField>[
  (key: 'name', label: 'Name'),
  (key: 'created', label: 'Date Added'),
  (key: 'updated', label: 'Last Updated'),
  (key: 'species', label: 'Species'),
  (key: 'owner', label: 'Owner'),
];

/// Provider for managing patient list sort configuration.
@riverpod
class PatientSortController extends _$PatientSortController {
  @override
  SortConfig build() => patientDefaultSort;

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
  void reset() => state = patientDefaultSort;
}
