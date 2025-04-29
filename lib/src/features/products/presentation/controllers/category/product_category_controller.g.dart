// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productCategoryControllerHash() =>
    r'1012b1e1dcd77e98be225354f14cb9ba61c3e7ce';

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

abstract class _$ProductCategoryController
    extends BuildlessAutoDisposeAsyncNotifier<ProductCategoryState> {
  late final String id;

  FutureOr<ProductCategoryState> build(
    String id,
  );
}

/// See also [ProductCategoryController].
@ProviderFor(ProductCategoryController)
const productCategoryControllerProvider = ProductCategoryControllerFamily();

/// See also [ProductCategoryController].
class ProductCategoryControllerFamily
    extends Family<AsyncValue<ProductCategoryState>> {
  /// See also [ProductCategoryController].
  const ProductCategoryControllerFamily();

  /// See also [ProductCategoryController].
  ProductCategoryControllerProvider call(
    String id,
  ) {
    return ProductCategoryControllerProvider(
      id,
    );
  }

  @override
  ProductCategoryControllerProvider getProviderOverride(
    covariant ProductCategoryControllerProvider provider,
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
  String? get name => r'productCategoryControllerProvider';
}

/// See also [ProductCategoryController].
class ProductCategoryControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProductCategoryController,
        ProductCategoryState> {
  /// See also [ProductCategoryController].
  ProductCategoryControllerProvider(
    String id,
  ) : this._internal(
          () => ProductCategoryController()..id = id,
          from: productCategoryControllerProvider,
          name: r'productCategoryControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productCategoryControllerHash,
          dependencies: ProductCategoryControllerFamily._dependencies,
          allTransitiveDependencies:
              ProductCategoryControllerFamily._allTransitiveDependencies,
          id: id,
        );

  ProductCategoryControllerProvider._internal(
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
  FutureOr<ProductCategoryState> runNotifierBuild(
    covariant ProductCategoryController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ProductCategoryController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductCategoryControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ProductCategoryController,
      ProductCategoryState> createElement() {
    return _ProductCategoryControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductCategoryControllerProvider && other.id == id;
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
mixin ProductCategoryControllerRef
    on AutoDisposeAsyncNotifierProviderRef<ProductCategoryState> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductCategoryControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProductCategoryController,
        ProductCategoryState> with ProductCategoryControllerRef {
  _ProductCategoryControllerProviderElement(super.provider);

  @override
  String get id => (origin as ProductCategoryControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
