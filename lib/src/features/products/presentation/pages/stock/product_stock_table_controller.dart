import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/core/packages/pocketbase_filter.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:gym_system/src/features/products/data/product_stock_repository.dart';
import 'package:gym_system/src/features/products/domain/product_stock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_stock_table_controller.g.dart';

@riverpod
class ProductStockTableController extends _$ProductStockTableController {
  @override
  Future<List<ProductStock>> build(String tableKey) async {
    final repo = ref.read(productStockRepositoryProvider);
    final tableProvider = tableControllerProvider(tableKey);
    final page = ref.watch(tableProvider.select((state) => state.page));
    final pageSize = ref.watch(tableProvider.select((state) => state.pageSize));
    final tableFilter =
        ref.watch(tableProvider.select((state) => state.filter));

    final notifier = ref.read(tableProvider.notifier);
    final baseFilter = '${ProductStockField.isDeleted} = false';
    final filterFunc = PocketbaseFilter(baseFilter: baseFilter);

    ref.onDispose(() {
      ref.invalidate(tableProvider);
    });

    final result = await repo

        // 1. Fetch data
        .list(
          // filter: filterFunc.searchName(tableFilter),
          pageNo: page,
          pageSize: pageSize,
          // sort: '+created',
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
    totalItems: result.totalItems,
    totalPages: result.totalPages,
  );
  return TaskResult.right(result);
}

String? _combineFilter(String? filter, {String? baseFilter}) {
  if (filter == null || filter.isEmpty) return baseFilter;
  if (baseFilter == null || baseFilter.isEmpty) return filter;
  return '$filter && $baseFilter';
}
