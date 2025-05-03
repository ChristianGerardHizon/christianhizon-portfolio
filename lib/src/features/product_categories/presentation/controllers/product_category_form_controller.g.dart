// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productCategoryFormControllerHash() =>
    r'31728e638887fe02555e60ae3d2bd84789ec69c6';

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

abstract class _$ProductCategoryFormController
    extends BuildlessAutoDisposeAsyncNotifier<ProductCategoryFormState> {
  late final String? id;

  FutureOr<ProductCategoryFormState> build(
    String? id,
  );
}

/// See also [ProductCategoryFormController].
@ProviderFor(ProductCategoryFormController)
const productCategoryFormControllerProvider =
    ProductCategoryFormControllerFamily();

/// See also [ProductCategoryFormController].
class ProductCategoryFormControllerFamily
    extends Family<AsyncValue<ProductCategoryFormState>> {
  /// See also [ProductCategoryFormController].
  const ProductCategoryFormControllerFamily();

  /// See also [ProductCategoryFormController].
  ProductCategoryFormControllerProvider call(
    String? id,
  ) {
    return ProductCategoryFormControllerProvider(
      id,
    );
  }

  @override
  ProductCategoryFormControllerProvider getProviderOverride(
    covariant ProductCategoryFormControllerProvider provider,
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
  String? get name => r'productCategoryFormControllerProvider';
}

/// See also [ProductCategoryFormController].
class ProductCategoryFormControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ProductCategoryFormController,
        ProductCategoryFormState> {
  /// See also [ProductCategoryFormController].
  ProductCategoryFormControllerProvider(
    String? id,
  ) : this._internal(
          () => ProductCategoryFormController()..id = id,
          from: productCategoryFormControllerProvider,
          name: r'productCategoryFormControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productCategoryFormControllerHash,
          dependencies: ProductCategoryFormControllerFamily._dependencies,
          allTransitiveDependencies:
              ProductCategoryFormControllerFamily._allTransitiveDependencies,
          id: id,
        );

  ProductCategoryFormControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String? id;

  @override
  FutureOr<ProductCategoryFormState> runNotifierBuild(
    covariant ProductCategoryFormController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ProductCategoryFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductCategoryFormControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ProductCategoryFormController,
      ProductCategoryFormState> createElement() {
    return _ProductCategoryFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductCategoryFormControllerProvider && other.id == id;
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
mixin ProductCategoryFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<ProductCategoryFormState> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _ProductCategoryFormControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        ProductCategoryFormController,
        ProductCategoryFormState> with ProductCategoryFormControllerRef {
  _ProductCategoryFormControllerProviderElement(super.provider);

  @override
  String? get id => (origin as ProductCategoryFormControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
