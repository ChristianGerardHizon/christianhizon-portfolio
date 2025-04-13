import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/packages/pocketbase_sort_value.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/features/products/data/product_inventory_repository.dart';
import 'package:gym_system/src/features/products/domain/product_inventory.dart';
import 'package:gym_system/src/features/products/domain/product_inventory_search.dart';
import 'package:gym_system/src/features/products/presentation/controllers/inventory/product_inventories_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_inventories_controller.g.dart';

@riverpod
class ProductInventoriesController extends _$ProductInventoriesController {
  String _buildFilter({
    ProductInventorySearch? params,
  }) {
    final baseFilter = '${ProductField.isDeleted} = false';

    final nameFilter = Option.of(params?.name)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${ProductField.name} ~ "$q"');

    final idFilter = Option.of(params?.id)
        .map((q) => (q ?? '').trim())
        .filter((q) => q.isNotEmpty)
        .map((q) => '${ProductField.id} ~ "$q"');

    final result = [
      nameFilter,
      Some(baseFilter),
      idFilter,
    ].whereType<Some<String>>().map((some) => some.value).join(' && ');

    return result;
  }

  @override
  Future<PageResults<ProductInventory>> build() async {
    final pageState = ref.watch(productInventoriesPageControllerProvider);
    final repo = ref.read(productInventoryRepositoryProvider);
    final searchParams = ref.watch(productInventorySearchControllerProvider);
    final result = await repo
        .list(
            filter: _buildFilter(params: searchParams),
            pageNo: pageState.page,
            pageSize: pageState.pageSize,
            sort: PocketbaseSortValue(
              sortKey: ProductField.created,
              isAsc: true,
            ))
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
