import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/classes/pb_image.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/branches/data/branch_repository.dart';
import 'package:gym_system/src/features/branches/domain/branch.dart';
import 'package:gym_system/src/features/products/data/product_category_repository.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/products/domain/product_category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_form_controller.g.dart';
part 'product_form_controller.mapper.dart';

@MappableClass()
class ProductFormState with ProductFormStateMappable {
  final Product? product;
  final List<Branch> branches;
  final List<PBImage>? images;
  final List<ProductCategory> categories;

  ProductFormState({
    required this.product,
    this.branches = const [],
    this.categories = const [],
    this.images,
  });
}

@riverpod
class ProductFormController extends _$ProductFormController {
  @override
  Future<ProductFormState> build(String? id) async {
    final productRepo = ref.read(productRepositoryProvider);

    final result = await TaskResult.Do(($) async {
      final branches = await $(_getBranches());
      final categories = await $(_getProductCategories());

      if (id == null) {
        return ProductFormState(
          product: null,
          branches: branches,
          images: null,
          categories: categories,
        );
      }

      final product = await $(productRepo.get(id));
      final images = await $(_buildInitialImages(product));

      return ProductFormState(
        product: product,
        branches: branches,
        images: images,
        categories: categories,
      );
    }).run();

    return result.fold(Future.error, Future.value);
  }

  TaskResult<List<Branch>> _getBranches() {
    return TaskResult.tryCatch(() async {
      final repo = ref.read(branchRepositoryProvider);
      final filter = '${BranchField.isDeleted} = false';
      final result = await repo.listAll(filter: filter).run();
      return result.fold(Future.error, Future.value);
    }, Failure.presentation);
  }

  TaskResult<List<ProductCategory>> _getProductCategories() {
    return TaskResult.tryCatch(() async {
      final repo = ref.read(productCategoryRepositoryProvider);
      final filter = '${CategoryField.isDeleted} = false';
      final result = await repo.listAll(filter: filter).run();
      return result.fold(Future.error, Future.value);
    }, Failure.presentation);
  }
}

TaskResult<List<PBImage>?> _buildInitialImages(Product? product) {
  return TaskResult.tryCatch(() async {
    if (product == null || !product.hasImage || product.imageUri == null) {
      return null;
    }

    return [
      PBNetworkImage(
        uri: product.imageUri!,
        field: ProductField.image,
        id: product.id,
      )
    ];
  }, Failure.presentation);
}
