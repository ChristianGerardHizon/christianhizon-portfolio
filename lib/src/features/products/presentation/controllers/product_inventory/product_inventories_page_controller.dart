import 'package:gym_system/src/features/products/domain/product_inventory_search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_inventories_page_controller.g.dart';

class ProductInventoriesPageState {
  final int page;
  final int pageSize;

  ProductInventoriesPageState({
    required this.page,
    required this.pageSize,
  });

  ProductInventoriesPageState copyWith({
    int? page,
    int? pageSize,
  }) {
    return ProductInventoriesPageState(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class ProductInventoriesPageController
    extends _$ProductInventoriesPageController {
  @override
  ProductInventoriesPageState build() {
    return ProductInventoriesPageState(page: 1, pageSize: 50);
  }

  changePage(int page) {
    state = state.copyWith(page: page);
  }
}

@riverpod
class ProductInventorySearchController
    extends _$ProductInventorySearchController {
  @override
  ProductInventorySearch? build() {
    return null;
  }

  void updateParams(ProductInventorySearch params) {
    state = params;
  }
}
