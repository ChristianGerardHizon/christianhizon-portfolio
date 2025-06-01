import 'package:sannjosevet/src/core/models/failure.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/features/product_categories/data/product_category_repository.dart';
import 'package:sannjosevet/src/features/product_categories/domain/product_category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_categories_controller.g.dart';

@riverpod
class ProductCategoriesController extends _$ProductCategoriesController {
  @override
  Future<List<ProductCategory>> build() async {
    final result = await TaskResult.Do(($) async {
      final productCategory = await $(_getProductCategory());

      return productCategory;
    }).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }

  TaskResult<List<ProductCategory>> _getProductCategory() {
    return TaskResult.tryCatch(() async {
      final repo = ref.read(productCategoryRepositoryProvider);
      final result = await repo.listAll().run();
      return result.fold(Future.error, (x) => Future.value(x));
    }, Failure.handle);
  }
}
