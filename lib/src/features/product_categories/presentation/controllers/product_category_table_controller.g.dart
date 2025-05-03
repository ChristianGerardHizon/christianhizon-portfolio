// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productCategoryTableControllerHash() =>
    r'2ea5d9545afd344f48531620ffd391bb824d1082';

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

abstract class _$ProductCategoryTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<ProductCategory>> {
  late final String tableKey;

  FutureOr<List<ProductCategory>> build(
    String tableKey,
  );
}

/// See also [ProductCategoryTableController].
@ProviderFor(ProductCategoryTableController)
const productCategoryTableControllerProvider =
    ProductCategoryTableControllerFamily();

/// See also [ProductCategoryTableController].
class ProductCategoryTableControllerFamily
    extends Family<AsyncValue<List<ProductCategory>>> {
  /// See also [ProductCategoryTableController].
  const ProductCategoryTableControllerFamily();

  /// See also [ProductCategoryTableController].
  ProductCategoryTableControllerProvider call(
    String tableKey,
  ) {
    return ProductCategoryTableControllerProvider(
      tableKey,
    );
  }

  @override
  ProductCategoryTableControllerProvider getProviderOverride(
    covariant ProductCategoryTableControllerProvider provider,
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
  String? get name => r'productCategoryTableControllerProvider';
}

/// See also [ProductCategoryTableController].
class ProductCategoryTableControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProductCategoryTableController,
        List<ProductCategory>> {
  /// See also [ProductCategoryTableController].
  ProductCategoryTableControllerProvider(
    String tableKey,
  ) : this._internal(
          () => ProductCategoryTableController()..tableKey = tableKey,
          from: productCategoryTableControllerProvider,
          name: r'productCategoryTableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productCategoryTableControllerHash,
          dependencies: ProductCategoryTableControllerFamily._dependencies,
          allTransitiveDependencies:
              ProductCategoryTableControllerFamily._allTransitiveDependencies,
          tableKey: tableKey,
        );

  ProductCategoryTableControllerProvider._internal(
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
  FutureOr<List<ProductCategory>> runNotifierBuild(
    covariant ProductCategoryTableController notifier,
  ) {
    return notifier.build(
      tableKey,
    );
  }

  @override
  Override overrideWith(ProductCategoryTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductCategoryTableControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ProductCategoryTableController,
      List<ProductCategory>> createElement() {
    return _ProductCategoryTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductCategoryTableControllerProvider &&
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
mixin ProductCategoryTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<ProductCategory>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;
}

class _ProductCategoryTableControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        ProductCategoryTableController,
        List<ProductCategory>> with ProductCategoryTableControllerRef {
  _ProductCategoryTableControllerProviderElement(super.provider);

  @override
  String get tableKey =>
      (origin as ProductCategoryTableControllerProvider).tableKey;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
