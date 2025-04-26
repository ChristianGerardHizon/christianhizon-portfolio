import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/features/products/data/product_stock_repository.dart';
import 'package:gym_system/src/features/products/domain/product_stock.dart';
import 'package:gym_system/src/features/products/domain/product_stock_search.dart';
import 'package:gym_system/src/features/products/presentation/controllers/stock/product_stocks_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_stocks_controller.g.dart';

@riverpod
class ProductStocksController extends _$ProductStocksController {
  String _buildFilter({
    ProductStockSearch? params,
  }) {
    final baseFilter = '${ProductStockField.isDeleted} = false';

    final nameFilter = Option.of(params?.name)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${ProductStockField.name} ~ "$q"');

    final idFilter = Option.of(params?.id)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${ProductStockField.id} ~ "$q"');

    final result = [
      nameFilter,
      Some(baseFilter),
      idFilter,
    ].whereType<Some<String>>().map((some) => some.value).join(' && ');

    return result;
  }

  @override
  Future<PageResults<ProductStock>> build() async {
    final pageState = ref.watch(productStocksPageControllerProvider);
    final repo = ref.read(productStockRepositoryProvider);
    final searchParams = ref.watch(productStockSearchControllerProvider);
    final result = await repo
        .list(
          filter: _buildFilter(params: searchParams),
          pageNo: pageState.page,
          pageSize: pageState.pageSize,
          sort: '+created',
        )
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
