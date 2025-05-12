import 'package:dart_mappable/dart_mappable.dart';
import 'package:gym_system/src/core/models/pb_file.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/models/type_defs.dart';
import 'package:gym_system/src/core/utils/pb_utils.dart';
import 'package:gym_system/src/features/branches/domain/branch.dart';
import 'package:gym_system/src/features/branches/presentation/controllers/branches_controller.dart';
import 'package:gym_system/src/features/product_categories/presentation/controllers/product_categories_controller.dart';
import 'package:gym_system/src/features/products/data/product_repository.dart';
import 'package:gym_system/src/features/products/domain/product.dart';
import 'package:gym_system/src/features/product_categories/domain/product_category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_form_controller.g.dart';
part 'product_form_controller.mapper.dart';

@MappableClass()
class ProductFormState with ProductFormStateMappable {
  final Product? product;
  final List<Branch> branches;
  final List<PBFile>? images;
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
      final branches = await ref.watch(branchesControllerProvider.future);
      final categories =
          await ref.watch(productCategoriesControllerProvider.future);

      if (id == null) {
        return ProductFormState(
          product: null,
          branches: branches,
          images: null,
          categories: categories,
        );
      }

      final product = await $(productRepo.get(id));
      final domain = ref.read(pocketbaseProvider).baseURL;
      final images = await $(_buildInitialImages(product, domain));

      return ProductFormState(
        product: product,
        branches: branches,
        images: images,
        categories: categories,
      );
    }).run();

    return result.fold(Future.error, Future.value);
  }
}

TaskResult<List<PBFile>?> _buildInitialImages(Product? product, String domain) {
  return TaskResult.tryCatch(() async {
    if (product == null || !product.hasImage) {
      return null;
    }

    final imageUri = PBUtils.imageBuilder(
      collection: product.collectionId,
      domain: domain,
      fileName: product.image!,
      id: product.id,
    );

    if (imageUri == null) {
      return null;
    }

    return [
      PBNetworkFile(
        fileName: product.image!,
        uri: imageUri,
        field: ProductField.image,
        id: product.id,
      )
    ];
  }, Failure.handle);
}
