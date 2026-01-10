// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_stock_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(productStockRepository)
final productStockRepositoryProvider = ProductStockRepositoryProvider._();

final class ProductStockRepositoryProvider extends $FunctionalProvider<
        PBCollectionRepository<ProductStock>,
        PBCollectionRepository<ProductStock>,
        PBCollectionRepository<ProductStock>>
    with $Provider<PBCollectionRepository<ProductStock>> {
  ProductStockRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'productStockRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productStockRepositoryHash();

  @$internal
  @override
  $ProviderElement<PBCollectionRepository<ProductStock>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PBCollectionRepository<ProductStock> create(Ref ref) {
    return productStockRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PBCollectionRepository<ProductStock> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PBCollectionRepository<ProductStock>>(value),
    );
  }
}

String _$productStockRepositoryHash() =>
    r'0e8160b3437e8a1f678731961fabe6d484e799ba';
