// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(productCategoryRepository)
final productCategoryRepositoryProvider = ProductCategoryRepositoryProvider._();

final class ProductCategoryRepositoryProvider extends $FunctionalProvider<
        PBCollectionRepository<ProductCategory>,
        PBCollectionRepository<ProductCategory>,
        PBCollectionRepository<ProductCategory>>
    with $Provider<PBCollectionRepository<ProductCategory>> {
  ProductCategoryRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'productCategoryRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productCategoryRepositoryHash();

  @$internal
  @override
  $ProviderElement<PBCollectionRepository<ProductCategory>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PBCollectionRepository<ProductCategory> create(Ref ref) {
    return productCategoryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PBCollectionRepository<ProductCategory> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PBCollectionRepository<ProductCategory>>(value),
    );
  }
}

String _$productCategoryRepositoryHash() =>
    r'2abf95ee033a0264b2bbc8e7e7f65e7f23f4a733';
