import 'package:gym_system/src/features/products/domain/product_inventory_search.dart';
import 'package:gym_system/src/features/products/domain/product_search.dart';
import 'package:gym_system/src/features/products/domain/product_stock_search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_stocks_page_controller.g.dart';

class ProductStocksPageState {
  final int page;
  final int pageSize;

  ProductStocksPageState({
    required this.page,
    required this.pageSize,
  });

  ProductStocksPageState copyWith({
    int? page,
    int? pageSize,
  }) {
    return ProductStocksPageState(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class ProductStocksPageController extends _$ProductStocksPageController {
  @override
  ProductStocksPageState build() {
    return ProductStocksPageState(page: 1, pageSize: 50);
  }

  changePage(int page) {
    state = state.copyWith(page: page);
  }
}

@riverpod
class ProductStockSearchController extends _$ProductStockSearchController {
  @override
  ProductStockSearch? build() {
    return null;
  }

  void updateParams(ProductStockSearch params) {
    state = params;
  }
}
