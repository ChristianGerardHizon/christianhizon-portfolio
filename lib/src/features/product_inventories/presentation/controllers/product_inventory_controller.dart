import 'package:sannjosevet/src/features/product_inventories/data/product_inventory_repository.dart';
import 'package:sannjosevet/src/features/product_inventories/domain/product_inventory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_inventory_controller.g.dart';

@riverpod
class ProductInventoryController extends _$ProductInventoryController {
  @override
  Future<ProductInventory> build(String id) async {
    final repo = ref.read(productInventoryRepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
