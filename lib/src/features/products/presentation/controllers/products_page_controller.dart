import 'package:gym_system/src/features/products/domain/product_search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_page_controller.g.dart';

class ProductsPageState {
  final int page;
  final int pageSize;

  ProductsPageState({
    required this.page,
    required this.pageSize,
  });

  ProductsPageState copyWith({
    int? page,
    int? pageSize,
  }) {
    return ProductsPageState(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class ProductsPageController extends _$ProductsPageController {
  @override
  ProductsPageState build() {
    return ProductsPageState(page: 1, pageSize: 50);
  }

  changePage(int page) {
    state = state.copyWith(page: page);
  }
}

@riverpod
class ProductSearchController extends _$ProductSearchController {
  @override
  ProductSearch? build() {
    return null;
  }

  void updateParams(ProductSearch params) {
    state = params;
  }
}
