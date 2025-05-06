// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_stock_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productStockTableControllerHash() =>
    r'ffcad5543896ae6f7338c34c926977df7697a088';

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

abstract class _$ProductStockTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<ProductStock>> {
  late final String tableKey;
  late final String productId;

  FutureOr<List<ProductStock>> build(
    String tableKey,
    String productId,
  );
}

/// See also [ProductStockTableController].
@ProviderFor(ProductStockTableController)
const productStockTableControllerProvider = ProductStockTableControllerFamily();

/// See also [ProductStockTableController].
class ProductStockTableControllerFamily
    extends Family<AsyncValue<List<ProductStock>>> {
  /// See also [ProductStockTableController].
  const ProductStockTableControllerFamily();

  /// See also [ProductStockTableController].
  ProductStockTableControllerProvider call(
    String tableKey,
    String productId,
  ) {
    return ProductStockTableControllerProvider(
      tableKey,
      productId,
    );
  }

  @override
  ProductStockTableControllerProvider getProviderOverride(
    covariant ProductStockTableControllerProvider provider,
  ) {
    return call(
      provider.tableKey,
      provider.productId,
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
  String? get name => r'productStockTableControllerProvider';
}

/// See also [ProductStockTableController].
class ProductStockTableControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProductStockTableController,
        List<ProductStock>> {
  /// See also [ProductStockTableController].
  ProductStockTableControllerProvider(
    String tableKey,
    String productId,
  ) : this._internal(
          () => ProductStockTableController()
            ..tableKey = tableKey
            ..productId = productId,
          from: productStockTableControllerProvider,
          name: r'productStockTableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productStockTableControllerHash,
          dependencies: ProductStockTableControllerFamily._dependencies,
          allTransitiveDependencies:
              ProductStockTableControllerFamily._allTransitiveDependencies,
          tableKey: tableKey,
          productId: productId,
        );

  ProductStockTableControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tableKey,
    required this.productId,
  }) : super.internal();

  final String tableKey;
  final String productId;

  @override
  FutureOr<List<ProductStock>> runNotifierBuild(
    covariant ProductStockTableController notifier,
  ) {
    return notifier.build(
      tableKey,
      productId,
    );
  }

  @override
  Override overrideWith(ProductStockTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductStockTableControllerProvider._internal(
        () => create()
          ..tableKey = tableKey
          ..productId = productId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tableKey: tableKey,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProductStockTableController,
      List<ProductStock>> createElement() {
    return _ProductStockTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductStockTableControllerProvider &&
        other.tableKey == tableKey &&
        other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tableKey.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductStockTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<ProductStock>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;

  /// The parameter `productId` of this provider.
  String get productId;
}

class _ProductStockTableControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProductStockTableController,
        List<ProductStock>> with ProductStockTableControllerRef {
  _ProductStockTableControllerProviderElement(super.provider);

  @override
  String get tableKey =>
      (origin as ProductStockTableControllerProvider).tableKey;
  @override
  String get productId =>
      (origin as ProductStockTableControllerProvider).productId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
