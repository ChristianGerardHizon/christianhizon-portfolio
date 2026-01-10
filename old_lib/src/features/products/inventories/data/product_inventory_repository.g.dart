// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_inventory_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(productInventoryRepository)
final productInventoryRepositoryProvider =
    ProductInventoryRepositoryProvider._();

final class ProductInventoryRepositoryProvider extends $FunctionalProvider<
        PBViewRepository<ProductInventory>,
        PBViewRepository<ProductInventory>,
        PBViewRepository<ProductInventory>>
    with $Provider<PBViewRepository<ProductInventory>> {
  ProductInventoryRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'productInventoryRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productInventoryRepositoryHash();

  @$internal
  @override
  $ProviderElement<PBViewRepository<ProductInventory>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PBViewRepository<ProductInventory> create(Ref ref) {
    return productInventoryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PBViewRepository<ProductInventory> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PBViewRepository<ProductInventory>>(value),
    );
  }
}

String _$productInventoryRepositoryHash() =>
    r'1a55b6b315022f5c050448de796f88d04d3e503d';
