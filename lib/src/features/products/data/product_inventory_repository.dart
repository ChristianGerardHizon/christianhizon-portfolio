import 'package:gym_system/src/core/classes/pb_repository.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/packages/pocketbase_collections.dart';
import 'package:gym_system/src/core/classes/page_results.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/products/domain/product_inventory.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_inventory_repository.g.dart';

@Riverpod(keepAlive: true)
PBViewRepository<ProductInventory> productInventoryRepository(Ref ref) {
  return ProductInventoryRepositoryImpl(
    pb: ref.watch(pocketbaseProvider),
  );
}

class ProductInventoryRepositoryImpl
    extends PBViewRepository<ProductInventory> {
  final PocketBase pb;

  ProductInventoryRepositoryImpl({required this.pb});

  RecordService get collection =>
      pb.collection(PocketBaseCollections.productInventoryStatus);

  final expand = 'product,branch,category,product.branch,product.category';

  @override
  TaskResult<ProductInventory> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id, expand: expand);
      return ProductInventory.fromMap(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<PageResults<ProductInventory>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
    String? sort,
  }) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getList(
        filter: filter,
        page: pageNo,
        perPage: pageSize,
        sort: sort,
        expand: expand,
      );
      final items = result.items.map<ProductInventory>((e) {
        print(e.toJson());
        return ProductInventory.fromMap(e.toJson());
      }).toList();
      return PageResults(
        page: result.page,
        perPage: result.perPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
        items: items,
      );
    }, Failure.handle);
  }

  @override
  TaskResult<List<ProductInventory>> listAll({
    int batch = 500,
    String? filter,
  }) {
    return TaskResult.tryCatch(
      () async {
        final result = await collection.getFullList(
          filter: filter,
          expand: expand,
        );
        return result
            .map<ProductInventory>((e) => ProductInventory.fromMap(e.toJson()))
            .toList();
      },
      Failure.handle,
    );
  }
}
