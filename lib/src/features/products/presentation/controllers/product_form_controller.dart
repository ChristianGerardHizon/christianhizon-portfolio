import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_form_controller.g.dart';

class ProductFormState {
  final Product? product;

  ProductFormState({required this.product});
}

@riverpod
class ProductFormController extends _$ProductFormController {
  @override
  Future<ProductFormState> build(String? id) async {
    final productRepo = ref.read(productRepositoryProvider);
    final result = await TaskResult.Do(($) async {
      if (id == null) {
        return ProductFormState(product: null);
      }
      final product = await $(productRepo.get(id));
      return ProductFormState(product: product);
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
