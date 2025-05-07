// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_stock_adjustment_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productStockAdjustmentTableControllerHash() =>
    r'833fd227e2eb8271bf9be70d6ca05e3205c3e5b1';

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

abstract class _$ProductStockAdjustmentTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<ProductStockAdjustment>> {
  late final String tableKey;

  FutureOr<List<ProductStockAdjustment>> build(
    String tableKey,
  );
}

/// See also [ProductStockAdjustmentTableController].
@ProviderFor(ProductStockAdjustmentTableController)
const productStockAdjustmentTableControllerProvider =
    ProductStockAdjustmentTableControllerFamily();

/// See also [ProductStockAdjustmentTableController].
class ProductStockAdjustmentTableControllerFamily
    extends Family<AsyncValue<List<ProductStockAdjustment>>> {
  /// See also [ProductStockAdjustmentTableController].
  const ProductStockAdjustmentTableControllerFamily();

  /// See also [ProductStockAdjustmentTableController].
  ProductStockAdjustmentTableControllerProvider call(
    String tableKey,
  ) {
    return ProductStockAdjustmentTableControllerProvider(
      tableKey,
    );
  }

  @override
  ProductStockAdjustmentTableControllerProvider getProviderOverride(
    covariant ProductStockAdjustmentTableControllerProvider provider,
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
  String? get name => r'productStockAdjustmentTableControllerProvider';
}

/// See also [ProductStockAdjustmentTableController].
class ProductStockAdjustmentTableControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        ProductStockAdjustmentTableController, List<ProductStockAdjustment>> {
  /// See also [ProductStockAdjustmentTableController].
  ProductStockAdjustmentTableControllerProvider(
    String tableKey,
  ) : this._internal(
          () => ProductStockAdjustmentTableController()..tableKey = tableKey,
          from: productStockAdjustmentTableControllerProvider,
          name: r'productStockAdjustmentTableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productStockAdjustmentTableControllerHash,
          dependencies:
              ProductStockAdjustmentTableControllerFamily._dependencies,
          allTransitiveDependencies: ProductStockAdjustmentTableControllerFamily
              ._allTransitiveDependencies,
          tableKey: tableKey,
        );

  ProductStockAdjustmentTableControllerProvider._internal(
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
  FutureOr<List<ProductStockAdjustment>> runNotifierBuild(
    covariant ProductStockAdjustmentTableController notifier,
  ) {
    return notifier.build(
      tableKey,
    );
  }

  @override
  Override overrideWith(
      ProductStockAdjustmentTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductStockAdjustmentTableControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ProductStockAdjustmentTableController,
      List<ProductStockAdjustment>> createElement() {
    return _ProductStockAdjustmentTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductStockAdjustmentTableControllerProvider &&
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
mixin ProductStockAdjustmentTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<ProductStockAdjustment>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;
}

class _ProductStockAdjustmentTableControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        ProductStockAdjustmentTableController, List<ProductStockAdjustment>>
    with ProductStockAdjustmentTableControllerRef {
  _ProductStockAdjustmentTableControllerProviderElement(super.provider);

  @override
  String get tableKey =>
      (origin as ProductStockAdjustmentTableControllerProvider).tableKey;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
