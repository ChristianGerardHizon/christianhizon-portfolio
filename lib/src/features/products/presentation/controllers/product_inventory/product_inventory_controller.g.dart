// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_inventory_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productInventoryControllerHash() =>
    r'13f999366730c304e2c265eb806902477af90b69';

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

abstract class _$ProductInventoryController
    extends BuildlessAutoDisposeAsyncNotifier<ProductInventory> {
  late final String id;

  FutureOr<ProductInventory> build(
    String id,
  );
}

/// See also [ProductInventoryController].
@ProviderFor(ProductInventoryController)
const productInventoryControllerProvider = ProductInventoryControllerFamily();

/// See also [ProductInventoryController].
class ProductInventoryControllerFamily
    extends Family<AsyncValue<ProductInventory>> {
  /// See also [ProductInventoryController].
  const ProductInventoryControllerFamily();

  /// See also [ProductInventoryController].
  ProductInventoryControllerProvider call(
    String id,
  ) {
    return ProductInventoryControllerProvider(
      id,
    );
  }

  @override
  ProductInventoryControllerProvider getProviderOverride(
    covariant ProductInventoryControllerProvider provider,
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
  String? get name => r'productInventoryControllerProvider';
}

/// See also [ProductInventoryController].
class ProductInventoryControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProductInventoryController,
        ProductInventory> {
  /// See also [ProductInventoryController].
  ProductInventoryControllerProvider(
    String id,
  ) : this._internal(
          () => ProductInventoryController()..id = id,
          from: productInventoryControllerProvider,
          name: r'productInventoryControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productInventoryControllerHash,
          dependencies: ProductInventoryControllerFamily._dependencies,
          allTransitiveDependencies:
              ProductInventoryControllerFamily._allTransitiveDependencies,
          id: id,
        );

  ProductInventoryControllerProvider._internal(
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
  FutureOr<ProductInventory> runNotifierBuild(
    covariant ProductInventoryController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ProductInventoryController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductInventoryControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ProductInventoryController,
      ProductInventory> createElement() {
    return _ProductInventoryControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductInventoryControllerProvider && other.id == id;
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
mixin ProductInventoryControllerRef
    on AutoDisposeAsyncNotifierProviderRef<ProductInventory> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductInventoryControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProductInventoryController,
        ProductInventory> with ProductInventoryControllerRef {
  _ProductInventoryControllerProviderElement(super.provider);

  @override
  String get id => (origin as ProductInventoryControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
