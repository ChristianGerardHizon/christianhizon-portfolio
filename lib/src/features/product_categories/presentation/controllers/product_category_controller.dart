import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/features/product_categories/data/product_category_repository.dart';
import 'package:gym_system/src/features/product_categories/domain/product_category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_category_controller.g.dart';

class ProductCategoryState {
  final ProductCategory productCategory;

  ProductCategoryState(this.productCategory);
}

@riverpod
class ProductCategoryController extends _$ProductCategoryController {
  @override
  Future<ProductCategoryState> build(String id) async {
    final result = await TaskResult.Do(($) async {
      final productCategory = await $(_getProductCategory(id));

      return ProductCategoryState(productCategory);
    }).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }

  TaskResult<ProductCategory> _getProductCategory(String id) {
    return TaskResult.tryCatch(() async {
      final repo = ref.read(productCategoryRepositoryProvider);
      final result = await repo.get(id).run();
      return result.fold(Future.error, (x) => Future.value(x));
    }, Failure.handle);
  }
}
