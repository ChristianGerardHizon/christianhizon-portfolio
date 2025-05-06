// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_inventory_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productInventoryTableControllerHash() =>
    r'672edbeb6989ada08cd27d4d917619cd2a973605';

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

abstract class _$ProductInventoryTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<ProductInventory>> {
  late final String tableKey;

  FutureOr<List<ProductInventory>> build(
    String tableKey,
  );
}

/// See also [ProductInventoryTableController].
@ProviderFor(ProductInventoryTableController)
const productInventoryTableControllerProvider =
    ProductInventoryTableControllerFamily();

/// See also [ProductInventoryTableController].
class ProductInventoryTableControllerFamily
    extends Family<AsyncValue<List<ProductInventory>>> {
  /// See also [ProductInventoryTableController].
  const ProductInventoryTableControllerFamily();

  /// See also [ProductInventoryTableController].
  ProductInventoryTableControllerProvider call(
    String tableKey,
  ) {
    return ProductInventoryTableControllerProvider(
      tableKey,
    );
  }

  @override
  ProductInventoryTableControllerProvider getProviderOverride(
    covariant ProductInventoryTableControllerProvider provider,
  ) {
    return call(
      provider.tableKey,
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
  String? get name => r'productInventoryTableControllerProvider';
}

/// See also [ProductInventoryTableController].
class ProductInventoryTableControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        ProductInventoryTableController, List<ProductInventory>> {
  /// See also [ProductInventoryTableController].
  ProductInventoryTableControllerProvider(
    String tableKey,
  ) : this._internal(
          () => ProductInventoryTableController()..tableKey = tableKey,
          from: productInventoryTableControllerProvider,
          name: r'productInventoryTableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productInventoryTableControllerHash,
          dependencies: ProductInventoryTableControllerFamily._dependencies,
          allTransitiveDependencies:
              ProductInventoryTableControllerFamily._allTransitiveDependencies,
          tableKey: tableKey,
        );

  ProductInventoryTableControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tableKey,
  }) : super.internal();

  final String tableKey;

  @override
  FutureOr<List<ProductInventory>> runNotifierBuild(
    covariant ProductInventoryTableController notifier,
  ) {
    return notifier.build(
      tableKey,
    );
  }

  @override
  Override overrideWith(ProductInventoryTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductInventoryTableControllerProvider._internal(
        () => create()..tableKey = tableKey,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tableKey: tableKey,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProductInventoryTableController,
      List<ProductInventory>> createElement() {
    return _ProductInventoryTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductInventoryTableControllerProvider &&
        other.tableKey == tableKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tableKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductInventoryTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<ProductInventory>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;
}

class _ProductInventoryTableControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        ProductInventoryTableController,
        List<ProductInventory>> with ProductInventoryTableControllerRef {
  _ProductInventoryTableControllerProviderElement(super.provider);

  @override
  String get tableKey =>
      (origin as ProductInventoryTableControllerProvider).tableKey;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
