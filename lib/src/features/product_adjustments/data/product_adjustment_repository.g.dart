// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_adjustment_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(productAdjustmentRepository)
final productAdjustmentRepositoryProvider =
    ProductAdjustmentRepositoryProvider._();

final class ProductAdjustmentRepositoryProvider extends $FunctionalProvider<
        PBCollectionRepository<ProductAdjustment>,
        PBCollectionRepository<ProductAdjustment>,
        PBCollectionRepository<ProductAdjustment>>
    with $Provider<PBCollectionRepository<ProductAdjustment>> {
  ProductAdjustmentRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'productAdjustmentRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productAdjustmentRepositoryHash();

  @$internal
  @override
  $ProviderElement<PBCollectionRepository<ProductAdjustment>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PBCollectionRepository<ProductAdjustment> create(Ref ref) {
    return productAdjustmentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PBCollectionRepository<ProductAdjustment> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PBCollectionRepository<ProductAdjustment>>(value),
    );
  }
}

String _$productAdjustmentRepositoryHash() =>
    r'0766a7ef51b2dd3e5cec17514c3361004bc17754';
