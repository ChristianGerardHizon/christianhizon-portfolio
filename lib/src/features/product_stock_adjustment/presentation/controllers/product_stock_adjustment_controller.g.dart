// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_stock_adjustment_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productStockAdjustmentControllerHash() =>
    r'b1a133ff96e58371025b8abd0b6a842f01271ed7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ProductStockAdjustmentController
    extends BuildlessAutoDisposeAsyncNotifier<ProductStockAdjustment> {
  late final String id;

  FutureOr<ProductStockAdjustment> build(
    String id,
  );
}

/// See also [ProductStockAdjustmentController].
@ProviderFor(ProductStockAdjustmentController)
const productStockAdjustmentControllerProvider =
    ProductStockAdjustmentControllerFamily();

/// See also [ProductStockAdjustmentController].
class ProductStockAdjustmentControllerFamily
    extends Family<AsyncValue<ProductStockAdjustment>> {
  /// See also [ProductStockAdjustmentController].
  const ProductStockAdjustmentControllerFamily();

  /// See also [ProductStockAdjustmentController].
  ProductStockAdjustmentControllerProvider call(
    String id,
  ) {
    return ProductStockAdjustmentControllerProvider(
      id,
    );
  }

  @override
  ProductStockAdjustmentControllerProvider getProviderOverride(
    covariant ProductStockAdjustmentControllerProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productStockAdjustmentControllerProvider';
}

/// See also [ProductStockAdjustmentController].
class ProductStockAdjustmentControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        ProductStockAdjustmentController, ProductStockAdjustment> {
  /// See also [ProductStockAdjustmentController].
  ProductStockAdjustmentControllerProvider(
    String id,
  ) : this._internal(
          () => ProductStockAdjustmentController()..id = id,
          from: productStockAdjustmentControllerProvider,
          name: r'productStockAdjustmentControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productStockAdjustmentControllerHash,
          dependencies: ProductStockAdjustmentControllerFamily._dependencies,
          allTransitiveDependencies:
              ProductStockAdjustmentControllerFamily._allTransitiveDependencies,
          id: id,
        );

  ProductStockAdjustmentControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<ProductStockAdjustment> runNotifierBuild(
    covariant ProductStockAdjustmentController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ProductStockAdjustmentController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductStockAdjustmentControllerProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProductStockAdjustmentController,
      ProductStockAdjustment> createElement() {
    return _ProductStockAdjustmentControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductStockAdjustmentControllerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductStockAdjustmentControllerRef
    on AutoDisposeAsyncNotifierProviderRef<ProductStockAdjustment> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductStockAdjustmentControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        ProductStockAdjustmentController,
        ProductStockAdjustment> with ProductStockAdjustmentControllerRef {
  _ProductStockAdjustmentControllerProviderElement(super.provider);

  @override
  String get id => (origin as ProductStockAdjustmentControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
