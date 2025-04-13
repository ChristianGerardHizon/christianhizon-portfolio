import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/domain/product_inventory.dart';
import 'package:gym_system/src/features/products/presentation/controllers/inventory/product_inventory_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_controller.g.dart';

class ProductState {
  final Product product;
  final ProductInventory inventory;

  ProductState(this.product, this.inventory);
}

@riverpod
class ProductController extends _$ProductController {
  @override
  Future<ProductState> build(String id) async {
    final result = await TaskResult.Do(($) async {
      final product = await $(_getProduct(id));
      final inventory = await $(_getProductInventory(id));

      return ProductState(product, inventory);
    }).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }

  TaskResult<Product> _getProduct(String id) {
    return TaskResult.tryCatch(() async {
      final repo = ref.read(productRepositoryProvider);
      final result = await repo.get(id).run();
      return result.fold(Future.error, (x) => Future.value(x));
    }, Failure.tryCatchData);
  }

  TaskResult<ProductInventory> _getProductInventory(String id) {
    return TaskResult.tryCatch(() async {
      return await ref.read(productInventoryControllerProvider(id).future);
    }, Failure.tryCatchData);
  }
}
