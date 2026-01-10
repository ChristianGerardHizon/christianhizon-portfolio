import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/features/products/adjustments/domain/product_adjustment.dart';
import 'package:sannjosevet/src/features/products/adjustments/presentation/controllers/product_adjustment_controller.dart';
import 'package:sannjosevet/src/features/products/stocks/domain/product_stock.dart';
import 'package:sannjosevet/src/features/products/stocks/presentation/controllers/product_stock_controller.dart';
import 'package:sannjosevet/src/features/products/core/domain/product.dart';
import 'package:sannjosevet/src/features/products/core/presentation/controllers/product_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_adjustment_form_controller.g.dart';

class ProductAdjustmentFormState {
  final ProductAdjustment? productAdjustment;
  final ProductStock? productStock;
  final Product? product;

  ProductAdjustmentFormState({
    this.productAdjustment,
    this.productStock,
    this.product,
  });
}

@riverpod
class ProductAdjustmentFormController
    extends _$ProductAdjustmentFormController {
  @override
  Future<ProductAdjustmentFormState> build({
    String? id,
    String? productId,
    String? productStockId,
  }) async {
    final result = await TaskResult.Do(($) async {
      final productStock = productStockId is String
          ? await ref
              .watch(productStockControllerProvider(productStockId).future)
          : null;

      final productState = productId is String
          ? await ref.watch(productControllerProvider(productId).future)
          : null;

      if (id == null) {
        return ProductAdjustmentFormState(
          productAdjustment: null,
          productStock: productStock,
          product: productState?.product,
        );
      }

      final productAdjustment =
          await ref.watch(productAdjustmentControllerProvider(id).future);
      return ProductAdjustmentFormState(
        productAdjustment: productAdjustment,
        productStock: productStock,
        product: productState?.product,
      );
    }).run();

    return result.fold(Future.error, Future.value);
  }
}
