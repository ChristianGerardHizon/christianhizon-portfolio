// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productTableControllerHash() =>
    r'95114be19bb4515032b2f9456c4e2df2a8eb6976';

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

abstract class _$ProductTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<Product>> {
  late final String tableKey;

  FutureOr<List<Product>> build(
    String tableKey,
  );
}

/// See also [ProductTableController].
@ProviderFor(ProductTableController)
const productTableControllerProvider = ProductTableControllerFamily();

/// See also [ProductTableController].
class ProductTableControllerFamily extends Family<AsyncValue<List<Product>>> {
  /// See also [ProductTableController].
  const ProductTableControllerFamily();

  /// See also [ProductTableController].
  ProductTableControllerProvider call(
    String tableKey,
  ) {
    return ProductTableControllerProvider(
      tableKey,
    );
  }

  @override
  ProductTableControllerProvider getProviderOverride(
    covariant ProductTableControllerProvider provider,
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
  String? get name => r'productTableControllerProvider';
}

/// See also [ProductTableController].
class ProductTableControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProductTableController,
        List<Product>> {
  /// See also [ProductTableController].
  ProductTableControllerProvider(
    String tableKey,
  ) : this._internal(
          () => ProductTableController()..tableKey = tableKey,
          from: productTableControllerProvider,
          name: r'productTableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productTableControllerHash,
          dependencies: ProductTableControllerFamily._dependencies,
          allTransitiveDependencies:
              ProductTableControllerFamily._allTransitiveDependencies,
          tableKey: tableKey,
        );

  ProductTableControllerProvider._internal(
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
  FutureOr<List<Product>> runNotifierBuild(
    covariant ProductTableController notifier,
  ) {
    return notifier.build(
      tableKey,
    );
  }

  @override
  Override overrideWith(ProductTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductTableControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ProductTableController, List<Product>>
      createElement() {
    return _ProductTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductTableControllerProvider &&
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
mixin ProductTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<Product>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;
}

class _ProductTableControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProductTableController,
        List<Product>> with ProductTableControllerRef {
  _ProductTableControllerProviderElement(super.provider);

  @override
  String get tableKey => (origin as ProductTableControllerProvider).tableKey;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
