// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(productRepository)
final productRepositoryProvider = ProductRepositoryProvider._();

final class ProductRepositoryProvider extends $FunctionalProvider<
        PBCollectionRepository<Product>,
        PBCollectionRepository<Product>,
        PBCollectionRepository<Product>>
    with $Provider<PBCollectionRepository<Product>> {
  ProductRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'productRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productRepositoryHash();

  @$internal
  @override
  $ProviderElement<PBCollectionRepository<Product>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PBCollectionRepository<Product> create(Ref ref) {
    return productRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PBCollectionRepository<Product> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PBCollectionRepository<Product>>(value),
    );
  }
}

String _$productRepositoryHash() => r'd6e5ac5c5a6692e8d0cdd15ba76fd64870a1bb36';
