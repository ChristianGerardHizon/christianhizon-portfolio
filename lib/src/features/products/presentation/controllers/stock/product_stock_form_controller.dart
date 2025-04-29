import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/data/product_stock_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/domain/product_stock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_stock_form_controller.g.dart';
part 'product_stock_form_controller.mapper.dart';

@MappableClass()
class ProductStockFormState with ProductStockFormStateMappable {
  final Product product;
  final ProductStock? productStock;

  ProductStockFormState({
    required this.product,
    this.productStock,
  });
}

@riverpod
class ProductStockFormController extends _$ProductStockFormController {
  @override
  Future<ProductStockFormState> build(String? id, String productId) async {
    final productRepo = ref.read(productRepositoryProvider);
    final productStockRepo = ref.read(productStockRepositoryProvider);

    final result = await TaskResult.Do(($) async {
      final product = await $(productRepo.get(productId));

      if (id == null) {
        return ProductStockFormState(
          product: product,
        );
      }

      final productStock = await $(productStockRepo.get(id));
      return ProductStockFormState(
        product: product,
        productStock: productStock,
      );
    }).run();

    return result.fold(Future.error, Future.value);
  }
}
