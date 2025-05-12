// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_adjustment_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productAdjustmentTableControllerHash() =>
    r'd4644bb5f0a165da960470d5ad226d2003cd0663';

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

abstract class _$ProductAdjustmentTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<ProductAdjustment>> {
  late final String tableKey;
  late final String? productId;
  late final String? productStockId;

  FutureOr<List<ProductAdjustment>> build(
    String tableKey, {
    String? productId,
    String? productStockId,
  });
}

/// See also [ProductAdjustmentTableController].
@ProviderFor(ProductAdjustmentTableController)
const productAdjustmentTableControllerProvider =
    ProductAdjustmentTableControllerFamily();

/// See also [ProductAdjustmentTableController].
class ProductAdjustmentTableControllerFamily
    extends Family<AsyncValue<List<ProductAdjustment>>> {
  /// See also [ProductAdjustmentTableController].
  const ProductAdjustmentTableControllerFamily();

  /// See also [ProductAdjustmentTableController].
  ProductAdjustmentTableControllerProvider call(
    String tableKey, {
    String? productId,
    String? productStockId,
  }) {
    return ProductAdjustmentTableControllerProvider(
      tableKey,
      productId: productId,
      productStockId: productStockId,
    );
  }

  @override
  ProductAdjustmentTableControllerProvider getProviderOverride(
    covariant ProductAdjustmentTableControllerProvider provider,
  ) {
    return call(
      provider.tableKey,
      productId: provider.productId,
      productStockId: provider.productStockId,
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
  String? get name => r'productAdjustmentTableControllerProvider';
}

/// See also [ProductAdjustmentTableController].
class ProductAdjustmentTableControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        ProductAdjustmentTableController, List<ProductAdjustment>> {
  /// See also [ProductAdjustmentTableController].
  ProductAdjustmentTableControllerProvider(
    String tableKey, {
    String? productId,
    String? productStockId,
  }) : this._internal(
          () => ProductAdjustmentTableController()
            ..tableKey = tableKey
            ..productId = productId
            ..productStockId = productStockId,
          from: productAdjustmentTableControllerProvider,
          name: r'productAdjustmentTableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productAdjustmentTableControllerHash,
          dependencies: ProductAdjustmentTableControllerFamily._dependencies,
          allTransitiveDependencies:
              ProductAdjustmentTableControllerFamily._allTransitiveDependencies,
          tableKey: tableKey,
          productId: productId,
          productStockId: productStockId,
        );

  ProductAdjustmentTableControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tableKey,
    required this.productId,
    required this.productStockId,
  }) : super.internal();

  final String tableKey;
  final String? productId;
  final String? productStockId;

  @override
  FutureOr<List<ProductAdjustment>> runNotifierBuild(
    covariant ProductAdjustmentTableController notifier,
  ) {
    return notifier.build(
      tableKey,
      productId: productId,
      productStockId: productStockId,
    );
  }

  @override
  Override overrideWith(ProductAdjustmentTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductAdjustmentTableControllerProvider._internal(
        () => create()
          ..tableKey = tableKey
          ..productId = productId
          ..productStockId = productStockId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tableKey: tableKey,
        productId: productId,
        productStockId: productStockId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProductAdjustmentTableController,
      List<ProductAdjustment>> createElement() {
    return _ProductAdjustmentTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductAdjustmentTableControllerProvider &&
        other.tableKey == tableKey &&
        other.productId == productId &&
        other.productStockId == productStockId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tableKey.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);
    hash = _SystemHash.combine(hash, productStockId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductAdjustmentTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<ProductAdjustment>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;

  /// The parameter `productId` of this provider.
  String? get productId;

  /// The parameter `productStockId` of this provider.
  String? get productStockId;
}

class _ProductAdjustmentTableControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        ProductAdjustmentTableController,
        List<ProductAdjustment>> with ProductAdjustmentTableControllerRef {
  _ProductAdjustmentTableControllerProviderElement(super.provider);

  @override
  String get tableKey =>
      (origin as ProductAdjustmentTableControllerProvider).tableKey;
  @override
  String? get productId =>
      (origin as ProductAdjustmentTableControllerProvider).productId;
  @override
  String? get productStockId =>
      (origin as ProductAdjustmentTableControllerProvider).productStockId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
