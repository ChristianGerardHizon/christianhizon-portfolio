import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_controller.g.dart';

@riverpod
class ProductController extends _$ProductController {
  @override
  Future<Product> build(String id) async {
    final repo = ref.read(productRepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
