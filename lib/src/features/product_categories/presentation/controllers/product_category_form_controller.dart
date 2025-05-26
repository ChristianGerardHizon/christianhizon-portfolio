import 'package:dart_mappable/dart_mappable.dart';
import 'package:sannjosevet/src/core/failures/failure.dart';
import 'package:sannjosevet/src/core/strings/fields.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:sannjosevet/src/features/product_categories/data/product_category_repository.dart';
import 'package:sannjosevet/src/features/product_categories/domain/product_category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_category_form_controller.g.dart';
part 'product_category_form_controller.mapper.dart';

@MappableClass()
class ProductCategoryFormState with ProductCategoryFormStateMappable {
  final ProductCategory? category;
  final List<ProductCategory> categories;

  ProductCategoryFormState({
    required this.category,
    this.categories = const [],
  });
}

@riverpod
class ProductCategoryFormController extends _$ProductCategoryFormController {
  @override
  Future<ProductCategoryFormState> build(String? id) async {
    final prodCategoryRepo = ref.read(productCategoryRepositoryProvider);

    final result = await TaskResult.Do(($) async {
      final categories = await $(_getProductCategoryCategories());

      if (id == null) {
        return ProductCategoryFormState(
          category: null,
          categories: categories,
        );
      }

      final category = await $(prodCategoryRepo.get(id));

      return ProductCategoryFormState(
        category: category,
      );
    }).run();

    return result.fold(Future.error, Future.value);
  }

  TaskResult<List<ProductCategory>> _getProductCategoryCategories() {
    return TaskResult.tryCatch(() async {
      final repo = ref.read(productCategoryRepositoryProvider);
      final filter = '${CategoryField.isDeleted} = false';
      final result = await repo.listAll(filter: filter).run();
      return result.fold(Future.error, Future.value);
    }, Failure.handle);
  }
}
