import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/sort_config.dart';

part 'sale_sort_controller.g.dart';

/// Default sort configuration for sales (newest first).
const saleDefaultSort = SortConfig(field: 'created', descending: true);

/// Available sortable fields for sales.
const saleSortableFields = <SortableField>[
  (key: 'created', label: 'Date'),
  (key: 'totalAmount', label: 'Amount'),
  (key: 'receiptNumber', label: 'Receipt #'),
  (key: 'customerName', label: 'Customer'),
];

/// Provider for managing sale list sort configuration.
@riverpod
class SaleSortController extends _$SaleSortController {
  @override
  SortConfig build() => saleDefaultSort;

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
  void reset() => state = saleDefaultSort;
}
