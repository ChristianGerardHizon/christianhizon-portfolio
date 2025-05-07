// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_stock_adjustment_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productStockAdjustmentFormControllerHash() =>
    r'2dc7188969a3c35a5f3038111b4b991e68dbee68';

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

abstract class _$ProductStockAdjustmentFormController
    extends BuildlessAutoDisposeAsyncNotifier<ProductStockAdjustmentFormState> {
  late final String? id;
  late final String? productId;
  late final String? productStockId;

  FutureOr<ProductStockAdjustmentFormState> build({
    String? id,
    String? productId,
    String? productStockId,
  });
}

/// See also [ProductStockAdjustmentFormController].
@ProviderFor(ProductStockAdjustmentFormController)
const productStockAdjustmentFormControllerProvider =
    ProductStockAdjustmentFormControllerFamily();

/// See also [ProductStockAdjustmentFormController].
class ProductStockAdjustmentFormControllerFamily
    extends Family<AsyncValue<ProductStockAdjustmentFormState>> {
  /// See also [ProductStockAdjustmentFormController].
  const ProductStockAdjustmentFormControllerFamily();

  /// See also [ProductStockAdjustmentFormController].
  ProductStockAdjustmentFormControllerProvider call({
    String? id,
    String? productId,
    String? productStockId,
  }) {
    return ProductStockAdjustmentFormControllerProvider(
      id: id,
      productId: productId,
      productStockId: productStockId,
    );
  }

  @override
  ProductStockAdjustmentFormControllerProvider getProviderOverride(
    covariant ProductStockAdjustmentFormControllerProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'productStockAdjustmentFormControllerProvider';
}

/// See also [ProductStockAdjustmentFormController].
class ProductStockAdjustmentFormControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        ProductStockAdjustmentFormController, ProductStockAdjustmentFormState> {
  /// See also [ProductStockAdjustmentFormController].
  ProductStockAdjustmentFormControllerProvider({
    String? id,
    String? productId,
    String? productStockId,
  }) : this._internal(
          () => ProductStockAdjustmentFormController()
            ..id = id
            ..productId = productId
            ..productStockId = productStockId,
          from: productStockAdjustmentFormControllerProvider,
          name: r'productStockAdjustmentFormControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productStockAdjustmentFormControllerHash,
          dependencies:
              ProductStockAdjustmentFormControllerFamily._dependencies,
          allTransitiveDependencies: ProductStockAdjustmentFormControllerFamily
              ._allTransitiveDependencies,
          id: id,
          productId: productId,
          productStockId: productStockId,
        );

  ProductStockAdjustmentFormControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.productId,
    required this.productStockId,
  }) : super.internal();

  final String? id;
  final String? productId;
  final String? productStockId;

  @override
  FutureOr<ProductStockAdjustmentFormState> runNotifierBuild(
    covariant ProductStockAdjustmentFormController notifier,
  ) {
    return notifier.build(
      id: id,
      productId: productId,
      productStockId: productStockId,
    );
  }

  @override
  Override overrideWith(
      ProductStockAdjustmentFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductStockAdjustmentFormControllerProvider._internal(
        () => create()
          ..id = id
          ..productId = productId
          ..productStockId = productStockId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        productId: productId,
        productStockId: productStockId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProductStockAdjustmentFormController,
      ProductStockAdjustmentFormState> createElement() {
    return _ProductStockAdjustmentFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductStockAdjustmentFormControllerProvider &&
        other.id == id &&
        other.productId == productId &&
        other.productStockId == productStockId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);
    hash = _SystemHash.combine(hash, productStockId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductStockAdjustmentFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<ProductStockAdjustmentFormState> {
  /// The parameter `id` of this provider.
  String? get id;

  /// The parameter `productId` of this provider.
  String? get productId;

  /// The parameter `productStockId` of this provider.
  String? get productStockId;
}

class _ProductStockAdjustmentFormControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        ProductStockAdjustmentFormController, ProductStockAdjustmentFormState>
    with ProductStockAdjustmentFormControllerRef {
  _ProductStockAdjustmentFormControllerProviderElement(super.provider);

  @override
  String? get id => (origin as ProductStockAdjustmentFormControllerProvider).id;
  @override
  String? get productId =>
      (origin as ProductStockAdjustmentFormControllerProvider).productId;
  @override
  String? get productStockId =>
      (origin as ProductStockAdjustmentFormControllerProvider).productStockId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
