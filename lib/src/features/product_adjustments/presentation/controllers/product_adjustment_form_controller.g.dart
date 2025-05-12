// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_adjustment_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productAdjustmentFormControllerHash() =>
    r'2fda13c1a21b62a5c418b11d06dd2ebe5bef69f1';

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

abstract class _$ProductAdjustmentFormController
    extends BuildlessAutoDisposeAsyncNotifier<ProductAdjustmentFormState> {
  late final String? id;
  late final String? productId;
  late final String? productStockId;

  FutureOr<ProductAdjustmentFormState> build({
    String? id,
    String? productId,
    String? productStockId,
  });
}

/// See also [ProductAdjustmentFormController].
@ProviderFor(ProductAdjustmentFormController)
const productAdjustmentFormControllerProvider =
    ProductAdjustmentFormControllerFamily();

/// See also [ProductAdjustmentFormController].
class ProductAdjustmentFormControllerFamily
    extends Family<AsyncValue<ProductAdjustmentFormState>> {
  /// See also [ProductAdjustmentFormController].
  const ProductAdjustmentFormControllerFamily();

  /// See also [ProductAdjustmentFormController].
  ProductAdjustmentFormControllerProvider call({
    String? id,
    String? productId,
    String? productStockId,
  }) {
    return ProductAdjustmentFormControllerProvider(
      id: id,
      productId: productId,
      productStockId: productStockId,
    );
  }

  @override
  ProductAdjustmentFormControllerProvider getProviderOverride(
    covariant ProductAdjustmentFormControllerProvider provider,
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
  String? get name => r'productAdjustmentFormControllerProvider';
}

/// See also [ProductAdjustmentFormController].
class ProductAdjustmentFormControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        ProductAdjustmentFormController, ProductAdjustmentFormState> {
  /// See also [ProductAdjustmentFormController].
  ProductAdjustmentFormControllerProvider({
    String? id,
    String? productId,
    String? productStockId,
  }) : this._internal(
          () => ProductAdjustmentFormController()
            ..id = id
            ..productId = productId
            ..productStockId = productStockId,
          from: productAdjustmentFormControllerProvider,
          name: r'productAdjustmentFormControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productAdjustmentFormControllerHash,
          dependencies: ProductAdjustmentFormControllerFamily._dependencies,
          allTransitiveDependencies:
              ProductAdjustmentFormControllerFamily._allTransitiveDependencies,
          id: id,
          productId: productId,
          productStockId: productStockId,
        );

  ProductAdjustmentFormControllerProvider._internal(
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
  FutureOr<ProductAdjustmentFormState> runNotifierBuild(
    covariant ProductAdjustmentFormController notifier,
  ) {
    return notifier.build(
      id: id,
      productId: productId,
      productStockId: productStockId,
    );
  }

  @override
  Override overrideWith(ProductAdjustmentFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductAdjustmentFormControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ProductAdjustmentFormController,
      ProductAdjustmentFormState> createElement() {
    return _ProductAdjustmentFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductAdjustmentFormControllerProvider &&
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
mixin ProductAdjustmentFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<ProductAdjustmentFormState> {
  /// The parameter `id` of this provider.
  String? get id;

  /// The parameter `productId` of this provider.
  String? get productId;

  /// The parameter `productStockId` of this provider.
  String? get productStockId;
}

class _ProductAdjustmentFormControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        ProductAdjustmentFormController,
        ProductAdjustmentFormState> with ProductAdjustmentFormControllerRef {
  _ProductAdjustmentFormControllerProviderElement(super.provider);

  @override
  String? get id => (origin as ProductAdjustmentFormControllerProvider).id;
  @override
  String? get productId =>
      (origin as ProductAdjustmentFormControllerProvider).productId;
  @override
  String? get productStockId =>
      (origin as ProductAdjustmentFormControllerProvider).productStockId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
