import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/foundation/sort_config.dart';

part 'product_sort_controller.g.dart';

/// Default sort configuration for products (newest first).
const productDefaultSort = SortConfig(field: 'created', descending: true);

/// Available sortable fields for products.
const productSortableFields = <SortableField>[
  (key: 'name', label: 'Name'),
  (key: 'price', label: 'Price'),
  (key: 'quantity', label: 'Stock'),
  (key: 'created', label: 'Date Added'),
  (key: 'updated', label: 'Last Updated'),
  (key: 'expiration', label: 'Expiration'),
];

/// Provider for managing product list sort configuration.
@riverpod
class ProductSortController extends _$ProductSortController {
  @override
  SortConfig build() => productDefaultSort;

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
  void reset() => state = productDefaultSort;
}
