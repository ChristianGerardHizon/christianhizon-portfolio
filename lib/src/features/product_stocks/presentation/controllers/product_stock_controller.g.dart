// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_stock_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productStockControllerHash() =>
    r'519cb593ac500c7463a76bab2b282ebb4f25afac';

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

abstract class _$ProductStockController
    extends BuildlessAutoDisposeAsyncNotifier<ProductStock> {
  late final String id;

  FutureOr<ProductStock> build(
    String id,
  );
}

/// See also [ProductStockController].
@ProviderFor(ProductStockController)
const productStockControllerProvider = ProductStockControllerFamily();

/// See also [ProductStockController].
class ProductStockControllerFamily extends Family<AsyncValue<ProductStock>> {
  /// See also [ProductStockController].
  const ProductStockControllerFamily();

  /// See also [ProductStockController].
  ProductStockControllerProvider call(
    String id,
  ) {
    return ProductStockControllerProvider(
      id,
    );
  }

  @override
  ProductStockControllerProvider getProviderOverride(
    covariant ProductStockControllerProvider provider,
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
  String? get name => r'productStockControllerProvider';
}

/// See also [ProductStockController].
class ProductStockControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProductStockController,
        ProductStock> {
  /// See also [ProductStockController].
  ProductStockControllerProvider(
    String id,
  ) : this._internal(
          () => ProductStockController()..id = id,
          from: productStockControllerProvider,
          name: r'productStockControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productStockControllerHash,
          dependencies: ProductStockControllerFamily._dependencies,
          allTransitiveDependencies:
              ProductStockControllerFamily._allTransitiveDependencies,
          id: id,
        );

  ProductStockControllerProvider._internal(
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
  FutureOr<ProductStock> runNotifierBuild(
    covariant ProductStockController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ProductStockController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductStockControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ProductStockController, ProductStock>
      createElement() {
    return _ProductStockControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductStockControllerProvider && other.id == id;
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
mixin ProductStockControllerRef
    on AutoDisposeAsyncNotifierProviderRef<ProductStock> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductStockControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProductStockController,
        ProductStock> with ProductStockControllerRef {
  _ProductStockControllerProviderElement(super.provider);

  @override
  String get id => (origin as ProductStockControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
