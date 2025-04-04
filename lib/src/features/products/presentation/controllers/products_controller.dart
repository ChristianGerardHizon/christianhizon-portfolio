import 'package:fpdart/fpdart.dart';
import 'package:gym_system/src/core/packages/pocketbase_sort_value.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/domain/product_search.dart';
import 'package:gym_system/src/features/products/presentation/controllers/products_page_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_controller.g.dart';

@riverpod
class ProductsController extends _$ProductsController {
  String _buildFilter({
    ProductSearch? params,
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
  Future<PageResults<Product>> build() async {
    final pageState = ref.watch(productsPageControllerProvider);
    final repo = ref.read(productRepositoryProvider);
    final searchParams = ref.watch(productSearchControllerProvider);
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
