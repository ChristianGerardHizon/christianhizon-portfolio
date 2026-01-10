import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/features/products/adjustments/data/product_adjustment_repository.dart';

import 'package:sannjosevet/src/features/products/adjustments/domain/product_adjustment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_adjustment_controller.g.dart';

@riverpod
class ProductAdjustmentController extends _$ProductAdjustmentController {
  @override
  Future<ProductAdjustment> build(String id) async {
    final result = await TaskResult.Do(($) async {
      final productAdjustment = await $(_getProductAdjustment(id));

      return productAdjustment;
    }).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }

  TaskResult<ProductAdjustment> _getProductAdjustment(String id) {
    return TaskResult.tryCatch(() async {
      final repo = ref.read(productAdjustmentRepositoryProvider);
      final result = await repo.get(id).run();
      return result.fold(Future.error, (x) => Future.value(x));
    }, Failure.handle);
  }
}
