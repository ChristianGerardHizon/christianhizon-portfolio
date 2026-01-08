import 'package:sannjosevet/src/core/models/page_results.dart';
import 'package:sannjosevet/src/core/models/pb_filter.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:sannjosevet/src/features/product_stocks/data/product_stock_repository.dart';
import 'package:sannjosevet/src/features/product_stocks/domain/product_stock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_stock_table_controller.g.dart';

@riverpod
class ProductStockTableController extends _$ProductStockTableController {
  @override
  Future<List<ProductStock>> build(String tableKey, String productId) async {
    final repo = ref.read(productStockRepositoryProvider);

    final tableState = ref.watch(tableControllerProvider(tableKey));
    final page = tableState.page;
    final pageSize = tableState.pageSize;
    final tableFilter = tableState.filter;

    final notifier = ref.read(tableControllerProvider(tableKey).notifier);
    final baseFilter =
        "${ProductStockField.isDeleted} = false && product.id = '${productId}' ";
    final filterFunc = PocketbaseFilter(baseFilter: baseFilter);

    final result = await repo

        // 1. Fetch data
        .list(
          filter: filterFunc.searchName(tableFilter).build(),
          pageNo: page,
          pageSize: pageSize,
          sort: '-updated',
        )

        // 2. success sideffect
        .flatMap((result) => _handleSuccess(result, notifier))

        // 3. run
        .run();

    return result.fold(Future.error, (x) => Future.value(x.items));
  }
}

TaskResult _handleSuccess(
  PageResults<ProductStock> result,
  TableController notifier,
) {
  notifier.fetchSuccess(
    hasNext: result.hasNext,
    page: result.page,
    totalItems: result.totalItems,
    totalPages: result.totalPages,
  );
  return TaskResult.right(result);
}
