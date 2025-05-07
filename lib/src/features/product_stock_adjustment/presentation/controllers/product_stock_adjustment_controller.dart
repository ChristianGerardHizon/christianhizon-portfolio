import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/models/type_defs.dart';

import 'package:gym_system/src/features/product_stock_adjustment/data/product_stock_adjustment_repository.dart';
import 'package:gym_system/src/features/product_stock_adjustment/domain/product_stock_adjustment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_stock_adjustment_controller.g.dart';

@riverpod
class ProductStockAdjustmentController
    extends _$ProductStockAdjustmentController {
  @override
  Future<ProductStockAdjustment> build(String id) async {
    final result = await TaskResult.Do(($) async {
      final productStockAdjustment = await $(_getProductStockAdjustment(id));

      return productStockAdjustment;
    }).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }

  TaskResult<ProductStockAdjustment> _getProductStockAdjustment(String id) {
    return TaskResult.tryCatch(() async {
      final repo = ref.read(productStockAdjustmentRepositoryProvider);
      final result = await repo.get(id).run();
      return result.fold(Future.error, (x) => Future.value(x));
    }, Failure.handle);
  }
}
