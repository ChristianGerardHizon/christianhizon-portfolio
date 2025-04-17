// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_stock_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productStockFormControllerHash() =>
    r'7a2794f2572edb6afb960bd0b6589c26a7c5bcdd';

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

abstract class _$ProductStockFormController
    extends BuildlessAutoDisposeAsyncNotifier<ProductStockFormState> {
  late final String? id;
  late final String productId;

  FutureOr<ProductStockFormState> build(
    String? id,
    String productId,
  );
}

/// See also [ProductStockFormController].
@ProviderFor(ProductStockFormController)
const productStockFormControllerProvider = ProductStockFormControllerFamily();

/// See also [ProductStockFormController].
class ProductStockFormControllerFamily
    extends Family<AsyncValue<ProductStockFormState>> {
  /// See also [ProductStockFormController].
  const ProductStockFormControllerFamily();

  /// See also [ProductStockFormController].
  ProductStockFormControllerProvider call(
    String? id,
    String productId,
  ) {
    return ProductStockFormControllerProvider(
      id,
      productId,
    );
  }

  @override
  ProductStockFormControllerProvider getProviderOverride(
    covariant ProductStockFormControllerProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'productStockFormControllerProvider';
}

/// See also [ProductStockFormController].
class ProductStockFormControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProductStockFormController,
        ProductStockFormState> {
  /// See also [ProductStockFormController].
  ProductStockFormControllerProvider(
    String? id,
    String productId,
  ) : this._internal(
          () => ProductStockFormController()
            ..id = id
            ..productId = productId,
          from: productStockFormControllerProvider,
          name: r'productStockFormControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productStockFormControllerHash,
          dependencies: ProductStockFormControllerFamily._dependencies,
          allTransitiveDependencies:
              ProductStockFormControllerFamily._allTransitiveDependencies,
          id: id,
          productId: productId,
        );

  ProductStockFormControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.productId,
  }) : super.internal();

  final String? id;
  final String productId;

  @override
  FutureOr<ProductStockFormState> runNotifierBuild(
    covariant ProductStockFormController notifier,
  ) {
    return notifier.build(
      id,
      productId,
    );
  }

  @override
  Override overrideWith(ProductStockFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductStockFormControllerProvider._internal(
        () => create()
          ..id = id
          ..productId = productId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProductStockFormController,
      ProductStockFormState> createElement() {
    return _ProductStockFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductStockFormControllerProvider &&
        other.id == id &&
        other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductStockFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<ProductStockFormState> {
  /// The parameter `id` of this provider.
  String? get id;

  /// The parameter `productId` of this provider.
  String get productId;
}

class _ProductStockFormControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProductStockFormController,
        ProductStockFormState> with ProductStockFormControllerRef {
  _ProductStockFormControllerProviderElement(super.provider);

  @override
  String? get id => (origin as ProductStockFormControllerProvider).id;
  @override
  String get productId =>
      (origin as ProductStockFormControllerProvider).productId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
