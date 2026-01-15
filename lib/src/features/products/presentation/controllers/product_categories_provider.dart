import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/product_category_repository.dart';
import '../../domain/product_category.dart';

part 'product_categories_provider.g.dart';

/// Provider for all product categories.
@riverpod
Future<List<ProductCategory>> productCategories(Ref ref) async {
  final repository = ref.read(productCategoryRepositoryProvider);
  final result = await repository.fetchAll();

  return result.fold(
    (failure) => [],
    (categories) => categories,
  );
}

/// Provider for product categories by parent ID.
@riverpod
Future<List<ProductCategory>> productCategoriesByParent(
  Ref ref,
  String? parentId,
) async {
  final repository = ref.read(productCategoryRepositoryProvider);
  final result = await repository.fetchByParent(parentId);

  return result.fold(
    (failure) => [],
    (categories) => categories,
  );
}
