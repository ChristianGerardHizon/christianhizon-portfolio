// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_adjustment_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productAdjustmentControllerHash() =>
    r'1b8e7b5637173aebfa5ae402a7ac8f022e8a4af3';

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

abstract class _$ProductAdjustmentController
    extends BuildlessAutoDisposeAsyncNotifier<ProductAdjustment> {
  late final String id;

  FutureOr<ProductAdjustment> build(
    String id,
  );
}

/// See also [ProductAdjustmentController].
@ProviderFor(ProductAdjustmentController)
const productAdjustmentControllerProvider = ProductAdjustmentControllerFamily();

/// See also [ProductAdjustmentController].
class ProductAdjustmentControllerFamily
    extends Family<AsyncValue<ProductAdjustment>> {
  /// See also [ProductAdjustmentController].
  const ProductAdjustmentControllerFamily();

  /// See also [ProductAdjustmentController].
  ProductAdjustmentControllerProvider call(
    String id,
  ) {
    return ProductAdjustmentControllerProvider(
      id,
    );
  }

  @override
  ProductAdjustmentControllerProvider getProviderOverride(
    covariant ProductAdjustmentControllerProvider provider,
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
  String? get name => r'productAdjustmentControllerProvider';
}

/// See also [ProductAdjustmentController].
class ProductAdjustmentControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProductAdjustmentController,
        ProductAdjustment> {
  /// See also [ProductAdjustmentController].
  ProductAdjustmentControllerProvider(
    String id,
  ) : this._internal(
          () => ProductAdjustmentController()..id = id,
          from: productAdjustmentControllerProvider,
          name: r'productAdjustmentControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productAdjustmentControllerHash,
          dependencies: ProductAdjustmentControllerFamily._dependencies,
          allTransitiveDependencies:
              ProductAdjustmentControllerFamily._allTransitiveDependencies,
          id: id,
        );

  ProductAdjustmentControllerProvider._internal(
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
  FutureOr<ProductAdjustment> runNotifierBuild(
    covariant ProductAdjustmentController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ProductAdjustmentController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductAdjustmentControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ProductAdjustmentController,
      ProductAdjustment> createElement() {
    return _ProductAdjustmentControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductAdjustmentControllerProvider && other.id == id;
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
mixin ProductAdjustmentControllerRef
    on AutoDisposeAsyncNotifierProviderRef<ProductAdjustment> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductAdjustmentControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProductAdjustmentController,
        ProductAdjustment> with ProductAdjustmentControllerRef {
  _ProductAdjustmentControllerProviderElement(super.provider);

  @override
  String get id => (origin as ProductAdjustmentControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
