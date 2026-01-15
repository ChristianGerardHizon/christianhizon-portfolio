// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for a single product by ID.

@ProviderFor(product)
final productProvider = ProductFamily._();

/// Provider for a single product by ID.

final class ProductProvider extends $FunctionalProvider<AsyncValue<Product?>,
        Product?, FutureOr<Product?>>
    with $FutureModifier<Product?>, $FutureProvider<Product?> {
  /// Provider for a single product by ID.
  ProductProvider._(
      {required ProductFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'productProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productHash();

  @override
  String toString() {
    return r'productProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Product?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Product?> create(Ref ref) {
    final argument = this.argument as String;
    return product(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProductProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productHash() => r'eb56e7ac87de53969478dce80bf91cfc4a8eb9ad';

/// Provider for a single product by ID.

final class ProductFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Product?>, String> {
  ProductFamily._()
      : super(
          retry: null,
          name: r'productProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for a single product by ID.

  ProductProvider call(
    String id,
  ) =>
      ProductProvider._(argument: id, from: this);

  @override
  String toString() => r'productProvider';
}
