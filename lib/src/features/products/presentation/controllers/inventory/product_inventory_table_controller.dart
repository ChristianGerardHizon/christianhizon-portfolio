import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/core/packages/pocketbase_filter.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:gym_system/src/features/products/data/product_inventory_repository.dart';
import 'package:gym_system/src/features/products/domain/product_inventory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_inventory_table_controller.g.dart';

@riverpod
class ProductInventoryTableController
    extends _$ProductInventoryTableController {
  @override
  Future<List<ProductInventory>> build(String tableKey) async {
    final repo = ref.read(productInventoryRepositoryProvider);
    final tableProvider = tableControllerProvider(tableKey);
    final page = ref.watch(tableProvider.select(
      (state) => state.page,
    ));
    final pageSize = ref.watch(tableProvider.select((state) => state.pageSize));
    final tableFilter =
        ref.watch(tableProvider.select((state) => state.filter));

    final notifier = ref.read(tableProvider.notifier);
    final baseFilter = '${ProductField.isDeleted} = false';
    final filterFunc = PocketbaseFilter(baseFilter: baseFilter);

    final result = await repo

        // 1. Fetch data
        .list(
          filter: filterFunc.searchName(tableFilter),
          pageNo: page,
          pageSize: pageSize,
          sort: '+created',
        )

        // 2. success sideffect
        .flatMap((result) => _handleSuccess(result, notifier))

        // 3. run
        .run();

    return result.fold(Future.error, (x) => Future.value(x.items));
  }
}

TaskResult _handleSuccess(
  PageResults<ProductInventory> result,
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
