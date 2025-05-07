import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/models/pb_file.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/utils/pb_utils.dart';
import 'package:gym_system/src/features/branches/data/branch_repository.dart';
import 'package:gym_system/src/features/branches/domain/branch.dart';
import 'package:gym_system/src/features/product_stock_adjustment/data/product_stock_adjustment_repository.dart';
import 'package:gym_system/src/features/product_stock_adjustment/domain/product_stock_adjustment.dart';
import 'package:gym_system/src/features/product_stock_adjustment/presentation/controllers/product_stock_adjustment_controller.dart';
import 'package:gym_system/src/features/product_stocks/domain/product_stock.dart';
import 'package:gym_system/src/features/product_stocks/presentation/controllers/product_stock_controller.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/presentation/controllers/product_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_stock_adjustment_form_controller.g.dart';

class ProductStockAdjustmentFormState {
  final ProductStockAdjustment? productStockAdjustment;
  final ProductStock? productStock;
  final Product? product;

  ProductStockAdjustmentFormState({
    this.productStockAdjustment,
    this.productStock,
    this.product,
  });
}

@riverpod
class ProductStockAdjustmentFormController
    extends _$ProductStockAdjustmentFormController {
  @override
  Future<ProductStockAdjustmentFormState> build({
    String? id,
    String? productId,
    String? productStockId,
  }) async {
    final result = await TaskResult.Do(($) async {
      final productStock = productStockId is String
          ? await ref
              .watch(productStockControllerProvider(productStockId!).future)
          : null;

      final productState = productId is String
          ? await ref.watch(productControllerProvider(productId).future)
          : null;

      if (id == null) {
        return ProductStockAdjustmentFormState(
          productStockAdjustment: null,
          productStock: productStock,
          product: productState?.product,
        );
      }

      final productStockAdjustment =
          await ref.watch(productStockAdjustmentControllerProvider(id).future);
      return ProductStockAdjustmentFormState(
        productStockAdjustment: productStockAdjustment,
        productStock: productStock,
        product: productState?.product,
      );
    }).run();

    return result.fold(Future.error, Future.value);
  }
}
