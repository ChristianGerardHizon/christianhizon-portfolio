// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_categories_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductCategoriesController)
final productCategoriesControllerProvider =
    ProductCategoriesControllerProvider._();

final class ProductCategoriesControllerProvider extends $AsyncNotifierProvider<
    ProductCategoriesController, List<ProductCategory>> {
  ProductCategoriesControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'productCategoriesControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productCategoriesControllerHash();

  @$internal
  @override
  ProductCategoriesController create() => ProductCategoriesController();
}

String _$productCategoriesControllerHash() =>
    r'793e5c3beb5bddf19f216f24f35ea746d4bc227a';

abstract class _$ProductCategoriesController
    extends $AsyncNotifier<List<ProductCategory>> {
  FutureOr<List<ProductCategory>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<List<ProductCategory>>, List<ProductCategory>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<ProductCategory>>, List<ProductCategory>>,
        AsyncValue<List<ProductCategory>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
