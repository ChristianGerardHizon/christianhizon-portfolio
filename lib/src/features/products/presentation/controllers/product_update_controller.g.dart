// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_update_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productUpdateControllerHash() =>
    r'348f0ffb4469f75d7b3fe9af009a6dbb9da825c1';

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

abstract class _$ProductUpdateController
    extends BuildlessAutoDisposeAsyncNotifier<ProductUpdateState> {
  late final String id;

  FutureOr<ProductUpdateState> build(
    String id,
  );
}

/// See also [ProductUpdateController].
@ProviderFor(ProductUpdateController)
const productUpdateControllerProvider = ProductUpdateControllerFamily();

/// See also [ProductUpdateController].
class ProductUpdateControllerFamily
    extends Family<AsyncValue<ProductUpdateState>> {
  /// See also [ProductUpdateController].
  const ProductUpdateControllerFamily();

  /// See also [ProductUpdateController].
  ProductUpdateControllerProvider call(
    String id,
  ) {
    return ProductUpdateControllerProvider(
      id,
    );
  }

  @override
  ProductUpdateControllerProvider getProviderOverride(
    covariant ProductUpdateControllerProvider provider,
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
  String? get name => r'productUpdateControllerProvider';
}

/// See also [ProductUpdateController].
class ProductUpdateControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProductUpdateController,
        ProductUpdateState> {
  /// See also [ProductUpdateController].
  ProductUpdateControllerProvider(
    String id,
  ) : this._internal(
          () => ProductUpdateController()..id = id,
          from: productUpdateControllerProvider,
          name: r'productUpdateControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productUpdateControllerHash,
          dependencies: ProductUpdateControllerFamily._dependencies,
          allTransitiveDependencies:
              ProductUpdateControllerFamily._allTransitiveDependencies,
          id: id,
        );

  ProductUpdateControllerProvider._internal(
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
  FutureOr<ProductUpdateState> runNotifierBuild(
    covariant ProductUpdateController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ProductUpdateController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductUpdateControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ProductUpdateController,
      ProductUpdateState> createElement() {
    return _ProductUpdateControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductUpdateControllerProvider && other.id == id;
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
mixin ProductUpdateControllerRef
    on AutoDisposeAsyncNotifierProviderRef<ProductUpdateState> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductUpdateControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ProductUpdateController,
        ProductUpdateState> with ProductUpdateControllerRef {
  _ProductUpdateControllerProviderElement(super.provider);

  @override
  String get id => (origin as ProductUpdateControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
