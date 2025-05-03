import 'package:gym_system/src/features/product_stocks/data/product_stock_repository.dart';
import 'package:gym_system/src/features/product_stocks/domain/product_stock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_stock_controller.g.dart';

@riverpod
class ProductStockController extends _$ProductStockController {
  @override
  Future<ProductStock> build(String id) async {
    final repo = ref.read(productStockRepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
