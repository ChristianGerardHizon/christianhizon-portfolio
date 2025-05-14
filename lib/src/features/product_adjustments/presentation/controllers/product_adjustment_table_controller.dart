import 'package:gym_system/src/core/models/page_results.dart';
import 'package:gym_system/src/core/models/pb_filter.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/widgets/dynamic_table/table_controller.dart';
import 'package:gym_system/src/features/product_adjustments/data/product_adjustment_repository.dart';
import 'package:gym_system/src/features/product_adjustments/domain/product_adjustment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_adjustment_table_controller.g.dart';

@riverpod
class ProductAdjustmentTableController
    extends _$ProductAdjustmentTableController {
  /// Accepts tableKey, and either productId or productStockId (at least one required)
  @override
  Future<List<ProductAdjustment>> build(
    String tableKey, {
    String? productId,
    String? productStockId,
  }) async {
    assert(productId != null || productStockId != null,
        'Either productId or productStockId must be provided.');
    final repo = ref.read(productAdjustmentRepositoryProvider);

    final page = ref
        .watch(tableControllerProvider(tableKey).select((state) => state.page));
    final pageSize = ref.watch(
        tableControllerProvider(tableKey).select((state) => state.pageSize));
    final tableFilter = ref.watch(
        tableControllerProvider(tableKey).select((state) => state.filter));

    final notifier = ref.read(tableControllerProvider(tableKey).notifier);
    String baseFilter = "${ProductAdjustmentField.isDeleted} = false ";
    if (productId != null) {
      baseFilter += "&& product = '$productId' ";
    } else if (productStockId != null) {
      baseFilter += "&& productStock = '$productStockId' ";
    }
    final filterFunc = PocketbaseFilter(baseFilter: baseFilter);

    final result = await repo
        // 1. Fetch data
        .list(
          filter: filterFunc.searchName(tableFilter).build(),
          pageNo: page,
          pageSize: pageSize,
          sort: '-updated',
        )
        // 2. success sideeffect
        .flatMap((result) => _handleSuccess(result, notifier))
        // 3. run
        .run();

    return result.fold(Future.error, (x) => Future.value(x.items));
  }
}

TaskResult _handleSuccess(
  PageResults<ProductAdjustment> result,
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
